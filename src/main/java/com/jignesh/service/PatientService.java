package com.jignesh.service;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.Doctor;
import com.jignesh.entity.DoctorAvailability;
import com.jignesh.entity.Feedback;
import com.jignesh.entity.Patient;
import com.jignesh.entity.Prescription;
import com.jignesh.entity.User;
import com.jignesh.repository.AppointmentRepository;
import com.jignesh.repository.DoctorAvailabilityRepository;
import com.jignesh.repository.DoctorLeaveRepository;
import com.jignesh.repository.DoctorRepository;
import com.jignesh.repository.FeedbackRepository;
import com.jignesh.repository.PatientRepository;
import com.jignesh.repository.PrescriptionRepository;
import com.jignesh.repository.UserRepository;

@Service
public class PatientService {

	private final DoctorRepository doctorRepository;
	private final PatientRepository patientRepository;
	private final AppointmentRepository appointmentRepository;
	private final PrescriptionRepository prescriptionRepository;
	private final DoctorAvailabilityRepository availabilityRepository;
	private final DoctorLeaveRepository doctorLeaveRepository;
	private final FeedbackRepository feedbackRepository;
	private final MailService mailService;
	private final NotificationService notificationService;
	private final UserRepository userRepository;
	private final FileUploadService fileUploadService;
	private final AppointmentHistoryService appointmentHistoryService;

	public PatientService(DoctorRepository doctorRepository, PatientRepository patientRepository,
			AppointmentRepository appointmentRepository, PrescriptionRepository prescriptionRepository,
			DoctorAvailabilityRepository availabilityRepository, DoctorLeaveRepository doctorLeaveRepository,
			FeedbackRepository feedbackRepository, MailService mailService, NotificationService notificationService,
			UserRepository userRepository, FileUploadService fileUploadService,
			AppointmentHistoryService appointmentHistoryService) {
		this.doctorRepository = doctorRepository;
		this.patientRepository = patientRepository;
		this.appointmentRepository = appointmentRepository;
		this.prescriptionRepository = prescriptionRepository;
		this.availabilityRepository = availabilityRepository;
		this.doctorLeaveRepository = doctorLeaveRepository;
		this.feedbackRepository = feedbackRepository;
		this.mailService = mailService;
		this.notificationService = notificationService;
		this.userRepository = userRepository;
		this.fileUploadService = fileUploadService;
		this.appointmentHistoryService = appointmentHistoryService;
	}

	public Patient getMyProfile(User user) {
		return patientRepository.findByUser(user).orElse(null);
	}

	public String updateMyProfile(User user, String name, String phone, Integer age, String gender, String address,
			MultipartFile profileImage) {
		Patient patient = patientRepository.findByUser(user).orElse(null);
		if (patient == null)
			return "Patient profile not found";

		patient.getUser().setName(name);
		patient.setPhone(phone);
		patient.setAge(age);
		patient.setGender(gender);
		patient.setAddress(address);

		try {
			if (profileImage != null && !profileImage.isEmpty()) {
				String oldImage = patient.getProfileImage();
				String fileName = fileUploadService.saveImage(profileImage);
				patient.setProfileImage(fileName);
				if (oldImage != null && !oldImage.isBlank()) {
					fileUploadService.deleteImage(oldImage);
				}
			}
		} catch (IllegalArgumentException e) {
			return e.getMessage();
		} catch (IOException e) {
			return "Image upload failed";
		}

		userRepository.save(patient.getUser());
		patientRepository.save(patient);
		return "success";
	}

	public long getPatientTotalAppointments(User user) {
		Patient p = patientRepository.findByUser(user).orElse(null);
		return p == null ? 0 : appointmentRepository.countByPatient(p);
	}

	public long getPatientPendingAppointments(User user) {
		Patient p = patientRepository.findByUser(user).orElse(null);
		return p == null ? 0 : appointmentRepository.countByPatientAndStatus(p, "PENDING");
	}

	public long getPatientApprovedAppointments(User user) {
		Patient p = patientRepository.findByUser(user).orElse(null);
		return p == null ? 0 : appointmentRepository.countByPatientAndStatus(p, "APPROVED");
	}

	public long getPatientCompletedAppointments(User user) {
		Patient p = patientRepository.findByUser(user).orElse(null);
		return p == null ? 0 : appointmentRepository.countByPatientAndStatus(p, "COMPLETED");
	}

	public long getPatientCancelledAppointments(User user) {
		Patient p = patientRepository.findByUser(user).orElse(null);
		return p == null ? 0 : appointmentRepository.countByPatientAndStatus(p, "CANCELLED");
	}

	public List<Doctor> getAllDoctors() {
		return doctorRepository.findAll().stream().filter(this::isDoctorActive).toList();
	}

	public List<Doctor> searchDoctors(String keyword, String specialization) {
		return doctorRepository.findAll().stream().filter(this::isDoctorActive).filter(doctor -> {
			boolean specializationMatch = true;
			boolean keywordMatch = true;

			if (specialization != null && !specialization.isBlank()) {
				specializationMatch = doctor.getSpecialization() != null
						&& doctor.getSpecialization().equalsIgnoreCase(specialization);
			}

			if (keyword != null && !keyword.isBlank()) {
				String key = keyword.toLowerCase();

				String doctorName = doctor.getUser() != null && doctor.getUser().getName() != null
						? doctor.getUser().getName().toLowerCase()
						: "";

				String city = doctor.getCity() != null ? doctor.getCity().toLowerCase() : "";
				String doctorSpecialization = doctor.getSpecialization() != null
						? doctor.getSpecialization().toLowerCase()
						: "";

				keywordMatch = doctorName.contains(key) || city.contains(key) || doctorSpecialization.contains(key);
			}

			return specializationMatch && keywordMatch;
		}).toList();
	}

	public Doctor getDoctorById(Long doctorId) {
		Doctor doctor = doctorRepository.findById(doctorId).orElse(null);

		if (!isDoctorActive(doctor)) {
			return null;
		}

		return doctor;
	}

	public List<DoctorAvailability> getAvailableSlots(Long doctorId) {
		Doctor doctor = getDoctorById(doctorId);

		if (doctor == null) {
			return List.of();
		}

		return availabilityRepository.findByDoctorAndSlotStatusOrderByAvailableDateAscStartTimeAsc(doctor, "AVAILABLE")
				.stream()
				.filter(slot -> !doctorLeaveRepository.existsByDoctorAndLeaveDate(doctor, slot.getAvailableDate()))
				.toList();
	}

	public List<DoctorAvailability> getRescheduleSlots(User user, Long appointmentId) {
		Patient patient = patientRepository.findByUser(user).orElse(null);
		if (patient == null)
			return List.of();
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null || !appointment.getPatient().getId().equals(patient.getId())
				|| appointment.getDoctor() == null)
			return List.of();
		Doctor doctor = appointment.getDoctor();
		return availabilityRepository.findByDoctorAndSlotStatusOrderByAvailableDateAscStartTimeAsc(doctor, "AVAILABLE")
				.stream()
				.filter(slot -> !doctorLeaveRepository.existsByDoctorAndLeaveDate(doctor, slot.getAvailableDate()))
				.toList();
	}

	public String bookAppointment(User user, Long doctorId, Long slotId, String reason) {
		Patient patient = patientRepository.findByUser(user).orElse(null);
		if (patient == null)
			return "Patient profile not found";
		Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
		if (doctor == null) {
			return "Doctor not found";
		}

		if (!isDoctorActive(doctor)) {
			return "Doctor is not approved yet";
		}
		DoctorAvailability slot = availabilityRepository.findById(slotId).orElse(null);
		if (slot == null)
			return "Slot not found";
		if (doctorLeaveRepository.existsByDoctorAndLeaveDate(doctor, slot.getAvailableDate()))
			return "Doctor is unavailable on selected date";
		if (!"AVAILABLE".equals(slot.getSlotStatus()))
			return "This slot is already booked";

		LocalDate date = slot.getAvailableDate();
		LocalTime time = slot.getStartTime();
		boolean alreadyBooked = appointmentRepository
				.existsByDoctorIdAndAppointmentDateAndAppointmentTimeAndStatusNot(doctorId, date, time, "CANCELLED");
		if (alreadyBooked)
			return "This time slot is already booked. Please select another slot.";

		Appointment appointment = new Appointment();
		appointment.setPatient(patient);
		appointment.setDoctor(doctor);
		appointment.setAppointmentDate(date);
		appointment.setAppointmentTime(time);
		appointment.setReason(reason);
		appointment.setStatus("PENDING");
		appointmentRepository.save(appointment);

		appointmentHistoryService.logHistory(appointment, "CREATED", "PATIENT", null, "PENDING", null, null, date, time,
				"Patient created appointment");

		slot.setSlotStatus("BOOKED");
		availabilityRepository.save(slot);

		mailService.sendAppointmentBookedEmailToPatient(appointment);
		mailService.sendAppointmentBookedEmailToAdmin(appointment);

		notificationService.createNotification(patient.getUser(), "Appointment Request Sent",
				"Your appointment with Dr. " + (doctor.getUser() != null ? doctor.getUser().getName() : "Doctor")
						+ " on " + date + " at " + time + " is waiting for admin approval.",
				"INFO");
		notificationService.notifyAdmin("New Appointment Booked", patient.getUser().getName()
				+ " booked an appointment with Dr. " + doctor.getUser().getName() + " on " + date + " at " + time + ".",
				"INFO");
		if (doctor.getUser() != null) {
			notificationService.createNotification(doctor.getUser(), "New Appointment Request",
					"A patient booked an appointment on " + date + " at " + time + ".", "INFO");
		}
		return "success";
	}

	public List<Appointment> getMyAppointments(User user) {
		Patient patient = patientRepository.findByUser(user).orElse(null);
		return patient == null ? List.of() : appointmentRepository.findByPatientOrderByCreatedAtDesc(patient);
	}

	public String cancelAppointment(Long appointmentId) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null)
			return "Appointment not found";
		if ("COMPLETED".equals(appointment.getStatus()))
			return "Completed appointment cannot be cancelled";
		if ("REJECTED".equals(appointment.getStatus()))
			return "Rejected appointment cannot be cancelled";

		String oldStatus = appointment.getStatus();
		appointment.setStatus("CANCELLED");
		appointmentRepository.save(appointment);

		appointmentHistoryService.logHistory(appointment, "CANCELLED", "PATIENT", oldStatus, "CANCELLED",
				appointment.getAppointmentDate(), appointment.getAppointmentTime(), appointment.getAppointmentDate(),
				appointment.getAppointmentTime(), "Patient cancelled appointment");

		if (appointment.getPatient() != null && appointment.getPatient().getUser() != null) {
			notificationService.createNotification(appointment.getPatient().getUser(), "Appointment Cancelled",
					"Your appointment on " + appointment.getAppointmentDate() + " at "
							+ appointment.getAppointmentTime() + " has been cancelled.",
					"WARNING");
		}
		if (appointment.getDoctor() != null && appointment.getDoctor().getUser() != null) {
			notificationService.createNotification(appointment.getDoctor().getUser(), "Appointment Cancelled",
					"A patient cancelled the appointment on " + appointment.getAppointmentDate() + " at "
							+ appointment.getAppointmentTime() + ".",
					"WARNING");
		}
		notificationService.notifyAdmin("Appointment Cancelled", "An appointment on " + appointment.getAppointmentDate()
				+ " at " + appointment.getAppointmentTime() + " has been cancelled.", "WARNING");
		return "success";
	}

	public String rescheduleAppointment(User user, Long appointmentId, Long newSlotId) {
		Patient patient = patientRepository.findByUser(user).orElse(null);
		if (patient == null)
			return "Patient profile not found";
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null)
			return "Appointment not found";
		if (!appointment.getPatient().getId().equals(patient.getId()))
			return "You cannot reschedule this appointment";
		if ("COMPLETED".equals(appointment.getStatus()))
			return "Completed appointment cannot be rescheduled";
		if ("CANCELLED".equals(appointment.getStatus()))
			return "Cancelled appointment cannot be rescheduled";
		if ("REJECTED".equals(appointment.getStatus()))
			return "Rejected appointment cannot be rescheduled";

		Doctor doctor = appointment.getDoctor();
		if (doctor == null)
			return "Doctor not found";
		DoctorAvailability newSlot = availabilityRepository.findById(newSlotId).orElse(null);
		if (newSlot == null)
			return "New slot not found";
		if (!newSlot.getDoctor().getId().equals(doctor.getId()))
			return "Please select slot of the same doctor";
		if (doctorLeaveRepository.existsByDoctorAndLeaveDate(doctor, newSlot.getAvailableDate()))
			return "Doctor is unavailable on selected date";
		if (!"AVAILABLE".equals(newSlot.getSlotStatus()))
			return "Selected slot is not available";

		boolean alreadyBooked = appointmentRepository.existsByDoctorIdAndAppointmentDateAndAppointmentTimeAndStatusNot(
				doctor.getId(), newSlot.getAvailableDate(), newSlot.getStartTime(), "CANCELLED");
		if (alreadyBooked)
			return "Selected slot is already booked";

		LocalDate oldDate = appointment.getAppointmentDate();
		LocalTime oldTime = appointment.getAppointmentTime();
		String oldStatus = appointment.getStatus();

		DoctorAvailability oldSlot = availabilityRepository.findByDoctorAndAvailableDateAndStartTime(doctor,
				appointment.getAppointmentDate(), appointment.getAppointmentTime()).orElse(null);
		if (oldSlot != null && !oldSlot.getId().equals(newSlot.getId())) {
			oldSlot.setSlotStatus("AVAILABLE");
			availabilityRepository.save(oldSlot);
		}

		appointment.setAppointmentDate(newSlot.getAvailableDate());
		appointment.setAppointmentTime(newSlot.getStartTime());
		appointment.setStatus("PENDING");
		appointmentRepository.save(appointment);

		newSlot.setSlotStatus("BOOKED");
		availabilityRepository.save(newSlot);

		appointmentHistoryService.logHistory(appointment, "RESCHEDULED", "PATIENT", oldStatus, "PENDING", oldDate,
				oldTime, newSlot.getAvailableDate(), newSlot.getStartTime(), "Patient rescheduled appointment");

		notificationService.createNotification(
				patient.getUser(), "Appointment Rescheduled", "Your appointment has been rescheduled to "
						+ newSlot.getAvailableDate() + " at " + newSlot.getStartTime() + ". Status is now PENDING.",
				"INFO");
		if (doctor.getUser() != null) {
			notificationService.createNotification(doctor.getUser(), "Appointment Rescheduled",
					"A patient rescheduled an appointment to " + newSlot.getAvailableDate() + " at "
							+ newSlot.getStartTime() + ".",
					"INFO");
		}
		notificationService.notifyAdmin("Appointment Rescheduled",
				patient.getUser().getName() + " rescheduled appointment with Dr. " + doctor.getUser().getName() + " to "
						+ newSlot.getAvailableDate() + " at " + newSlot.getStartTime() + ".",
				"INFO");
		return "success";
	}

	public Prescription getPrescriptionByAppointmentId(Long appointmentId) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		return appointment == null ? null : prescriptionRepository.findByAppointment(appointment).orElse(null);
	}

	private boolean isDoctorActive(Doctor doctor) {
		if (doctor == null || doctor.getUser() == null) {
			return false;
		}

		String status = doctor.getUser().getAccountStatus();

		if (status == null || status.isBlank()) {
			return true;
		}

		return status.equalsIgnoreCase("ACTIVE");
	}

	public Appointment getAppointmentById(Long appointmentId) {
		return appointmentRepository.findById(appointmentId).orElse(null);
	}

	public Feedback getFeedbackByAppointmentId(Long appointmentId) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		return appointment == null ? null : feedbackRepository.findByAppointment(appointment).orElse(null);
	}

	public String saveFeedback(User user, Long appointmentId, Integer rating, String comment) {
		Patient patient = patientRepository.findByUser(user).orElse(null);
		if (patient == null)
			return "Patient profile not found";
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null)
			return "Appointment not found";
		if (!appointment.getPatient().getId().equals(patient.getId()))
			return "You cannot give feedback for this appointment";
		if (!"COMPLETED".equals(appointment.getStatus()))
			return "Feedback can only be given after appointment is completed";
		if (rating == null || rating < 1 || rating > 5)
			return "Rating must be between 1 and 5";

		Feedback feedback = feedbackRepository.findByAppointment(appointment).orElse(new Feedback());
		feedback.setAppointment(appointment);
		feedback.setPatient(patient);
		feedback.setDoctor(appointment.getDoctor());
		feedback.setRating(rating);
		feedback.setComment(comment);
		feedbackRepository.save(feedback);

		if (appointment.getDoctor() != null && appointment.getDoctor().getUser() != null) {
			notificationService.createNotification(appointment.getDoctor().getUser(), "New Patient Feedback",
					"You received a new feedback rating of " + rating + " stars.", "SUCCESS");
		}
		return "success";
	}
}
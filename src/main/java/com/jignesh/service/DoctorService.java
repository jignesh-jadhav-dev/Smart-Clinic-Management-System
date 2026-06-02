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
import com.jignesh.entity.DoctorLeave;
import com.jignesh.entity.Feedback;
import com.jignesh.entity.Prescription;
import com.jignesh.entity.User;
import com.jignesh.repository.AppointmentRepository;
import com.jignesh.repository.DoctorAvailabilityRepository;
import com.jignesh.repository.DoctorLeaveRepository;
import com.jignesh.repository.DoctorRepository;
import com.jignesh.repository.FeedbackRepository;
import com.jignesh.repository.PrescriptionRepository;
import com.jignesh.repository.UserRepository;

@Service
public class DoctorService {

	private final DoctorRepository doctorRepository;
	private final AppointmentRepository appointmentRepository;
	private final PrescriptionRepository prescriptionRepository;
	private final DoctorAvailabilityRepository availabilityRepository;
	private final DoctorLeaveRepository doctorLeaveRepository;
	private final FeedbackRepository feedbackRepository;
	private final NotificationService notificationService;
	private final UserRepository userRepository;
	private final FileUploadService fileUploadService;
	private final AppointmentHistoryService appointmentHistoryService;

	public DoctorService(DoctorRepository doctorRepository, AppointmentRepository appointmentRepository,
			PrescriptionRepository prescriptionRepository, DoctorAvailabilityRepository availabilityRepository,
			DoctorLeaveRepository doctorLeaveRepository, FeedbackRepository feedbackRepository,
			NotificationService notificationService, UserRepository userRepository, FileUploadService fileUploadService,
			AppointmentHistoryService appointmentHistoryService) {
		this.doctorRepository = doctorRepository;
		this.appointmentRepository = appointmentRepository;
		this.prescriptionRepository = prescriptionRepository;
		this.availabilityRepository = availabilityRepository;
		this.doctorLeaveRepository = doctorLeaveRepository;
		this.feedbackRepository = feedbackRepository;
		this.notificationService = notificationService;
		this.userRepository = userRepository;
		this.fileUploadService = fileUploadService;
		this.appointmentHistoryService = appointmentHistoryService;
	}

	public Doctor getDoctorByUser(User user) {
		return doctorRepository.findByUser(user).orElse(null);
	}

	public Doctor getMyProfile(User user) {
		return getDoctorByUser(user);
	}

	public String updateMyProfile(User user, String name, String specialization, String qualification,
			Integer experience, Double consultationFee, String city, MultipartFile profileImage) {
		Doctor doctor = getDoctorByUser(user);
		if (doctor == null)
			return "Doctor profile not found";

		doctor.getUser().setName(name);
		doctor.setSpecialization(specialization);
		doctor.setQualification(qualification);
		doctor.setExperience(experience);
		doctor.setConsultationFee(consultationFee);
		doctor.setCity(city);

		try {
			if (profileImage != null && !profileImage.isEmpty()) {
				String oldImage = doctor.getProfileImage();
				String fileName = fileUploadService.saveImage(profileImage);
				doctor.setProfileImage(fileName);
				if (oldImage != null && !oldImage.isBlank()) {
					fileUploadService.deleteImage(oldImage);
				}
			}
		} catch (IllegalArgumentException e) {
			return e.getMessage();
		} catch (IOException e) {
			return "Image upload failed";
		}

		userRepository.save(doctor.getUser());
		doctorRepository.save(doctor);
		return "success";
	}

	public long getDoctorTotalAppointments(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? 0 : appointmentRepository.countByDoctor(doctor);
	}

	public long getDoctorApprovedAppointments(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? 0 : appointmentRepository.countByDoctorAndStatus(doctor, "APPROVED");
	}

	public long getDoctorCompletedAppointments(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? 0 : appointmentRepository.countByDoctorAndStatus(doctor, "COMPLETED");
	}

	public long getDoctorTotalFeedbacks(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? 0 : feedbackRepository.countByDoctor(doctor);
	}

	public Double getDoctorAverageRating(User user) {
		Doctor doctor = getDoctorByUser(user);
		if (doctor == null)
			return 0.0;
		Double avg = feedbackRepository.findAverageRatingByDoctor(doctor);
		return avg == null ? 0.0 : Math.round(avg * 10.0) / 10.0;
	}

	public long getDoctorAvailableSlotCount(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? 0 : availabilityRepository.countByDoctorAndSlotStatus(doctor, "AVAILABLE");
	}

	public long getDoctorLeaveCount(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? 0 : doctorLeaveRepository.countByDoctor(doctor);
	}

	public List<Appointment> getMyAppointments(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? List.of() : appointmentRepository.findByDoctorOrderByCreatedAtDesc(doctor);
	}

	public Appointment getAppointmentById(Long id) {
		return appointmentRepository.findById(id).orElse(null);
	}

	public String markCompleted(Long appointmentId) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null)
			return "Appointment not found";

		String oldStatus = appointment.getStatus();
		appointment.setStatus("COMPLETED");
		appointmentRepository.save(appointment);

		appointmentHistoryService.logHistory(appointment, "COMPLETED", "DOCTOR", oldStatus, "COMPLETED",
				appointment.getAppointmentDate(), appointment.getAppointmentTime(), appointment.getAppointmentDate(),
				appointment.getAppointmentTime(), "Doctor marked appointment as completed");

		if (appointment.getPatient() != null && appointment.getPatient().getUser() != null) {
			notificationService.createNotification(appointment.getPatient().getUser(), "Appointment Completed",
					"Your appointment on " + appointment.getAppointmentDate() + " at "
							+ appointment.getAppointmentTime() + " has been marked completed.",
					"SUCCESS");
		}
		return "success";
	}

	public String addPrescription(Long appointmentId, String medicine, String advice, String nextVisitDate) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null)
			return "Appointment not found";

		String oldStatus = appointment.getStatus();
		Prescription prescription = prescriptionRepository.findByAppointment(appointment).orElse(new Prescription());
		prescription.setAppointment(appointment);
		prescription.setMedicine(medicine);
		prescription.setAdvice(advice);
		if (nextVisitDate != null && !nextVisitDate.isBlank()) {
			prescription.setNextVisitDate(LocalDate.parse(nextVisitDate));
		}
		prescriptionRepository.save(prescription);

		appointment.setStatus("COMPLETED");
		appointmentRepository.save(appointment);

		appointmentHistoryService.logHistory(appointment, "PRESCRIPTION_ADDED", "DOCTOR", oldStatus, "COMPLETED",
				appointment.getAppointmentDate(), appointment.getAppointmentTime(), appointment.getAppointmentDate(),
				appointment.getAppointmentTime(), "Doctor added prescription and completed appointment");

		if (appointment.getPatient() != null && appointment.getPatient().getUser() != null) {
			notificationService.createNotification(appointment.getPatient().getUser(), "Prescription Added",
					"Your prescription has been added by doctor. Please check your completed appointment.", "SUCCESS");
		}
		return "success";
	}

	public String addAvailability(User user, String date, String startTime, String endTime, Integer slotMinutes) {
		Doctor doctor = getDoctorByUser(user);
		if (doctor == null)
			return "Doctor profile not found";
		if (date == null || date.isBlank())
			return "Date is required";
		if (startTime == null || startTime.isBlank())
			return "Start time is required";
		if (endTime == null || endTime.isBlank())
			return "End time is required";

		int interval = (slotMinutes == null ? 30 : slotMinutes);
		if (interval != 15 && interval != 30 && interval != 60)
			return "Slot interval must be 15, 30 or 60 minutes";

		LocalDate availableDate = LocalDate.parse(date);
		LocalTime start = LocalTime.parse(startTime);
		LocalTime end = LocalTime.parse(endTime);

		if (doctorLeaveRepository.existsByDoctorAndLeaveDate(doctor, availableDate)) {
			return "You already marked this date as unavailable/leave";
		}
		if (!end.isAfter(start))
			return "End time must be after start time";
		if (start.plusMinutes(interval).isAfter(end))
			return "Selected time range is too small for the chosen interval";

		int createdCount = 0;
		LocalTime currentStart = start;
		while (!currentStart.plusMinutes(interval).isAfter(end)) {
			LocalTime currentEnd = currentStart.plusMinutes(interval);
			boolean exists = availabilityRepository.existsByDoctorAndAvailableDateAndStartTimeAndEndTime(doctor,
					availableDate, currentStart, currentEnd);
			if (!exists) {
				DoctorAvailability availability = new DoctorAvailability();
				availability.setDoctor(doctor);
				availability.setAvailableDate(availableDate);
				availability.setStartTime(currentStart);
				availability.setEndTime(currentEnd);
				availability.setSlotStatus("AVAILABLE");
				availabilityRepository.save(availability);
				createdCount++;
			}
			currentStart = currentEnd;
		}
		return createdCount == 0 ? "No new slots added. These slots may already exist."
				: "success:" + createdCount + " slots added successfully.";
	}

	public List<DoctorAvailability> getMyAvailability(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? List.of()
				: availabilityRepository.findByDoctorOrderByAvailableDateAscStartTimeAsc(doctor);
	}

	public void deleteAvailability(Long id) {
		availabilityRepository.deleteById(id);
	}

	public List<Feedback> getMyFeedbacks(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? List.of() : feedbackRepository.findByDoctorOrderByCreatedAtDesc(doctor);
	}

	public List<DoctorLeave> getMyLeaves(User user) {
		Doctor doctor = getDoctorByUser(user);
		return doctor == null ? List.of() : doctorLeaveRepository.findByDoctorOrderByLeaveDateAsc(doctor);
	}

	public String addLeave(User user, String leaveDate, String reason) {
		Doctor doctor = getDoctorByUser(user);
		if (doctor == null)
			return "Doctor profile not found";
		if (leaveDate == null || leaveDate.isBlank())
			return "Leave date is required";
		LocalDate parsedDate = LocalDate.parse(leaveDate);
		if (doctorLeaveRepository.existsByDoctorAndLeaveDate(doctor, parsedDate))
			return "Leave already added for this date";
		DoctorLeave leave = new DoctorLeave();
		leave.setDoctor(doctor);
		leave.setLeaveDate(parsedDate);
		leave.setReason(reason);
		doctorLeaveRepository.save(leave);
		availabilityRepository.deleteByDoctorAndAvailableDateAndSlotStatus(doctor, parsedDate, "AVAILABLE");
		return "success";
	}

	public void deleteLeave(Long leaveId) {
		doctorLeaveRepository.deleteById(leaveId);
	}
}
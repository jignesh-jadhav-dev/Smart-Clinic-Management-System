package com.jignesh.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.AppointmentHistory;
import com.jignesh.entity.Doctor;
import com.jignesh.entity.Patient;
import com.jignesh.entity.User;
import com.jignesh.repository.AppointmentRepository;
import com.jignesh.repository.DoctorAvailabilityRepository;
import com.jignesh.repository.DoctorLeaveRepository;
import com.jignesh.repository.DoctorRepository;
import com.jignesh.repository.FeedbackRepository;
import com.jignesh.repository.PatientRepository;
import com.jignesh.repository.UserRepository;

@Service
public class AdminService {

	private final UserRepository userRepository;
	private final DoctorRepository doctorRepository;
	private final AppointmentRepository appointmentRepository;
	private final PatientRepository patientRepository;
	private final FeedbackRepository feedbackRepository;
	private final DoctorAvailabilityRepository availabilityRepository;
	private final DoctorLeaveRepository doctorLeaveRepository;
	private final PasswordEncoder passwordEncoder;
	private final MailService mailService;
	private final NotificationService notificationService;
	private final AppointmentHistoryService appointmentHistoryService;

	public AdminService(UserRepository userRepository, DoctorRepository doctorRepository,
			AppointmentRepository appointmentRepository, PatientRepository patientRepository,
			FeedbackRepository feedbackRepository, DoctorAvailabilityRepository availabilityRepository,
			DoctorLeaveRepository doctorLeaveRepository, PasswordEncoder passwordEncoder, MailService mailService,
			NotificationService notificationService, AppointmentHistoryService appointmentHistoryService) {
		this.userRepository = userRepository;
		this.doctorRepository = doctorRepository;
		this.appointmentRepository = appointmentRepository;
		this.patientRepository = patientRepository;
		this.feedbackRepository = feedbackRepository;
		this.availabilityRepository = availabilityRepository;
		this.doctorLeaveRepository = doctorLeaveRepository;
		this.passwordEncoder = passwordEncoder;
		this.mailService = mailService;
		this.notificationService = notificationService;
		this.appointmentHistoryService = appointmentHistoryService;
	}

	public String addDoctor(String name, String email, String password, String specialization, String qualification,
			Integer experience, Double consultationFee, String city) {
		if (userRepository.findByEmail(email).isPresent()) {
			return "Email already exists";
		}
		User user = new User();
		user.setName(name);
		user.setEmail(email);
		user.setPassword(passwordEncoder.encode(password));
		user.setRole("DOCTOR");
		user.setAccountStatus("ACTIVE");
		User savedUser = userRepository.save(user);

		Doctor doctor = new Doctor();
		doctor.setUser(savedUser);
		doctor.setSpecialization(specialization);
		doctor.setQualification(qualification);
		doctor.setExperience(experience);
		doctor.setConsultationFee(consultationFee);
		doctor.setCity(city);
		doctor.setProfileImage("default-doctor.png");
		doctorRepository.save(doctor);
		return "success";
	}

	public String addPatient(String name, String email, String password, String phone, Integer age, String gender,
			String address) {

		if (userRepository.findByEmail(email).isPresent()) {
			return "Email already exists";
		}

		User user = new User();
		user.setName(name);
		user.setEmail(email);
		user.setPassword(passwordEncoder.encode(password));
		user.setRole("PATIENT");
		user.setAccountStatus("ACTIVE");

		User savedUser = userRepository.save(user);

		Patient patient = new Patient();
		patient.setUser(savedUser);
		patient.setPhone(phone);
		patient.setAge(age);
		patient.setGender(gender);
		patient.setAddress(address);
		patient.setProfileImage("default-patient.png");

		patientRepository.save(patient);

		return "success";
	}

	public String approveDoctor(Long doctorId) {
		Doctor doctor = doctorRepository.findById(doctorId).orElse(null);

		if (doctor == null) {
			return "Doctor not found";
		}

		if (doctor.getUser() == null) {
			return "Doctor user not found";
		}

		doctor.getUser().setAccountStatus("ACTIVE");
		userRepository.save(doctor.getUser());

		return "success";
	}

	public Page<Doctor> getDoctorsPage(int page, String keyword) {
		Pageable pageable = PageRequest.of(page, 5);
		if (keyword != null && !keyword.trim().isEmpty()) {
			return doctorRepository
					.findByUser_NameContainingIgnoreCaseOrUser_EmailContainingIgnoreCaseOrSpecializationContainingIgnoreCaseOrCityContainingIgnoreCase(
							keyword, keyword, keyword, keyword, pageable);
		}
		return doctorRepository.findAll(pageable);
	}

	public Page<Patient> getPatientsPage(int page, String keyword) {
		Pageable pageable = PageRequest.of(page, 5);
		if (keyword != null && !keyword.trim().isEmpty()) {
			return patientRepository
					.findByUser_NameContainingIgnoreCaseOrUser_EmailContainingIgnoreCaseOrPhoneContainingIgnoreCaseOrAddressContainingIgnoreCase(
							keyword, keyword, keyword, keyword, pageable);
		}
		return patientRepository.findAll(pageable);
	}

	public Page<Appointment> getAppointmentsPage(int page, String keyword, String status, String sortBy) {
		Pageable pageable = buildAppointmentPageable(page, sortBy);
		if ((keyword != null && !keyword.trim().isEmpty()) || (status != null && !status.trim().isEmpty())) {
			return appointmentRepository.searchAppointments(keyword, status, pageable);
		}
		return appointmentRepository.findAll(pageable);
	}

	private Pageable buildAppointmentPageable(int page, String sortBy) {
		Sort sort;
		if ("oldest".equals(sortBy)) {
			sort = Sort.by("createdAt").ascending();
		} else if ("dateAsc".equals(sortBy)) {
			sort = Sort.by("appointmentDate").ascending().and(Sort.by("appointmentTime").ascending());
		} else if ("dateDesc".equals(sortBy)) {
			sort = Sort.by("appointmentDate").descending().and(Sort.by("appointmentTime").descending());
		} else if ("status".equals(sortBy)) {
			sort = Sort.by("status").ascending().and(Sort.by("appointmentDate").descending());
		} else {
			sort = Sort.by("createdAt").descending();
		}
		return PageRequest.of(page, 5, sort);
	}

	public Appointment getAppointmentById(Long id) {
		return appointmentRepository.findById(id).orElse(null);
	}

	public List<AppointmentHistory> getAppointmentHistory(Long appointmentId) {
		return appointmentHistoryService.getHistoryByAppointmentId(appointmentId);
	}

	public List<Doctor> getAllDoctorsForExport() {
		return doctorRepository.findAll();
	}

	public List<Patient> getAllPatientsForExport() {
		return patientRepository.findAll();
	}

	public List<Appointment> getAllAppointmentsForExport() {
		return appointmentRepository.findAllByOrderByCreatedAtDesc();
	}

	public String deleteDoctor(Long doctorId) {
		Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
		if (doctor == null) {
			return "Doctor not found";
		}
		if (appointmentRepository.existsByDoctor(doctor)) {
			return "Doctor cannot be deleted because appointments exist";
		}
		User user = doctor.getUser();
		availabilityRepository.deleteByDoctor(doctor);
		doctorLeaveRepository.deleteByDoctor(doctor);
		doctorRepository.delete(doctor);
		if (user != null) {
			userRepository.delete(user);
		}
		return "success";
	}

	public String deletePatient(Long patientId) {
		Patient patient = patientRepository.findById(patientId).orElse(null);
		if (patient == null) {
			return "Patient not found";
		}
		if (appointmentRepository.existsByPatient(patient)) {
			return "Patient cannot be deleted because appointments exist";
		}
		User user = patient.getUser();
		patientRepository.delete(patient);
		if (user != null) {
			userRepository.delete(user);
		}
		return "success";
	}

	public String updateAppointmentStatus(Long appointmentId, String status) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null) {
			return "Appointment not found";
		}

		String oldStatus = appointment.getStatus();
		LocalDate oldDate = appointment.getAppointmentDate();
		LocalTime oldTime = appointment.getAppointmentTime();

		appointment.setStatus(status);
		appointmentRepository.save(appointment);

		appointmentHistoryService.logHistory(appointment, "STATUS_CHANGED", "ADMIN", oldStatus, status, oldDate,
				oldTime, appointment.getAppointmentDate(), appointment.getAppointmentTime(),
				"Admin updated appointment status");

		mailService.sendAppointmentStatusEmailToPatient(appointment);
		mailService.sendAppointmentStatusEmailToDoctor(appointment);

		if (appointment.getPatient() != null && appointment.getPatient().getUser() != null) {
			notificationService.createNotification(appointment.getPatient().getUser(), "Appointment Status Updated",
					"Your appointment status is now " + appointment.getStatus() + ".", "INFO");
		}

		if (appointment.getDoctor() != null && appointment.getDoctor().getUser() != null) {
			notificationService.createNotification(appointment.getDoctor().getUser(), "Appointment Status Updated",
					"Appointment status is now " + appointment.getStatus() + ".", "INFO");
		}

		notificationService.notifyAdmin("Appointment Status Changed",
				"Appointment #" + appointment.getId() + " status changed to " + appointment.getStatus() + ".", "INFO");
		return "success";
	}

	public List<Long> getMonthlyAppointmentCounts(int year) {
		return mapMonthCounts(appointmentRepository.countAppointmentsMonthWise(year));
	}

	public List<Long> getMonthlyCompletedCounts(int year) {
		return mapMonthCounts(appointmentRepository.countCompletedAppointmentsMonthWise(year));
	}

	private List<Long> mapMonthCounts(List<Object[]> rawData) {
		List<Long> counts = new ArrayList<>();
		for (int i = 0; i < 12; i++) {
			counts.add(0L);
		}
		for (Object[] row : rawData) {
			int month = ((Number) row[0]).intValue();
			long total = ((Number) row[1]).longValue();
			if (month >= 1 && month <= 12) {
				counts.set(month - 1, total);
			}
		}
		return counts;
	}

	public long getTotalDoctors() {
		return doctorRepository.count();
	}

	public long getTotalPatients() {
		return patientRepository.count();
	}

	public long getTotalAppointments() {
		return appointmentRepository.count();
	}

	public long getTotalFeedbacks() {
		return feedbackRepository.count();
	}

	public long getPendingAppointments() {
		return appointmentRepository.countByStatus("PENDING");
	}

	public long getApprovedAppointments() {
		return appointmentRepository.countByStatus("APPROVED");
	}

	public long getCompletedAppointments() {
		return appointmentRepository.countByStatus("COMPLETED");
	}

	public long getCancelledAppointments() {
		return appointmentRepository.countByStatus("CANCELLED");
	}

	public long getRejectedAppointments() {
		return appointmentRepository.countByStatus("REJECTED");
	}
}
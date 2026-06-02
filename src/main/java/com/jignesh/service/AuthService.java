package com.jignesh.service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jignesh.entity.Doctor;
import com.jignesh.entity.PasswordResetToken;
import com.jignesh.entity.Patient;
import com.jignesh.entity.User;
import com.jignesh.repository.DoctorRepository;
import com.jignesh.repository.PasswordResetTokenRepository;
import com.jignesh.repository.PatientRepository;
import com.jignesh.repository.UserRepository;

@Service
public class AuthService {

	private final UserRepository userRepository;
	private final PatientRepository patientRepository;
	private final DoctorRepository doctorRepository;
	private final PasswordResetTokenRepository tokenRepository;
	private final PasswordEncoder passwordEncoder;

	public AuthService(UserRepository userRepository, PatientRepository patientRepository,
			DoctorRepository doctorRepository, PasswordResetTokenRepository tokenRepository,
			PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.patientRepository = patientRepository;
		this.doctorRepository = doctorRepository;
		this.tokenRepository = tokenRepository;
		this.passwordEncoder = passwordEncoder;
	}

	public String registerPatient(String name, String email, String password, String phone) {
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
		patient.setPhone(phone);
		patient.setProfileImage("default-patient.png");
		patient.setUser(savedUser);

		patientRepository.save(patient);

		return "success";
	}

	public String registerDoctorSelf(String name, String email, String password, String specialization,
			String qualification, Integer experience, Double consultationFee, String city) {

		if (userRepository.findByEmail(email).isPresent()) {
			return "Email already exists";
		}

		User user = new User();
		user.setName(name);
		user.setEmail(email);
		user.setPassword(passwordEncoder.encode(password));
		user.setRole("DOCTOR");
		user.setAccountStatus("PENDING");

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

	public String validateLogin(String email, String rawPassword) {
		Optional<User> optionalUser = userRepository.findByEmail(email);

		if (optionalUser.isEmpty()) {
			return "INVALID_CREDENTIALS";
		}

		User user = optionalUser.get();

		if (!passwordEncoder.matches(rawPassword, user.getPassword())) {
			return "INVALID_CREDENTIALS";
		}

		String status = user.getAccountStatus();

		if (status == null || status.isBlank() || status.equalsIgnoreCase("ACTIVE")) {
			return "success";
		}

		if (status.equalsIgnoreCase("PENDING")) {
			return "PENDING_APPROVAL";
		}

		if (status.equalsIgnoreCase("INACTIVE")) {
			return "INACTIVE_ACCOUNT";
		}

		return "INVALID_CREDENTIALS";
	}

	public User getUserByEmail(String email) {
		return userRepository.findByEmail(email).orElse(null);
	}

	@Transactional
	public String generateResetToken(String email) {
		Optional<User> optionalUser = userRepository.findByEmail(email);

		if (optionalUser.isEmpty()) {
			return null;
		}

		User user = optionalUser.get();
		tokenRepository.deleteByUser(user);

		String token = UUID.randomUUID().toString();

		PasswordResetToken resetToken = new PasswordResetToken();
		resetToken.setToken(token);
		resetToken.setUser(user);
		resetToken.setExpiryTime(LocalDateTime.now().plusMinutes(15));

		tokenRepository.save(resetToken);

		return token;
	}

	public boolean isTokenValid(String token) {
		Optional<PasswordResetToken> optionalToken = tokenRepository.findByToken(token);

		return optionalToken.isPresent() && optionalToken.get().getExpiryTime().isAfter(LocalDateTime.now());
	}

	@Transactional
	public String resetPassword(String token, String newPassword, String confirmPassword) {
		Optional<PasswordResetToken> optionalToken = tokenRepository.findByToken(token);

		if (optionalToken.isEmpty()) {
			return "Invalid reset token";
		}

		PasswordResetToken resetToken = optionalToken.get();

		if (resetToken.getExpiryTime().isBefore(LocalDateTime.now())) {
			return "Reset token has expired";
		}

		if (newPassword == null || newPassword.isBlank()) {
			return "New password is required";
		}

		if (!newPassword.equals(confirmPassword)) {
			return "New password and confirm password do not match";
		}

		User user = resetToken.getUser();
		user.setPassword(passwordEncoder.encode(newPassword));
		userRepository.save(user);

		tokenRepository.delete(resetToken);

		return "success";
	}

	@Transactional
	public String changePassword(Long userId, String currentPassword, String newPassword, String confirmPassword) {

		User user = userRepository.findById(userId).orElse(null);

		if (user == null) {
			return "User not found";
		}

		if (currentPassword == null || currentPassword.isBlank()) {
			return "Current password is required";
		}

		if (newPassword == null || newPassword.isBlank()) {
			return "New password is required";
		}

		if (!newPassword.equals(confirmPassword)) {
			return "New password and confirm password do not match";
		}

		if (newPassword.length() < 6) {
			return "New password must be at least 6 characters";
		}

		if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
			return "Current password is incorrect";
		}

		if (passwordEncoder.matches(newPassword, user.getPassword())) {
			return "New password must be different from current password";
		}

		user.setPassword(passwordEncoder.encode(newPassword));
		userRepository.save(user);

		return "success";
	}
}
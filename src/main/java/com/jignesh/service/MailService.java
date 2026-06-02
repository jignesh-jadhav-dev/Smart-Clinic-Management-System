package com.jignesh.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.jignesh.entity.Appointment;

@Service
public class MailService {

	private static final Logger logger = LoggerFactory.getLogger(MailService.class);

	private final JavaMailSender mailSender;

	@Value("${app.mail.enabled:false}")
	private boolean mailEnabled;

	@Value("${app.admin.email:}")
	private String adminEmail;

	@Value("${app.app-name:MediCare Clinic}")
	private String appName;

	public MailService(@Autowired(required = false) JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public void sendAppointmentBookedEmailToPatient(Appointment appointment) {
		if (appointment == null || appointment.getPatient() == null || appointment.getPatient().getUser() == null) {
			return;
		}
		String to = appointment.getPatient().getUser().getEmail();
		String subject = appName + " - Appointment Booking Submitted";
		String body = "Hello " + appointment.getPatient().getUser().getName() + ",\n\n"
				+ "Your appointment request has been submitted successfully.\n" + "Doctor: "
				+ appointment.getDoctor().getUser().getName() + "\n" + "Date: " + appointment.getAppointmentDate()
				+ "\n" + "Time: " + appointment.getAppointmentTime() + "\n" + "Status: " + appointment.getStatus()
				+ "\n\nRegards,\n" + appName;
		sendEmail(to, subject, body);
	}

	public void sendAppointmentBookedEmailToAdmin(Appointment appointment) {
		if (appointment == null || adminEmail == null || adminEmail.isBlank()) {
			return;
		}
		String subject = appName + " - New Appointment Booked";
		String body = "New appointment booked by " + appointment.getPatient().getUser().getName() + " with Dr. "
				+ appointment.getDoctor().getUser().getName() + " on " + appointment.getAppointmentDate() + " at "
				+ appointment.getAppointmentTime();
		sendEmail(adminEmail, subject, body);
	}

	public void sendAppointmentStatusEmailToPatient(Appointment appointment) {
		if (appointment == null || appointment.getPatient() == null || appointment.getPatient().getUser() == null) {
			return;
		}
		sendEmail(appointment.getPatient().getUser().getEmail(), appName + " - Appointment Status Updated",
				"Your appointment status is now " + appointment.getStatus());
	}

	public void sendAppointmentStatusEmailToDoctor(Appointment appointment) {
		if (appointment == null || appointment.getDoctor() == null || appointment.getDoctor().getUser() == null) {
			return;
		}
		sendEmail(appointment.getDoctor().getUser().getEmail(), appName + " - Appointment Status Update",
				"Appointment status is now " + appointment.getStatus());
	}

	private void sendEmail(String to, String subject, String body) {
		if (!mailEnabled || mailSender == null || to == null || to.isBlank()) {
			return;
		}
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(to);
			message.setSubject(subject);
			message.setText(body);
			mailSender.send(message);
		} catch (Exception e) {
			logger.error("Mail send failed: {}", e.getMessage());
		}
	}
}
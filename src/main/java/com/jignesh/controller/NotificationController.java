package com.jignesh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.jignesh.entity.User;
import com.jignesh.service.NotificationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class NotificationController {

	private final NotificationService notificationService;

	public NotificationController(NotificationService notificationService) {
		this.notificationService = notificationService;
	}

	private boolean hasRole(HttpSession session, String role) {
		Object user = session.getAttribute("loggedUser");
		Object userRole = session.getAttribute("userRole");
		return user != null && userRole != null && userRole.equals(role);
	}

	private void loadNotificationModel(Model model, User user, String role) {
		model.addAttribute("notifications", notificationService.getMyNotifications(user));
		model.addAttribute("unreadCount", notificationService.getUnreadCount(user));
		model.addAttribute("role", role);
	}

	@GetMapping("/admin/notifications")
	public String adminNotifications(Model model, HttpSession session) {
		if (!hasRole(session, "ADMIN"))
			return "redirect:/login";
		loadNotificationModel(model, (User) session.getAttribute("loggedUser"), "ADMIN");
		return "admin/notifications";
	}

	@GetMapping("/doctor/notifications")
	public String doctorNotifications(Model model, HttpSession session) {
		if (!hasRole(session, "DOCTOR"))
			return "redirect:/login";
		loadNotificationModel(model, (User) session.getAttribute("loggedUser"), "DOCTOR");
		return "doctor/notifications";
	}

	@GetMapping("/patient/notifications")
	public String patientNotifications(Model model, HttpSession session) {
		if (!hasRole(session, "PATIENT"))
			return "redirect:/login";
		loadNotificationModel(model, (User) session.getAttribute("loggedUser"), "PATIENT");
		return "patient/notifications";
	}

	@GetMapping("/admin/notification/read/{id}")
	public String readAdminNotification(@PathVariable Long id, HttpSession session) {
		if (!hasRole(session, "ADMIN"))
			return "redirect:/login";
		notificationService.markAsRead(id, (User) session.getAttribute("loggedUser"));
		return "redirect:/admin/notifications";
	}

	@GetMapping("/doctor/notification/read/{id}")
	public String readDoctorNotification(@PathVariable Long id, HttpSession session) {
		if (!hasRole(session, "DOCTOR"))
			return "redirect:/login";
		notificationService.markAsRead(id, (User) session.getAttribute("loggedUser"));
		return "redirect:/doctor/notifications";
	}

	@GetMapping("/patient/notification/read/{id}")
	public String readPatientNotification(@PathVariable Long id, HttpSession session) {
		if (!hasRole(session, "PATIENT"))
			return "redirect:/login";
		notificationService.markAsRead(id, (User) session.getAttribute("loggedUser"));
		return "redirect:/patient/notifications";
	}
}
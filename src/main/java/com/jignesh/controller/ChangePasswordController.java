package com.jignesh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jignesh.entity.User;
import com.jignesh.service.AuthService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChangePasswordController {

	private final AuthService authService;

	public ChangePasswordController(AuthService authService) {
		this.authService = authService;
	}

	private boolean hasRole(HttpSession session, String role) {
		Object user = session.getAttribute("loggedUser");
		Object userRole = session.getAttribute("userRole");
		return user != null && userRole != null && userRole.equals(role);
	}

	private void setCommonModel(Model model, String role) {
		model.addAttribute("role", role);
	}

	@GetMapping("/admin/change-password")
	public String adminChangePasswordPage(Model model, HttpSession session) {
		if (!hasRole(session, "ADMIN"))
			return "redirect:/login";
		setCommonModel(model, "ADMIN");
		return "admin/change-password";
	}

	@PostMapping("/admin/change-password")
	public String adminChangePassword(@RequestParam String currentPassword, @RequestParam String newPassword,
			@RequestParam String confirmPassword, Model model, HttpSession session) {
		if (!hasRole(session, "ADMIN"))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = authService.changePassword(user.getId(), currentPassword, newPassword, confirmPassword);
		if ("success".equals(result))
			model.addAttribute("success", "Password changed successfully.");
		else
			model.addAttribute("error", result);
		setCommonModel(model, "ADMIN");
		return "admin/change-password";
	}

	@GetMapping("/doctor/change-password")
	public String doctorChangePasswordPage(Model model, HttpSession session) {
		if (!hasRole(session, "DOCTOR"))
			return "redirect:/login";
		setCommonModel(model, "DOCTOR");
		return "doctor/change-password";
	}

	@PostMapping("/doctor/change-password")
	public String doctorChangePassword(@RequestParam String currentPassword, @RequestParam String newPassword,
			@RequestParam String confirmPassword, Model model, HttpSession session) {
		if (!hasRole(session, "DOCTOR"))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = authService.changePassword(user.getId(), currentPassword, newPassword, confirmPassword);
		if ("success".equals(result))
			model.addAttribute("success", "Password changed successfully.");
		else
			model.addAttribute("error", result);
		setCommonModel(model, "DOCTOR");
		return "doctor/change-password";
	}

	@GetMapping("/patient/change-password")
	public String patientChangePasswordPage(Model model, HttpSession session) {
		if (!hasRole(session, "PATIENT"))
			return "redirect:/login";
		setCommonModel(model, "PATIENT");
		return "patient/change-password";
	}

	@PostMapping("/patient/change-password")
	public String patientChangePassword(@RequestParam String currentPassword, @RequestParam String newPassword,
			@RequestParam String confirmPassword, Model model, HttpSession session) {
		if (!hasRole(session, "PATIENT"))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = authService.changePassword(user.getId(), currentPassword, newPassword, confirmPassword);
		if ("success".equals(result))
			model.addAttribute("success", "Password changed successfully.");
		else
			model.addAttribute("error", result);
		setCommonModel(model, "PATIENT");
		return "patient/change-password";
	}
}
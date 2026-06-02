package com.jignesh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jignesh.entity.User;
import com.jignesh.service.AuthService;
import com.jignesh.service.SpecializationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

	private final AuthService authService;
	private final SpecializationService specializationService;

	public AuthController(AuthService authService, SpecializationService specializationService) {
		this.authService = authService;
		this.specializationService = specializationService;
	}

	private boolean isLoggedIn(HttpSession session) {
		return session.getAttribute("loggedUser") != null && session.getAttribute("userRole") != null;
	}

	private String redirectByRole(User user) {
		if (user == null || user.getRole() == null) {
			return "redirect:/login";
		}

		return switch (user.getRole()) {
		case "ADMIN" -> "redirect:/admin/dashboard";
		case "DOCTOR" -> "redirect:/doctor/dashboard";
		case "PATIENT" -> "redirect:/patient/dashboard";
		default -> "redirect:/login";
		};
	}

	@GetMapping("/")
	public String root(HttpSession session) {
		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}
		return "redirect:/login";
	}

	@GetMapping("/login")
	public String loginPage(HttpSession session) {
		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}
		return "auth/login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password, Model model, HttpSession session) {

		String result = authService.validateLogin(email, password);

		if (!"success".equals(result)) {
			if ("PENDING_APPROVAL".equals(result)) {
				model.addAttribute("error", "Your doctor account is waiting for admin approval.");
			} else if ("INACTIVE_ACCOUNT".equals(result)) {
				model.addAttribute("error", "Your account is inactive. Contact admin.");
			} else {
				model.addAttribute("error", "Invalid email or password");
			}
			return "auth/login";
		}

		User user = authService.getUserByEmail(email);

		session.setAttribute("loggedUser", user);
		session.setAttribute("userRole", user.getRole());
		session.setAttribute("userName", user.getName());

		return redirectByRole(user);
	}

	@GetMapping("/register")
	public String registerPage(HttpSession session) {
		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}
		return "auth/register";
	}

	@PostMapping("/register")
	public String register(@RequestParam String name, @RequestParam String email, @RequestParam String password,
			@RequestParam String phone, Model model, HttpSession session) {

		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}

		String result = authService.registerPatient(name, email, password, phone);

		if ("success".equals(result)) {
			model.addAttribute("success", "Patient registration successful. Please login.");
		} else {
			model.addAttribute("error", result);
		}

		return "auth/register";
	}

	@GetMapping("/doctor-register")
	public String doctorRegisterPage(Model model, HttpSession session) {
		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}

		model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
		return "auth/doctor-register";
	}

	@PostMapping("/doctor-register")
	public String doctorRegister(@RequestParam String name, @RequestParam String email, @RequestParam String password,
			@RequestParam String specialization, @RequestParam String qualification, @RequestParam Integer experience,
			@RequestParam Double consultationFee, @RequestParam String city, Model model, HttpSession session) {

		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}

		String result = authService.registerDoctorSelf(name, email, password, specialization, qualification, experience,
				consultationFee, city);

		if ("success".equals(result)) {
			model.addAttribute("success", "Doctor registration submitted successfully. Wait for admin approval.");
			return "auth/login";
		} else {
			model.addAttribute("error", result);
			model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
			return "auth/doctor-register";
		}
	}

	@GetMapping("/forgot-password")
	public String forgotPasswordPage(HttpSession session) {
		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}
		return "auth/forgot-password";
	}

	@PostMapping("/forgot-password")
	public String forgotPassword(@RequestParam String email, Model model, HttpSession session) {

		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}

		String token = authService.generateResetToken(email);

		if (token == null) {
			model.addAttribute("error", "Email not found");
			return "auth/forgot-password";
		}

		model.addAttribute("success", "Reset token generated successfully.");
		model.addAttribute("resetLink", "/reset-password?token=" + token);

		return "auth/forgot-password";
	}

	@GetMapping("/reset-password")
	public String resetPasswordPage(@RequestParam String token, Model model, HttpSession session) {

		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}

		if (!authService.isTokenValid(token)) {
			model.addAttribute("error", "Invalid or expired reset token");
			return "auth/forgot-password";
		}

		model.addAttribute("token", token);
		return "auth/reset-password";
	}

	@PostMapping("/reset-password")
	public String resetPassword(@RequestParam String token, @RequestParam String newPassword,
			@RequestParam String confirmPassword, Model model, HttpSession session) {

		if (isLoggedIn(session)) {
			return redirectByRole((User) session.getAttribute("loggedUser"));
		}

		String result = authService.resetPassword(token, newPassword, confirmPassword);

		if ("success".equals(result)) {
			model.addAttribute("success", "Password reset successful. Please login.");
			return "auth/login";
		}

		model.addAttribute("error", result);
		model.addAttribute("token", token);
		return "auth/reset-password";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
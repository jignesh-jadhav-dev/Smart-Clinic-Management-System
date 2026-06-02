package com.jignesh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.User;
import com.jignesh.service.DoctorService;
import com.jignesh.service.SpecializationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class DoctorController {

	private final DoctorService doctorService;
	private final SpecializationService specializationService;

	public DoctorController(DoctorService doctorService, SpecializationService specializationService) {
		this.doctorService = doctorService;
		this.specializationService = specializationService;
	}

	private boolean isDoctor(HttpSession session) {
		Object user = session.getAttribute("loggedUser");
		Object role = session.getAttribute("userRole");
		return user != null && role != null && role.equals("DOCTOR");
	}

	@GetMapping("/doctor/dashboard")
	public String doctorDashboard(Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("totalAppointments", doctorService.getDoctorTotalAppointments(user));
		model.addAttribute("approvedAppointments", doctorService.getDoctorApprovedAppointments(user));
		model.addAttribute("completedAppointments", doctorService.getDoctorCompletedAppointments(user));
		model.addAttribute("totalFeedbacks", doctorService.getDoctorTotalFeedbacks(user));
		model.addAttribute("availableSlots", doctorService.getDoctorAvailableSlotCount(user));
		model.addAttribute("leaveDays", doctorService.getDoctorLeaveCount(user));
		model.addAttribute("averageRating", doctorService.getDoctorAverageRating(user));
		return "doctor/dashboard";
	}

	@GetMapping("/doctor/profile")
	public String doctorProfile(Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("doctor", doctorService.getMyProfile(user));
		model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
		return "doctor/profile";
	}

	@PostMapping("/doctor/profile")
	public String updateDoctorProfile(@RequestParam String name, @RequestParam String specialization,
			@RequestParam String qualification, @RequestParam Integer experience, @RequestParam Double consultationFee,
			@RequestParam String city, @RequestParam(required = false) MultipartFile profileImage, Model model,
			HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = doctorService.updateMyProfile(user, name, specialization, qualification, experience,
				consultationFee, city, profileImage);
		if ("success".equals(result)) {
			session.setAttribute("userName", name);
			model.addAttribute("success", "Profile updated successfully.");
		} else
			model.addAttribute("error", result);
		model.addAttribute("doctor", doctorService.getMyProfile(user));
		model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
		return "doctor/profile";
	}

	@GetMapping("/doctor/appointments")
	public String doctorAppointments(Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("appointments", doctorService.getMyAppointments(user));
		return "doctor/appointments";
	}

	@GetMapping("/doctor/appointment/complete/{id}")
	public String markCompleted(@PathVariable Long id, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		doctorService.markCompleted(id);
		return "redirect:/doctor/appointments";
	}

	@GetMapping("/doctor/prescription/{appointmentId}")
	public String prescriptionPage(@PathVariable Long appointmentId, Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		Appointment appointment = doctorService.getAppointmentById(appointmentId);
		model.addAttribute("appointment", appointment);
		return "doctor/prescription";
	}

	@PostMapping("/doctor/prescription")
	public String addPrescription(@RequestParam Long appointmentId, @RequestParam String medicine,
			@RequestParam String advice, @RequestParam(required = false) String nextVisitDate, Model model,
			HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		String result = doctorService.addPrescription(appointmentId, medicine, advice, nextVisitDate);
		if ("success".equals(result))
			model.addAttribute("success", "Prescription added successfully.");
		else
			model.addAttribute("error", result);
		model.addAttribute("appointment", doctorService.getAppointmentById(appointmentId));
		return "doctor/prescription";
	}

	@GetMapping("/doctor/availability")
	public String availabilityPage(Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("slots", doctorService.getMyAvailability(user));
		return "doctor/availability";
	}

	@PostMapping("/doctor/availability")
	public String addAvailability(@RequestParam String availableDate, @RequestParam String startTime,
			@RequestParam String endTime, @RequestParam Integer slotMinutes, Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = doctorService.addAvailability(user, availableDate, startTime, endTime, slotMinutes);
		if (result.startsWith("success:"))
			model.addAttribute("success", result.substring(8));
		else
			model.addAttribute("error", result);
		model.addAttribute("slots", doctorService.getMyAvailability(user));
		return "doctor/availability";
	}

	@GetMapping("/doctor/availability/delete/{id}")
	public String deleteAvailability(@PathVariable Long id, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		doctorService.deleteAvailability(id);
		return "redirect:/doctor/availability";
	}

	@GetMapping("/doctor/leaves")
	public String leavesPage(Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("leaves", doctorService.getMyLeaves(user));
		return "doctor/leaves";
	}

	@PostMapping("/doctor/leaves")
	public String addLeave(@RequestParam String leaveDate, @RequestParam(required = false) String reason, Model model,
			HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = doctorService.addLeave(user, leaveDate, reason);
		if ("success".equals(result))
			model.addAttribute("success", "Leave date added successfully.");
		else
			model.addAttribute("error", result);
		model.addAttribute("leaves", doctorService.getMyLeaves(user));
		return "doctor/leaves";
	}

	@GetMapping("/doctor/leave/delete/{id}")
	public String deleteLeave(@PathVariable Long id, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		doctorService.deleteLeave(id);
		return "redirect:/doctor/leaves";
	}

	@GetMapping("/doctor/feedbacks")
	public String doctorFeedbacks(Model model, HttpSession session) {
		if (!isDoctor(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("feedbacks", doctorService.getMyFeedbacks(user));
		return "doctor/feedbacks";
	}
}
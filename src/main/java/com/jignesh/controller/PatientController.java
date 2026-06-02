package com.jignesh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jignesh.entity.User;
import com.jignesh.service.PatientService;
import com.jignesh.service.SpecializationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PatientController {

	private final PatientService patientService;
	private final SpecializationService specializationService;

	public PatientController(PatientService patientService, SpecializationService specializationService) {
		this.patientService = patientService;
		this.specializationService = specializationService;
	}

	private boolean isPatient(HttpSession session) {
		Object user = session.getAttribute("loggedUser");
		Object role = session.getAttribute("userRole");
		return user != null && role != null && role.equals("PATIENT");
	}

	@GetMapping("/patient/dashboard")
	public String patientDashboard(Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("totalAppointments", patientService.getPatientTotalAppointments(user));
		model.addAttribute("pendingAppointments", patientService.getPatientPendingAppointments(user));
		model.addAttribute("approvedAppointments", patientService.getPatientApprovedAppointments(user));
		model.addAttribute("completedAppointments", patientService.getPatientCompletedAppointments(user));
		model.addAttribute("cancelledAppointments", patientService.getPatientCancelledAppointments(user));
		return "patient/dashboard";
	}

	@GetMapping("/patient/profile")
	public String patientProfile(Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("patient", patientService.getMyProfile(user));
		return "patient/profile";
	}

	@PostMapping("/patient/profile")
	public String updatePatientProfile(@RequestParam String name, @RequestParam String phone,
			@RequestParam(required = false) Integer age, @RequestParam(required = false) String gender,
			@RequestParam(required = false) String address, @RequestParam(required = false) MultipartFile profileImage,
			Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = patientService.updateMyProfile(user, name, phone, age, gender, address, profileImage);
		if ("success".equals(result)) {
			session.setAttribute("userName", name);
			model.addAttribute("success", "Profile updated successfully.");
		} else
			model.addAttribute("error", result);
		model.addAttribute("patient", patientService.getMyProfile(user));
		return "patient/profile";
	}

	@GetMapping("/patient/doctors")
	public String viewDoctors(@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String specialization, Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
		model.addAttribute("keyword", keyword);
		model.addAttribute("specialization", specialization);
		if ((keyword != null && !keyword.trim().isEmpty())
				|| (specialization != null && !specialization.trim().isEmpty())) {
			model.addAttribute("doctors", patientService.searchDoctors(keyword, specialization));
		} else {
			model.addAttribute("doctors", patientService.getAllDoctors());
		}
		return "patient/doctors";
	}

	@GetMapping("/patient/book-appointment/{doctorId}")
	public String bookAppointmentPage(@PathVariable Long doctorId, Model model, HttpSession session) {

		if (!isPatient(session)) {
			return "redirect:/login";
		}

		var doctor = patientService.getDoctorById(doctorId);

		if (doctor == null) {
			model.addAttribute("error", "Doctor is not available for booking.");
			model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
			model.addAttribute("doctors", patientService.getAllDoctors());
			return "patient/doctors";
		}

		model.addAttribute("doctor", doctor);
		model.addAttribute("slots", patientService.getAvailableSlots(doctorId));

		return "patient/book-appointment";
	}

	@PostMapping("/patient/book-appointment")
	public String bookAppointment(@RequestParam Long doctorId, @RequestParam Long slotId, @RequestParam String reason,
			Model model, HttpSession session) {

		if (!isPatient(session)) {
			return "redirect:/login";
		}

		User user = (User) session.getAttribute("loggedUser");
		var doctor = patientService.getDoctorById(doctorId);

		if (doctor == null) {
			model.addAttribute("error", "Doctor is not available for booking.");
			model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
			model.addAttribute("doctors", patientService.getAllDoctors());
			return "patient/doctors";
		}

		String result = patientService.bookAppointment(user, doctorId, slotId, reason);

		if (result.equals("success")) {
			model.addAttribute("success", "Appointment booked successfully. Waiting for admin approval.");
		} else {
			model.addAttribute("error", result);
		}

		model.addAttribute("doctor", doctor);
		model.addAttribute("slots", patientService.getAvailableSlots(doctorId));

		return "patient/book-appointment";
	}

	@GetMapping("/patient/reschedule/{appointmentId}")
	public String reschedulePage(@PathVariable Long appointmentId, Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("appointment", patientService.getAppointmentById(appointmentId));
		model.addAttribute("slots", patientService.getRescheduleSlots(user, appointmentId));
		return "patient/reschedule-appointment";
	}

	@PostMapping("/patient/reschedule")
	public String rescheduleAppointment(@RequestParam Long appointmentId, @RequestParam Long slotId, Model model,
			HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = patientService.rescheduleAppointment(user, appointmentId, slotId);
		if ("success".equals(result))
			model.addAttribute("success", "Appointment rescheduled successfully. Waiting for admin approval again.");
		else
			model.addAttribute("error", result);
		model.addAttribute("appointment", patientService.getAppointmentById(appointmentId));
		model.addAttribute("slots", patientService.getRescheduleSlots(user, appointmentId));
		return "patient/reschedule-appointment";
	}

	@GetMapping("/patient/my-appointments")
	public String myAppointments(Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		model.addAttribute("appointments", patientService.getMyAppointments(user));
		return "patient/my-appointments";
	}

	@GetMapping("/patient/appointment/cancel/{id}")
	public String cancelAppointment(@PathVariable Long id, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		patientService.cancelAppointment(id);
		return "redirect:/patient/my-appointments";
	}

	@GetMapping("/patient/prescription/{appointmentId}")
	public String viewPrescription(@PathVariable Long appointmentId, Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		model.addAttribute("appointment", patientService.getAppointmentById(appointmentId));
		model.addAttribute("prescription", patientService.getPrescriptionByAppointmentId(appointmentId));
		return "patient/prescription";
	}

	@GetMapping("/patient/feedback/{appointmentId}")
	public String feedbackPage(@PathVariable Long appointmentId, Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		model.addAttribute("appointment", patientService.getAppointmentById(appointmentId));
		model.addAttribute("feedback", patientService.getFeedbackByAppointmentId(appointmentId));
		return "patient/feedback";
	}

	@PostMapping("/patient/feedback")
	public String saveFeedback(@RequestParam Long appointmentId, @RequestParam Integer rating,
			@RequestParam String comment, Model model, HttpSession session) {
		if (!isPatient(session))
			return "redirect:/login";
		User user = (User) session.getAttribute("loggedUser");
		String result = patientService.saveFeedback(user, appointmentId, rating, comment);
		if ("success".equals(result))
			model.addAttribute("success", "Feedback saved successfully.");
		else
			model.addAttribute("error", result);
		model.addAttribute("appointment", patientService.getAppointmentById(appointmentId));
		model.addAttribute("feedback", patientService.getFeedbackByAppointmentId(appointmentId));
		return "patient/feedback";
	}
}
package com.jignesh.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Year;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.Doctor;
import com.jignesh.entity.Patient;
import com.jignesh.service.AdminService;
import com.jignesh.service.SpecializationService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	private final AdminService adminService;
	private final SpecializationService specializationService;

	public AdminController(AdminService adminService, SpecializationService specializationService) {
		this.adminService = adminService;
		this.specializationService = specializationService;
	}

	private boolean isAdmin(HttpSession session) {
		Object user = session.getAttribute("loggedUser");
		Object role = session.getAttribute("userRole");
		return user != null && role != null && role.equals("ADMIN");
	}

	private String csvEscape(String value) {
		if (value == null)
			return "";
		return "\"" + value.replace("\"", "\"\"") + "\"";
	}

	@GetMapping("/admin/dashboard")
	public String adminDashboard(Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("totalDoctors", adminService.getTotalDoctors());
		model.addAttribute("totalPatients", adminService.getTotalPatients());
		model.addAttribute("totalAppointments", adminService.getTotalAppointments());
		model.addAttribute("totalFeedbacks", adminService.getTotalFeedbacks());
		model.addAttribute("pendingAppointments", adminService.getPendingAppointments());
		model.addAttribute("approvedAppointments", adminService.getApprovedAppointments());
		model.addAttribute("completedAppointments", adminService.getCompletedAppointments());
		model.addAttribute("cancelledAppointments", adminService.getCancelledAppointments());
		model.addAttribute("rejectedAppointments", adminService.getRejectedAppointments());
		return "admin/dashboard";
	}

	@GetMapping("/admin/reports")
	public String reportsPage(Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		int year = Year.now().getValue();
		model.addAttribute("reportYear", year);
		model.addAttribute("monthLabelsJson",
				"['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']");
		model.addAttribute("appointmentCountsJson", adminService.getMonthlyAppointmentCounts(year).toString());
		model.addAttribute("completedCountsJson", adminService.getMonthlyCompletedCounts(year).toString());
		model.addAttribute("totalAppointments", adminService.getTotalAppointments());
		model.addAttribute("completedAppointments", adminService.getCompletedAppointments());
		model.addAttribute("pendingAppointments", adminService.getPendingAppointments());
		model.addAttribute("cancelledAppointments", adminService.getCancelledAppointments());
		return "admin/reports";
	}

	@GetMapping("/admin/add-doctor")
	public String addDoctorPage(Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
		return "admin/add-doctor";
	}

	@PostMapping("/admin/add-doctor")
	public String addDoctor(@RequestParam String name, @RequestParam String email, @RequestParam String password,
			@RequestParam String specialization, @RequestParam String qualification, @RequestParam Integer experience,
			@RequestParam Double consultationFee, @RequestParam String city, Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		String result = adminService.addDoctor(name, email, password, specialization, qualification, experience,
				consultationFee, city);
		if ("success".equals(result))
			model.addAttribute("success", "Doctor added successfully.");
		else
			model.addAttribute("error", result);
		model.addAttribute("specializations", specializationService.getAllActiveSpecializations());
		return "admin/add-doctor";
	}

	@GetMapping("/admin/add-patient")
	public String addPatientPage(HttpSession session) {
		if (!isAdmin(session)) {
			return "redirect:/login";
		}
		return "admin/add-patient";
	}

	@PostMapping("/admin/add-patient")
	public String addPatient(@RequestParam String name, @RequestParam String email, @RequestParam String password,
			@RequestParam String phone, @RequestParam(required = false) Integer age,
			@RequestParam(required = false) String gender, @RequestParam(required = false) String address, Model model,
			HttpSession session) {

		if (!isAdmin(session)) {
			return "redirect:/login";
		}

		String result = adminService.addPatient(name, email, password, phone, age, gender, address);

		if ("success".equals(result)) {
			model.addAttribute("success", "Patient added successfully.");
		} else {
			model.addAttribute("error", result);
		}

		return "admin/add-patient";
	}

	@GetMapping("/admin/doctor/approve/{id}")
	public String approveDoctor(@PathVariable Long id, RedirectAttributes redirectAttributes, HttpSession session) {

		if (!isAdmin(session)) {
			return "redirect:/login";
		}

		String result = adminService.approveDoctor(id);

		if ("success".equals(result)) {
			redirectAttributes.addFlashAttribute("success", "Doctor approved successfully.");
		} else {
			redirectAttributes.addFlashAttribute("error", result);
		}

		return "redirect:/admin/view-doctors";
	}

	@GetMapping("/admin/view-doctors")
	public String viewDoctors(@RequestParam(defaultValue = "0") int page,
			@RequestParam(required = false) String keyword, Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		Page<Doctor> doctorPage = adminService.getDoctorsPage(page, keyword);
		model.addAttribute("doctors", doctorPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", doctorPage.getTotalPages());
		model.addAttribute("keyword", keyword);
		return "admin/view-doctors";
	}

	@GetMapping("/admin/delete-doctor/{id}")
	public String deleteDoctor(@PathVariable Long id, RedirectAttributes redirectAttributes, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		String result = adminService.deleteDoctor(id);
		if ("success".equals(result))
			redirectAttributes.addFlashAttribute("success", "Doctor deleted successfully.");
		else
			redirectAttributes.addFlashAttribute("error", result);
		return "redirect:/admin/view-doctors";
	}

	@GetMapping("/admin/view-patients")
	public String viewPatients(@RequestParam(defaultValue = "0") int page,
			@RequestParam(required = false) String keyword, Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		Page<Patient> patientPage = adminService.getPatientsPage(page, keyword);
		model.addAttribute("patients", patientPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", patientPage.getTotalPages());
		model.addAttribute("keyword", keyword);
		return "admin/view-patients";
	}

	@GetMapping("/admin/delete-patient/{id}")
	public String deletePatient(@PathVariable Long id, RedirectAttributes redirectAttributes, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		String result = adminService.deletePatient(id);
		if ("success".equals(result))
			redirectAttributes.addFlashAttribute("success", "Patient deleted successfully.");
		else
			redirectAttributes.addFlashAttribute("error", result);
		return "redirect:/admin/view-patients";
	}

	@GetMapping("/admin/appointments")
	public String viewAppointments(@RequestParam(defaultValue = "0") int page,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) String status,
			@RequestParam(defaultValue = "latest") String sortBy, Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		Page<Appointment> appointmentPage = adminService.getAppointmentsPage(page, keyword, status, sortBy);
		model.addAttribute("appointments", appointmentPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", appointmentPage.getTotalPages());
		model.addAttribute("keyword", keyword);
		model.addAttribute("status", status);
		model.addAttribute("sortBy", sortBy);
		return "admin/appointments";
	}

	@GetMapping("/admin/appointment/history/{id}")
	public String appointmentHistory(@PathVariable Long id, Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("appointment", adminService.getAppointmentById(id));
		model.addAttribute("historyList", adminService.getAppointmentHistory(id));
		return "admin/appointment-history";
	}

	@GetMapping("/admin/appointment/status/{id}/{status}")
	public String updateAppointmentStatus(@PathVariable Long id, @PathVariable String status, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		adminService.updateAppointmentStatus(id, status);
		return "redirect:/admin/appointments";
	}

	@GetMapping("/admin/export/doctors/csv")
	public void exportDoctorsCsv(HttpServletResponse response, HttpSession session) throws IOException {
		if (!isAdmin(session)) {
			response.sendRedirect("/login");
			return;
		}
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=doctors_report.csv");
		List<Doctor> doctors = adminService.getAllDoctorsForExport();
		PrintWriter writer = response.getWriter();
		writer.println("ID,Name,Email,Specialization,Qualification,Experience,Consultation Fee,City");
		for (Doctor doctor : doctors) {
			writer.println(doctor.getId() + "," + csvEscape(doctor.getUser().getName()) + ","
					+ csvEscape(doctor.getUser().getEmail()) + "," + csvEscape(doctor.getSpecialization()) + ","
					+ csvEscape(doctor.getQualification()) + "," + doctor.getExperience() + ","
					+ doctor.getConsultationFee() + "," + csvEscape(doctor.getCity()));
		}
		writer.flush();
	}

	@GetMapping("/admin/export/patients/csv")
	public void exportPatientsCsv(HttpServletResponse response, HttpSession session) throws IOException {
		if (!isAdmin(session)) {
			response.sendRedirect("/login");
			return;
		}
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=patients_report.csv");
		List<Patient> patients = adminService.getAllPatientsForExport();
		PrintWriter writer = response.getWriter();
		writer.println("ID,Name,Email,Phone,Age,Gender,Address");
		for (Patient patient : patients) {
			writer.println(patient.getId() + "," + csvEscape(patient.getUser().getName()) + ","
					+ csvEscape(patient.getUser().getEmail()) + "," + csvEscape(patient.getPhone()) + ","
					+ csvEscape(patient.getAge() == null ? "" : patient.getAge().toString()) + ","
					+ csvEscape(patient.getGender()) + "," + csvEscape(patient.getAddress()));
		}
		writer.flush();
	}

	@GetMapping("/admin/export/appointments/csv")
	public void exportAppointmentsCsv(HttpServletResponse response, HttpSession session) throws IOException {
		if (!isAdmin(session)) {
			response.sendRedirect("/login");
			return;
		}
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=appointments_report.csv");
		List<Appointment> appointments = adminService.getAllAppointmentsForExport();
		PrintWriter writer = response.getWriter();
		writer.println("ID,Patient,Doctor,Date,Time,Reason,Status");
		for (Appointment appointment : appointments) {
			writer.println(appointment.getId() + "," + csvEscape(appointment.getPatient().getUser().getName()) + ","
					+ csvEscape(appointment.getDoctor().getUser().getName()) + ","
					+ csvEscape(String.valueOf(appointment.getAppointmentDate())) + ","
					+ csvEscape(String.valueOf(appointment.getAppointmentTime())) + ","
					+ csvEscape(appointment.getReason()) + "," + csvEscape(appointment.getStatus()));
		}
		writer.flush();
	}
}
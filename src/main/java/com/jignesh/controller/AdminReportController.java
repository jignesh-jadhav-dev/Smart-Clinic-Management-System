package com.jignesh.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.jignesh.service.AdminService;
import com.jignesh.service.PdfExportService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminReportController {

	private final AdminService adminService;
	private final PdfExportService pdfExportService;

	public AdminReportController(AdminService adminService, PdfExportService pdfExportService) {
		this.adminService = adminService;
		this.pdfExportService = pdfExportService;
	}

	private boolean isAdmin(HttpSession session) {
		Object user = session.getAttribute("loggedUser");
		Object role = session.getAttribute("userRole");
		return user != null && role != null && role.equals("ADMIN");
	}

	@GetMapping("/admin/export/doctors/pdf")
	public void exportDoctorsPdf(HttpServletResponse response, HttpSession session) throws IOException {
		if (!isAdmin(session)) {
			response.sendRedirect("/login");
			return;
		}
		byte[] pdfBytes = pdfExportService.generateDoctorsPdf(adminService.getAllDoctorsForExport());
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=doctors_report.pdf");
		response.getOutputStream().write(pdfBytes);
	}

	@GetMapping("/admin/export/patients/pdf")
	public void exportPatientsPdf(HttpServletResponse response, HttpSession session) throws IOException {
		if (!isAdmin(session)) {
			response.sendRedirect("/login");
			return;
		}
		byte[] pdfBytes = pdfExportService.generatePatientsPdf(adminService.getAllPatientsForExport());
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=patients_report.pdf");
		response.getOutputStream().write(pdfBytes);
	}

	@GetMapping("/admin/export/appointments/pdf")
	public void exportAppointmentsPdf(HttpServletResponse response, HttpSession session) throws IOException {
		if (!isAdmin(session)) {
			response.sendRedirect("/login");
			return;
		}
		byte[] pdfBytes = pdfExportService.generateAppointmentsPdf(adminService.getAllAppointmentsForExport());
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=appointments_report.pdf");
		response.getOutputStream().write(pdfBytes);
	}
}
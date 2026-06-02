package com.jignesh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jignesh.service.SpecializationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminSpecializationController {

	private final SpecializationService specializationService;

	public AdminSpecializationController(SpecializationService specializationService) {
		this.specializationService = specializationService;
	}

	private boolean isAdmin(HttpSession session) {
		Object user = session.getAttribute("loggedUser");
		Object role = session.getAttribute("userRole");
		return user != null && role != null && role.equals("ADMIN");
	}

	@GetMapping("/admin/specializations")
	public String specializationsPage(@RequestParam(required = false) Long editId, Model model, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("specializations", specializationService.getAllSpecializations());
		if (editId != null)
			model.addAttribute("editSpecialization", specializationService.getById(editId));
		return "admin/specializations";
	}

	@PostMapping("/admin/specializations")
	public String saveSpecialization(@RequestParam(required = false) Long id, @RequestParam String name,
			@RequestParam(required = false) String description, RedirectAttributes redirectAttributes,
			HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		String result = specializationService.saveOrUpdate(id, name, description);
		if ("success".equals(result))
			redirectAttributes.addFlashAttribute("success",
					id == null ? "Specialization added successfully." : "Specialization updated successfully.");
		else
			redirectAttributes.addFlashAttribute("error", result);
		return "redirect:/admin/specializations";
	}

	@GetMapping("/admin/specialization/edit/{id}")
	public String editSpecialization(@PathVariable Long id, HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		return "redirect:/admin/specializations?editId=" + id;
	}

	@GetMapping("/admin/specialization/delete/{id}")
	public String deleteSpecialization(@PathVariable Long id, RedirectAttributes redirectAttributes,
			HttpSession session) {
		if (!isAdmin(session))
			return "redirect:/login";
		String result = specializationService.deleteSpecialization(id);
		if ("success".equals(result))
			redirectAttributes.addFlashAttribute("success", "Specialization deleted successfully.");
		else
			redirectAttributes.addFlashAttribute("error", result);
		return "redirect:/admin/specializations";
	}
}
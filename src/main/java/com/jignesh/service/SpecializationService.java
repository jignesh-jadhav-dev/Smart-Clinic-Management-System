package com.jignesh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jignesh.entity.Specialization;
import com.jignesh.repository.DoctorRepository;
import com.jignesh.repository.SpecializationRepository;

@Service
public class SpecializationService {

	private final SpecializationRepository specializationRepository;
	private final DoctorRepository doctorRepository;

	public SpecializationService(SpecializationRepository specializationRepository, DoctorRepository doctorRepository) {
		this.specializationRepository = specializationRepository;
		this.doctorRepository = doctorRepository;
	}

	public List<Specialization> getAllSpecializations() {
		return specializationRepository.findAllByOrderByNameAsc();
	}

	public List<Specialization> getAllActiveSpecializations() {
		return specializationRepository.findByActiveTrueOrderByNameAsc();
	}

	public Specialization getById(Long id) {
		return specializationRepository.findById(id).orElse(null);
	}

	public String saveOrUpdate(Long id, String name, String description) {
		if (name == null || name.isBlank()) {
			return "Specialization name is required";
		}
		String trimmedName = name.trim();

		if (id == null) {
			if (specializationRepository.existsByNameIgnoreCase(trimmedName)) {
				return "Specialization already exists";
			}
			Specialization specialization = new Specialization();
			specialization.setName(trimmedName);
			specialization.setDescription(description);
			specialization.setActive(true);
			specializationRepository.save(specialization);
			return "success";
		}

		Specialization specialization = specializationRepository.findById(id).orElse(null);
		if (specialization == null) {
			return "Specialization not found";
		}

		specialization.setName(trimmedName);
		specialization.setDescription(description);
		specializationRepository.save(specialization);
		return "success";
	}

	public String deleteSpecialization(Long id) {
		Specialization specialization = specializationRepository.findById(id).orElse(null);
		if (specialization == null) {
			return "Specialization not found";
		}
		if (doctorRepository.existsBySpecializationIgnoreCase(specialization.getName())) {
			return "Specialization cannot be deleted because doctors are using it";
		}
		specializationRepository.delete(specialization);
		return "success";
	}
}
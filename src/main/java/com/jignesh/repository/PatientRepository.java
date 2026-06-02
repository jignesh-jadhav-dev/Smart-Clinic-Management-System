package com.jignesh.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Patient;
import com.jignesh.entity.User;

public interface PatientRepository extends JpaRepository<Patient, Long> {

	Optional<Patient> findByUser(User user);

	Page<Patient> findByUser_NameContainingIgnoreCaseOrUser_EmailContainingIgnoreCaseOrPhoneContainingIgnoreCaseOrAddressContainingIgnoreCase(
			String name, String email, String phone, String address, Pageable pageable);
}
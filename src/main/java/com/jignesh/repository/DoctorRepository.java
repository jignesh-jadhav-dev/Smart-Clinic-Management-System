package com.jignesh.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Doctor;
import com.jignesh.entity.User;

public interface DoctorRepository extends JpaRepository<Doctor, Long> {

	List<Doctor> findBySpecializationContainingIgnoreCaseOrCityContainingIgnoreCase(String specialization, String city);

	Optional<Doctor> findByUser(User user);

	Page<Doctor> findByUser_NameContainingIgnoreCaseOrUser_EmailContainingIgnoreCaseOrSpecializationContainingIgnoreCaseOrCityContainingIgnoreCase(
			String name, String email, String specialization, String city, Pageable pageable);

	boolean existsBySpecializationIgnoreCase(String specialization);
}
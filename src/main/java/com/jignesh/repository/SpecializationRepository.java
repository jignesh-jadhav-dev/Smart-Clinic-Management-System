package com.jignesh.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Specialization;

public interface SpecializationRepository extends JpaRepository<Specialization, Long> {
	Optional<Specialization> findByNameIgnoreCase(String name);

	List<Specialization> findAllByOrderByNameAsc();

	List<Specialization> findByActiveTrueOrderByNameAsc();

	boolean existsByNameIgnoreCase(String name);
}
package com.jignesh.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.Prescription;

public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {
	Optional<Prescription> findByAppointment(Appointment appointment);
}
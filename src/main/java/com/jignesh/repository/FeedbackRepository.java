package com.jignesh.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.Doctor;
import com.jignesh.entity.Feedback;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {
	Optional<Feedback> findByAppointment(Appointment appointment);

	List<Feedback> findByDoctorOrderByCreatedAtDesc(Doctor doctor);

	long countByDoctor(Doctor doctor);

	@Query("SELECT COALESCE(AVG(f.rating), 0) FROM Feedback f WHERE f.doctor = :doctor")
	Double findAverageRatingByDoctor(@Param("doctor") Doctor doctor);
}
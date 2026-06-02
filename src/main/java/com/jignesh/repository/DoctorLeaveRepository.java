package com.jignesh.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Doctor;
import com.jignesh.entity.DoctorLeave;

public interface DoctorLeaveRepository extends JpaRepository<DoctorLeave, Long> {
	List<DoctorLeave> findByDoctorOrderByLeaveDateAsc(Doctor doctor);

	boolean existsByDoctorAndLeaveDate(Doctor doctor, LocalDate leaveDate);

	long countByDoctor(Doctor doctor);

	void deleteByDoctor(Doctor doctor);
}
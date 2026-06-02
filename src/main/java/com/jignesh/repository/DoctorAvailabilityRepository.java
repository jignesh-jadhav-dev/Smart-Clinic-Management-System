package com.jignesh.repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Doctor;
import com.jignesh.entity.DoctorAvailability;

public interface DoctorAvailabilityRepository extends JpaRepository<DoctorAvailability, Long> {

	List<DoctorAvailability> findByDoctorOrderByAvailableDateAscStartTimeAsc(Doctor doctor);

	List<DoctorAvailability> findByDoctorAndSlotStatusOrderByAvailableDateAscStartTimeAsc(Doctor doctor,
			String slotStatus);

	List<DoctorAvailability> findByDoctorAndAvailableDateAndSlotStatus(Doctor doctor, LocalDate availableDate,
			String slotStatus);

	boolean existsByDoctorAndAvailableDateAndStartTimeAndEndTime(Doctor doctor, LocalDate availableDate,
			LocalTime startTime, LocalTime endTime);

	Optional<DoctorAvailability> findByDoctorAndAvailableDateAndStartTime(Doctor doctor, LocalDate availableDate,
			LocalTime startTime);

	long countByDoctorAndSlotStatus(Doctor doctor, String slotStatus);

	void deleteByDoctorAndAvailableDateAndSlotStatus(Doctor doctor, LocalDate availableDate, String slotStatus);

	void deleteByDoctor(Doctor doctor);
}
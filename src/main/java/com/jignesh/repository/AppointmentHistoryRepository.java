package com.jignesh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.AppointmentHistory;

public interface AppointmentHistoryRepository extends JpaRepository<AppointmentHistory, Long> {
	List<AppointmentHistory> findByAppointmentOrderByCreatedAtDesc(Appointment appointment);
}
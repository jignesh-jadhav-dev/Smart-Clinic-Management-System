package com.jignesh.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.AppointmentHistory;
import com.jignesh.repository.AppointmentHistoryRepository;
import com.jignesh.repository.AppointmentRepository;

@Service
public class AppointmentHistoryService {

	private final AppointmentHistoryRepository appointmentHistoryRepository;
	private final AppointmentRepository appointmentRepository;

	public AppointmentHistoryService(AppointmentHistoryRepository appointmentHistoryRepository,
			AppointmentRepository appointmentRepository) {
		this.appointmentHistoryRepository = appointmentHistoryRepository;
		this.appointmentRepository = appointmentRepository;
	}

	public void logHistory(Appointment appointment, String actionType, String changedByRole, String oldStatus,
			String newStatus, LocalDate oldDate, LocalTime oldTime, LocalDate newDate, LocalTime newTime,
			String notes) {
		if (appointment == null) {
			return;
		}
		AppointmentHistory history = new AppointmentHistory();
		history.setAppointment(appointment);
		history.setActionType(actionType);
		history.setChangedByRole(changedByRole);
		history.setOldStatus(oldStatus);
		history.setNewStatus(newStatus);
		history.setOldDate(oldDate);
		history.setOldTime(oldTime);
		history.setNewDate(newDate);
		history.setNewTime(newTime);
		history.setNotes(notes);
		appointmentHistoryRepository.save(history);
	}

	public List<AppointmentHistory> getHistoryByAppointmentId(Long appointmentId) {
		Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
		if (appointment == null) {
			return List.of();
		}
		return appointmentHistoryRepository.findByAppointmentOrderByCreatedAtDesc(appointment);
	}
}
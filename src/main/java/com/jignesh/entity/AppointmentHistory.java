package com.jignesh.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "appointment_history")
@Getter
@Setter
@NoArgsConstructor
public class AppointmentHistory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String actionType;
	private String changedByRole;
	private String oldStatus;
	private String newStatus;
	private LocalDate oldDate;
	private LocalDate newDate;
	private LocalTime oldTime;
	private LocalTime newTime;

	@Column(length = 500)
	private String notes;

	private LocalDateTime createdAt = LocalDateTime.now();

	@ManyToOne
	@JoinColumn(name = "appointment_id")
	private Appointment appointment;
}
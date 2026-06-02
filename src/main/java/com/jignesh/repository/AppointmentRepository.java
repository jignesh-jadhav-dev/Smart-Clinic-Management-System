package com.jignesh.repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.Doctor;
import com.jignesh.entity.Patient;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

	boolean existsByDoctorIdAndAppointmentDateAndAppointmentTimeAndStatusNot(Long doctorId, LocalDate appointmentDate,
			LocalTime appointmentTime, String status);

	List<Appointment> findByPatientOrderByCreatedAtDesc(Patient patient);

	List<Appointment> findAllByOrderByCreatedAtDesc();

	List<Appointment> findByDoctorOrderByCreatedAtDesc(Doctor doctor);

	long countByStatus(String status);

	boolean existsByDoctor(Doctor doctor);

	boolean existsByPatient(Patient patient);

	long countByDoctor(Doctor doctor);

	long countByDoctorAndStatus(Doctor doctor, String status);

	long countByPatient(Patient patient);

	long countByPatientAndStatus(Patient patient, String status);

	@Query("""
			SELECT a FROM Appointment a
			WHERE (
			    :keyword IS NULL OR :keyword = '' OR
			    LOWER(a.patient.user.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
			    LOWER(a.doctor.user.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
			    LOWER(a.reason) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
			    LOWER(a.status) LIKE LOWER(CONCAT('%', :keyword, '%'))
			)
			AND (
			    :status IS NULL OR :status = '' OR a.status = :status
			)
			""")
	Page<Appointment> searchAppointments(@Param("keyword") String keyword, @Param("status") String status,
			Pageable pageable);

	@Query(value = """
			SELECT EXTRACT(MONTH FROM appointment_date) AS month_no, COUNT(*) AS total_count
			FROM appointments
			WHERE EXTRACT(YEAR FROM appointment_date) = :year
			GROUP BY EXTRACT(MONTH FROM appointment_date)
			ORDER BY EXTRACT(MONTH FROM appointment_date)
			""", nativeQuery = true)
	List<Object[]> countAppointmentsMonthWise(@Param("year") Integer year);

	@Query(value = """
			SELECT EXTRACT(MONTH FROM appointment_date) AS month_no, COUNT(*) AS total_count
			FROM appointments
			WHERE EXTRACT(YEAR FROM appointment_date) = :year
			  AND status = 'COMPLETED'
			GROUP BY EXTRACT(MONTH FROM appointment_date)
			ORDER BY EXTRACT(MONTH FROM appointment_date)
			""", nativeQuery = true)
	List<Object[]> countCompletedAppointmentsMonthWise(@Param("year") Integer year);
}
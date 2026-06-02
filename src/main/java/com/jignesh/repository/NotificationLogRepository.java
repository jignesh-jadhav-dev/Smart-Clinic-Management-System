package com.jignesh.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.NotificationLog;
import com.jignesh.entity.User;

public interface NotificationLogRepository extends JpaRepository<NotificationLog, Long> {
	List<NotificationLog> findByUserOrderByCreatedAtDesc(User user);

	Optional<NotificationLog> findByIdAndUser(Long id, User user);

	long countByUserAndReadFlagFalse(User user);
}
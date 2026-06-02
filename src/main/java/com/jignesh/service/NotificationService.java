package com.jignesh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jignesh.entity.NotificationLog;
import com.jignesh.entity.User;
import com.jignesh.repository.NotificationLogRepository;
import com.jignesh.repository.UserRepository;

@Service
public class NotificationService {

	private final NotificationLogRepository notificationLogRepository;
	private final UserRepository userRepository;

	public NotificationService(NotificationLogRepository notificationLogRepository, UserRepository userRepository) {
		this.notificationLogRepository = notificationLogRepository;
		this.userRepository = userRepository;
	}

	public void createNotification(User user, String title, String message, String type) {
		if (user == null) {
			return;
		}
		NotificationLog notification = new NotificationLog();
		notification.setUser(user);
		notification.setTitle(title);
		notification.setMessage(message);
		notification.setType(type);
		notification.setReadFlag(false);
		notificationLogRepository.save(notification);
	}

	public void notifyAdmin(String title, String message, String type) {
		userRepository.findByRole("ADMIN").ifPresent(admin -> createNotification(admin, title, message, type));
	}

	public List<NotificationLog> getMyNotifications(User user) {
		if (user == null) {
			return List.of();
		}
		return notificationLogRepository.findByUserOrderByCreatedAtDesc(user);
	}

	public long getUnreadCount(User user) {
		if (user == null) {
			return 0;
		}
		return notificationLogRepository.countByUserAndReadFlagFalse(user);
	}

	public void markAsRead(Long notificationId, User user) {
		notificationLogRepository.findByIdAndUser(notificationId, user).ifPresent(notification -> {
			notification.setReadFlag(true);
			notificationLogRepository.save(notification);
		});
	}
}
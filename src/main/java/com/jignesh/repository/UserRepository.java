package com.jignesh.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jignesh.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
	Optional<User> findByEmail(String email);

	Optional<User> findByRole(String role);
}
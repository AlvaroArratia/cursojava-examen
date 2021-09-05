package com.cursojava.taskmanager.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.security.crypto.bcrypt.BCrypt;

import com.cursojava.taskmanager.models.User;
import com.cursojava.taskmanager.repositories.UserRepository;

@Service
public class UserService {

	private final UserRepository userRepository;

	public UserService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	public User registerUser(User user) {
		String hashedPass = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashedPass);
		return userRepository.save(user);
	}

	public User findUserByEmail(String userEmail) {
		return userRepository.findByEmail(userEmail);
	}

	public User findUserById(Long userId) {
		Optional<User> user = userRepository.findById(userId);
		if (user.isPresent()) {
			return user.get();
		} else {
			return null;
		}
	}

	public boolean authUser(String userEmail, String userPassword) {
		User user = userRepository.findByEmail(userEmail);
		if (user == null) {
			return false;
		} else {
			if (BCrypt.checkpw(userPassword, user.getPassword())) {
				return true;
			} else {
				return false;
			}
		}
	}

	public List<User> getUsers() {
		return (List<User>) userRepository.findAll();
	}
}

package com.cursojava.taskmanager.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cursojava.taskmanager.models.Task;
import com.cursojava.taskmanager.repositories.TaskRepository;

@Service
public class TaskService {

	private final TaskRepository taskRepository;

	public TaskService(TaskRepository taskRepository) {
		this.taskRepository = taskRepository;
	}

	public Task createTask(Task task) {
		return taskRepository.save(task);
	}
	
	public void deleteTask(Long taskId) {
		taskRepository.deleteById(taskId);
	}

	public void updateTask(Task task) {
		taskRepository.save(task);
	}

	public List<Task> getAll() {
		return (List<Task>) taskRepository.findAll();
	}

	public Task findTaskById(Long taskId) {
		Optional<Task> task = taskRepository.findById(taskId);
		if (task.isPresent()) {
			return task.get();
		} else {
			return null;
		}
	}
}

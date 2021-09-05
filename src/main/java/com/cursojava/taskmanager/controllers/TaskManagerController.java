package com.cursojava.taskmanager.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cursojava.taskmanager.models.Task;
import com.cursojava.taskmanager.models.User;
import com.cursojava.taskmanager.services.TaskService;
import com.cursojava.taskmanager.services.UserService;
import com.cursojava.taskmanager.validator.UserValidator;

@Controller
public class TaskManagerController {

	private final UserService userService;
	private final TaskService taskService;
	private final UserValidator userValidator;

	public TaskManagerController(UserService userService, TaskService taskService, UserValidator userValidator) {
		this.userService = userService;
		this.taskService = taskService;
		this.userValidator = userValidator;
	}

	@RequestMapping("/")
	public String index(@ModelAttribute("user") User user) {
		return "index.jsp";
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		User userEmailVerification = userService.findUserByEmail(user.getEmail());
		if (result.hasErrors() || userEmailVerification != null) {
			return "index.jsp";
		}
		User newUser = userService.registerUser(user);
		session.setAttribute("userId", newUser.getId());
		return "redirect:/tasks";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(@RequestParam("logEmail") String logEmail, @RequestParam("logPassword") String logPassword, Model model,
			HttpSession session, @ModelAttribute("user") User user) {
		boolean isAuthenticated = userService.authUser(logEmail, logPassword);
		if (isAuthenticated) {
			User logUser = userService.findUserByEmail(logEmail);
			session.setAttribute("userId", logUser.getId());
			return "redirect:/tasks";
		} else {
			model.addAttribute("error", "Credenciales invalidas. Intentelo nuevamente.");
			return "index.jsp";
		}
	}

	@RequestMapping("/tasks")
	public String homepage(HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			Long userId = (Long) session.getAttribute("userId");
			User currentUser = userService.findUserById(userId);
			model.addAttribute("user", currentUser);
			List<Task> tasklist = taskService.getAll();
			model.addAttribute("tasks", tasklist);
			return "home.jsp";
		} else {
			return "noAccess.jsp";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("/tasks/new")
	public String displayTaskCreation(@ModelAttribute("task") Task myTask, Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			List<User> allusers = userService.getUsers();
			model.addAttribute("users", allusers);
			Long userId = (Long) session.getAttribute("userId");
			User currentUser = userService.findUserById(userId);
			model.addAttribute("currentUser", currentUser);
			return "createTask.jsp";
		} else {
			return "noAccess.jsp";
		}
	}

	@RequestMapping(value = "/tasks/new", method = RequestMethod.POST)
	public String createNewTask(@Valid @ModelAttribute("task") Task task, BindingResult result, HttpSession session,
			Model model, RedirectAttributes limitError) {
		if (session.getAttribute("userId") != null) {
			Long userId = (Long) session.getAttribute("userId");
			User currentUser = userService.findUserById(userId);
			model.addAttribute("user", currentUser);

			if (result.hasErrors()) {
				List<User> allusers = userService.getUsers();
				model.addAttribute("users", allusers);
				return "createTask.jsp";
			} else {
				Long assigneeId = (Long) task.getAssignee().getId();
				User myAssigneeTasks = userService.findUserById(assigneeId);
				List<Task> myAssigneeTasksList = myAssigneeTasks.getAssignedTasks();
				if (myAssigneeTasksList.size() >= 3) {
					List<User> allusers = userService.getUsers();
					model.addAttribute("users", allusers);
					limitError.addFlashAttribute("errors", "Un usuario no puede tener mas de 3 tareas asignadas.");
					return "redirect:/tasks/new";
				} else {
					Task newTask = taskService.createTask(task);
					newTask.setCreator(currentUser);
					taskService.updateTask(newTask);
					return "redirect:/tasks";
				}
			}
		} else {
			return "noAccess.jsp";
		}
	}

	@RequestMapping("/tasks/{id}")
	public String displayTask(Model model, HttpSession session, @PathVariable("id") Long taskId) {
		if (session.getAttribute("userId") != null) {
			Task currentTask = taskService.findTaskById(taskId);
			model.addAttribute("task", currentTask);
			Long userId = (Long) session.getAttribute("userId");
			User currentUser = userService.findUserById(userId);
			model.addAttribute("currentUserId", currentUser.getId());
			return "taskView.jsp";
		} else {
			return "noAccess.jsp";
		}
	}

	@RequestMapping("/tasks/{id}/edit")
	public String displayEditPage(Model model, @ModelAttribute("edittask") Task editTask, @PathVariable("id") Long taskId,
			HttpSession session) {
		if (session.getAttribute("userId") != null) {
			Long userId = (Long) session.getAttribute("userId");
			User currentUser = userService.findUserById(userId);
			Task editingTask = taskService.findTaskById(taskId);

			if (currentUser.getId() == editingTask.getCreator().getId()) {
				List<User> allUsers = userService.getUsers();
				model.addAttribute("creator", editingTask.getCreator());
				model.addAttribute("edittask", editingTask);
				model.addAttribute("users", allUsers);
				model.addAttribute("id", editingTask.getId());
				return "editTask.jsp";
			} else {
				return "redirect:/tasks";
			}
		} else {
			return "noAccess.jsp";
		}
	}

	@RequestMapping(value = "/tasks/{id}/edit", method = RequestMethod.POST)
	public String updateTask(Model model, @Valid @ModelAttribute("edittask") Task editTask, BindingResult result,
			@PathVariable("id") Long taskId, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			if (result.hasErrors()) {
				List<User> allusers = userService.getUsers();
				model.addAttribute("users", allusers);
				return "editTask.jsp";
			} else {
				taskService.createTask(editTask);
				return "redirect:/tasks";
			}
		} else {
			return "noAccess.jsp";
		}
	}

	@RequestMapping("/tasks/{id}/delete")
	public String deleteTask(@PathVariable("id") Long taskId, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			Task deletedTask = taskService.findTaskById(taskId);
			if (deletedTask != null) {
				taskService.deleteTask(taskId);
				return "redirect:/tasks";
			} else {
				return "redirect:/tasks";
			}
		} else {
			return "noAccess.jsp";
		}
	}
}

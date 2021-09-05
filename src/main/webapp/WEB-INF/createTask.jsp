<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Administrador de tareas</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>
	<div class="container">
		<h1 class="mt-5">Crear nueva tarea</h1>
		<div class="col col-6 mt-5">
			<form:form method="POST" action="/tasks/new" modelAttribute="task">
				<div class="mb-3">
					<form:label path="taskName" for="taskNameInput" class="form-label">Nombre de la tarea</form:label>
					<form:input path="taskName" class="form-control" id="taskNameInput" />
				</div>
				<div class="mb-3">
					<form:label path="assignee" for="assigneeSelect" class="form-label">Encargado</form:label>
					<form:select path="assignee" class="form-select"
						id="assigneeSelect">
						<form:option value="">Seleccionar usuario</form:option>
						<c:forEach items="${users}" var="user">
							<form:option value="${user}">
								<c:out value="${user.name}" />
							</form:option>
						</c:forEach>
					</form:select>
				</div>
				<div class="mb-3">
					<form:label path="priority" for="prioritySelect">Prioridad</form:label>
					<form:select path="priority" class="form-select"
						id="prioritySelect">
						<form:option value="">Seleccionar prioridad</form:option>
						<form:option value="1">Baja</form:option>
						<form:option value="2">Media</form:option>
						<form:option value="3">Alta</form:option>
					</form:select>
				</div>
				<button type="submit" value="Create" class="btn btn-primary">Crear</button>
				<a class="btn btn-secondary mt-1 mb-1" href="/tasks" role="button">Volver</a>
			</form:form>
			
			<span class="text-danger"><form:errors path="task.*"></form:errors></span>
			<br> <span class="text-danger"><c:out value="${errors}" /></span>
		</div>
		<div class="col col-6"></div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
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
		<div class="row">
			<div class="col col-8">
				<h1 class="mt-3">
					Bienvenido
					<c:out value="${user.name}" />
				</h1>
			</div>
			<div class="col col-4 d-flex align-items-center justify-content-end">
				<a href="/logout">Cerrar sesión</a>
			</div>
		</div>
		<div class="row pt-5 mb-5">
			<table class="table table-striped table-hover ml-5">
				<thead>
					<tr>
						<th>Tarea</th>
						<th>Creador</th>
						<th>Encargado</th>
						<th>Prioridad</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${tasks}" var="task" varStatus="loop">
						<tr>
							<td><a href="/tasks/${task.id}">${task.taskName }</a></td>
							<td>${task.creator.getName()}</td>
							<td>${task.assignee.getName()}</td>
							<c:if test="${task.priority==1}">
								<td>Baja</td>
							</c:if>
							<c:if test="${task.priority==2}">
								<td>Media</td>
							</c:if>
							<c:if test="${task.priority==3}">
								<td>Alta</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<a href="/tasks/new" class="btn btn-primary" role="button">Crear
			tarea</a>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js">
		
	</script>
</body>
</html>
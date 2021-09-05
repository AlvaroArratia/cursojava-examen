<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<h1 class="mt-5">
			Tarea:
			<c:out value="${task.taskName}" />
		</h1>
		<div class="col col-6 mt-5">
			<div class="row">
				<p>
					<span>Creador:</span> <span>${task.creator.getName()}</span>
				</p>
			</div>
			<div class="row">
				<p>
					<span>Encargado:</span> <span>${task.assignee.getName()}</span>
				</p>
			</div>
			<div class="row">
				<p>
					<span>Prioridad:</span>
					<c:if test="${task.priority==1}">
						<span>Baja</span>
					</c:if>
					<c:if test="${task.priority==2}">
						<span>Media</span>
					</c:if>
					<c:if test="${task.priority==3}">
						<span>Alta</span>
					</c:if>
				</p>
			</div>
			<c:if test="${task.creator.getId()==currentUserId}">
				<a class="btn btn-warning" href="/tasks/${task.id}/edit"
					role="button">Editar</a>
				<a class="btn btn-danger" href="/tasks/${task.id}/delete"
					role="button">Eliminar</a>
			</c:if>
			<c:if test="${task.assignee.getId()==currentUserId}">
				<a class="btn btn-success" href="/tasks/${task.id}/delete"
					role="button">Tarea completada</a>
			</c:if>
			<a class="btn btn-secondary" href="/tasks"
					role="button">Volver</a>
		</div>
		<div class="col col-6"></div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
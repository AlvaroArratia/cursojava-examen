<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<h1 class="mt-3 text-center">Administrador de tareas</h1>
		<div class="row mt-5">
			<div class="col col-6">
				<h3>Registrarse</h3>
				<form:form method="POST" action="/registration"
					modelAttribute="user">
					<div class="mb-3">
						<form:label path="name" for="regUserName" class="form-label">Nombre</form:label>
						<form:input path="name" type="text" class="form-control"
							id="regUserName" />
					</div>
					<div class="mb-3">
						<form:label path="email" for="regUserEmail" class="form-label">Email</form:label>
						<form:input path="email" type="email" class="form-control"
							id="regUserEmail" />
					</div>
					<div class="mb-3">
						<form:label path="password" for="regUserPass" class="form-label">Contraseña</form:label>
						<form:input path="password" type="password" class="form-control"
							id="regUserPass" />
					</div>
					<div class="mb-3">
						<form:label path="passwordConfirmation" for="regUserPassConfirm"
							class="form-label">Confirmar contraseña</form:label>
						<form:input path="passwordConfirmation" type="password"
							class="form-control" id="regUserPassConfirm" />
					</div>
					<button type="submit" value="Register!" class="btn btn-primary">Registrarse</button>
					<span class="text-danger"><form:errors path="user.*" /></span>
				</form:form>
			</div>
			<div class="col col-6">
				<h3>Ingresar</h3>
				<form method="post" action="/login">
					<div class="mb-3">
						<label for="logUserEmail" class="form-label">Email</label> <input
							type="email" name="logEmail" class="form-control" id="logUserEmail">
					</div>
					<div class="mb-3">
						<label for="logUserPass" class="form-label">Contraseña</label> <input
							type="password" name="logPassword" class="form-control" id="logUserPass">
					</div>
					<button type="submit" value="Login" class="btn btn-primary mb-1">Ingresar</button> <br>
					<span class="text-danger"><c:out value="${error}" /></span>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js">
		
	</script>
</body>

</html>
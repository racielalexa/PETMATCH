<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<style>
  body {
    background-color: #FFE8C3;
    color: #5B3B00;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .btn-primary {
    background-color: #FF7700;
    border-color: #FF7700;
    color: white;
  }
  .btn-primary:hover {
    background-color: #e06900;
    border-color: #e06900;
  }
  .form-label {
    font-weight: 600;
  }
</style>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-6">

      <h2 class="mb-4 text-center">Registro de usuario</h2>

      <% if ("error".equals(request.getParameter("status"))) { %>
        <div class="alert alert-danger" role="alert">
          Error al registrar usuario. Intenta de nuevo.
        </div>
      <% } else if ("success".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success" role="alert">
          Registro exitoso. Ahora puedes <a href="login.jsp">iniciar sesión</a>.
        </div>
      <% } %>

      <form action="crear-usuario" method="post">
        <div class="mb-3">
          <label for="nombre" class="form-label">Nombre completo</label>
          <input type="text" id="nombre" name="nombre" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="email" class="form-label">Correo electrónico</label>
          <input type="email" id="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="password" class="form-label">Contraseña</label>
          <input type="password" id="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="rol" class="form-label">Tipo de usuario</label>
          <select id="rol" name="rol" class="form-select" required>
            <option value="user" selected>Adoptante</option>
            <option value="admin">Refugio</option>
          </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Registrarse</button>
      </form>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

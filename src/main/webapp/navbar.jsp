<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    com.svalero.petmatch.model.Usuario usuario = (com.svalero.petmatch.model.Usuario) session.getAttribute("usuario");
    String rol = usuario == null ? "guest" : usuario.getRol();
%>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand text-primary fw-bold" href="index.jsp">PetMatch</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu" aria-controls="navMenu" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div id="navMenu" class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a href="listarMascotas.jsp" class="nav-link">Mascotas</a></li>
        <li class="nav-item"><a href="listarRefugios" class="nav-link">Refugios</a></li>
        <li class="nav-item"><a href="donaciones.jsp" class="nav-link">Contribuye</a></li>
      </ul>

      <ul class="navbar-nav align-items-center">
        <% if (!"guest".equals(rol)) { %>
          <!-- Usuario logueado -->
          <li class="nav-item me-3">
            <span class="navbar-text">Hola, <strong><%= usuario.getNombre() %></strong>!</span>
          </li>

          <li class="nav-item"><a href="perfil.jsp" class="nav-link">Mi perfil</a></li>

          <% if ("admin".equals(rol)) { %>
            <!-- Opciones para admin/refugio -->
            <li class="nav-item"><a href="solicitudes" class="nav-link">Solicitudes de Adopción</a></li>
          <% } else { %>
            <!-- Opciones para usuario normal -->
            <li class="nav-item"><a href="solicitudes" class="nav-link">Mis Solicitudes</a></li>
          <% } %>

          <li class="nav-item"><a href="logout" class="nav-link text-danger">Cerrar sesión</a></li>

        <% } else { %>
          <!-- Usuario no logueado -->
          <li class="nav-item"><a href="login.jsp" class="nav-link">Iniciar sesión</a></li>
          <li class="nav-item"><a href="registro.jsp" class="btn btn-primary ms-2">Regístrate</a></li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<style>
  .navbar .btn-primary {
    background-color: #FF7700;
    border-color: #FF7700;
    color: white;
  }
  .navbar .btn-primary:hover {
    background-color: #e06900;
    border-color: #e06900;
  }
  .nav-link.text-danger {
    color: #d9534f !important;
  }
</style>

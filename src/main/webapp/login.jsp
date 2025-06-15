<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Usuario" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>


<style>
  body {
    background-color: #FFE8C3;
    color: #5B3B00;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .btn-primary, .btn-success {
    background-color: #FF7700;
    border-color: #FF7700;
    color: white;
  }
  .btn-primary:hover, .btn-success:hover {
    background-color: #e06900;
    border-color: #e06900;
  }
  .nav-pills .nav-link.active {
    background-color: #FF7700;
    color: white;
  }
  .nav-pills .nav-link {
    color: #5B3B00;
  }
  .nav-pills .nav-link:hover {
    color: #FF7700;
  }
  .animalito i {
    font-size: 2rem;
  }
  .animalito {
    position: absolute;
    top: 50px;
    left: -50px;
    animation: correr 10s linear infinite;
  }
  @keyframes correr {
    0% { left: -50px; }
    100% { left: 110%; }
  }
</style>

<section class="container py-5">
  <% if ("guest".equals(rol)) { %>
    <div class="row justify-content-center">
      <div class="col-md-6">
        <ul class="nav nav-pills mb-4 justify-content-center" id="authTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="login-tab" data-bs-toggle="pill" data-bs-target="#login" type="button" role="tab" aria-controls="login" aria-selected="true">Iniciar Sesión</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="register-tab" data-bs-toggle="pill" data-bs-target="#register" type="button" role="tab" aria-controls="register" aria-selected="false">Registro</button>
          </li>
        </ul>

        <div class="tab-content">
          <!-- LOGIN -->
          <div id="login" class="tab-pane fade show active" role="tabpanel" aria-labelledby="login-tab">
            <form action="login" method="post">
              <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control" required />
              </div>
              <% if ("1".equals(request.getParameter("error"))) { %>
                <div class="alert alert-danger">Email o contraseña incorrectos.</div>
              <% } %>
              <button type="submit" class="btn btn-primary w-100 mb-2">Entrar</button>
            </form>
          </div>

          <!-- REGISTER -->
          <div id="register" class="tab-pane fade" role="tabpanel" aria-labelledby="register-tab">
            <form action="crear-usuario" method="post">
              <div class="mb-3">
                <label class="form-label">Nombre completo</label>
                <input type="text" name="nombre" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">Soy:</label>
                <select name="rol" class="form-select" required>
                  <option value="user">Adoptante</option>
                  <option value="admin">Refugio</option>
                </select>
              </div>
              <button type="submit" class="btn btn-success w-100">Registrarse</button>
            </form>
          </div>
        </div>

        <!-- Animación suave en el fondo -->
        <div class="position-relative mt-4" style="height:120px;">
          <div class="animalito" style="animation-delay:0s;">
            <i class="bi bi-heart-pulse-fill text-danger"></i>
          </div>
          <div class="animalito" style="animation-delay:2s;">
            <i class="bi bi-emoji-smile-fill text-warning"></i>
          </div>
        </div>
      </div>
    </div>
  <% } else { %>
    <!-- Si ya inició sesión -->
    <div class="text-center py-5">
      <h3>Hola, <strong><%= usuario.getNombre() %></strong>!</h3>
      <p>Ya has iniciado sesión como <em><%= rol %></em>.</p>
      <% if ("admin".equals(rol)) { %>
        <a href="nuevaMascota.jsp" class="btn btn-warning me-2">Añadir mascota</a>
        <a href="admin/solicitudes" class="btn btn-warning me-2">Solicitudes de adopción</a>
        <a href="logout" class="btn btn-danger">Cerrar sesión</a>
      <% } else { %>
        <a href="listarMascotas.jsp" class="btn btn-success me-2">Ver mascotas</a>
        <a href="misSolicitudes.jsp" class="btn btn-success me-2">Mis solicitudes</a>
        <a href="logout" class="btn btn-danger">Cerrar sesión</a>
      <% } %>
    </div>
  <% } %>
</section>

<%@ include file="footer.jsp" %>

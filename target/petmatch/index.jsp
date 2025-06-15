<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Usuario" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>



<section class="position-relative overflow-hidden text-dark" style="min-height: 90vh; background: #FFE8C3;">
    <div class="container py-5 text-center">
        <h1 class="display-3 fw-bold" style="color:#FF7700;">Encuentra tu nuevo mejor amigo 🐾</h1>
        <p class="lead mb-4" style="color:#5B3B00;">Explora refugios, adopta o colabora con PetMatch</p>

      <% if ("guest".equals(rol)) { %>
    <a href="login.jsp" class="btn btn-lg" style="background-color:#FF7700; color:#fff; margin-right: 10px;">Iniciar sesión</a>
    <a href="registro.jsp" class="btn btn-lg btn-outline-danger" style="border-color:#FF7700; color:#FF7700;">Registrarse</a>
<% } else if ("admin".equals(rol)) { %>
    <p class="text-muted" style="color:#1E50C5; font-weight:bold;">
        Hola <strong><%= usuario.getNombre().toUpperCase() %></strong>, gestiona tus refugios y solicitudes aquí 👇
    </p>
<% } else { %>
    <p class="text-muted" style="color:#5B3B00;">Hola <strong><%= usuario.getNombre() %></strong>, explora las opciones que te ofrecemos 👇</p>
<% } %>

    </div>

    <!-- Animación mascotas corriendo -->
    <div class="position-absolute bottom-0 start-0 w-100 overflow-hidden" style="height: 120px; pointer-events: none;">
        <div class="runner" style="--delay: 0s;"><img src="media/dog1.svg" height="80" alt="Perro 1"></div>
        <div class="runner" style="--delay: 2.5s;"><img src="media/ball1.svg" height="50" alt="Pelota"></div>
        <div class="runner" style="--delay: 5s;"><img src="media/dog2.svg" height="80" alt="Perro 2"></div>
    </div>
</section>

<style>
    .runner {
        position: absolute;
        bottom: 0;
        left: -100px;
        animation: correr 12s linear infinite;
        animation-delay: var(--delay);
    }
    @keyframes correr {
        0% { left: -100px; }
        100% { left: 110%; }
    }
</style>

<section class="container py-5">
    <div class="row text-center">
        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="icons/dog.svg" height="40" alt="Icono perros">
                <h5 class="mt-3" style="color:#FF7700;">Mascotas</h5>
                <p style="color:#5B3B00;">Perros y gatos en adopción</p>
                <a href="listarMascotas.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Ver mascotas</a>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="icons/house.svg" height="40" alt="Icono refugios">
                <h5 class="mt-3" style="color:#FF7700;">Refugios</h5>
                <p style="color:#5B3B00;">Colabora con organizaciones cercanas</p>
                <a href="listarRefugios.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Ver refugios</a>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="icons/heart.svg" height="40" alt="Icono adopciones">
                <h5 class="mt-3" style="color:#FF7700;">Adopciones recientes</h5>
                <p style="color:#5B3B00;">Historias felices que inspiran</p>
                <a href="adopciones.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Ver adopciones</a>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="icons/quiz.svg" height="40" alt="Icono quiz">
                <h5 class="mt-3" style="color:#FF7700;">Quiz de adopción</h5>
                <p style="color:#5B3B00;">Descubre tu mascota ideal</p>
                <a href="quiz.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Hacer quiz</a>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

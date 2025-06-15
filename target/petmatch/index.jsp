<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Usuario" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>


<section class="position-relative overflow-hidden text-dark" style="min-height: 90vh; background: #FFE8C3;">
    <div class="container py-5 text-center">
        <h1 class="display-3 fw-bold text-orange">Encuentra tu nuevo mejor amigo 🐾</h1>
        <p class="lead text-brown mb-4">Explora refugios, adopta o colabora con PetMatch</p>

        <% if ("guest".equals(rol)) { %>
            <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-lg btn-primary me-2">Iniciar sesión</a>
            <a href="<%=request.getContextPath()%>/registro.jsp" class="btn btn-lg btn-outline-danger">Registrarse</a>
        <% } else if ("admin".equals(rol)) { %>
            <p class="text-muted"><strong>Hola <%= usuario.getNombre().toUpperCase() %></strong>, gestiona tus refugios y solicitudes aquí 👇</p>
        <% } else { %>
            <p class="text-muted"><strong>Hola <%= usuario.getNombre() %></strong>, explora las opciones que te ofrecemos 👇</p>
        <% } %>
    </div>

    <!-- Animación top perros corriendo -->
    <div class="position-absolute bottom-0 start-0 w-100 overflow-hidden" style="height: 120px; pointer-events: none;">
        <div class="runner" style="--delay: 0s;">
            <img src="https://cdn-icons-png.flaticon.com/128/616/616408.png" height="80" alt="Perro corriendo">
        </div>
        <div class="runner" style="--delay: 2.5s;">
            <img src="https://cdn-icons-png.flaticon.com/128/1530/1530151.png" height="50" alt="Pelota">
        </div>
        <div class="runner" style="--delay: 5s;">
            <img src="https://cdn-icons-png.flaticon.com/128/616/616408.png" height="80" alt="Perro corriendo">
        </div>
    </div>
</section>

<style>
.text-orange { color: #FF7700; }
.text-brown { color: #5B3B00; }
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
                <img src="https://cdn-icons-png.flaticon.com/128/194/194279.png" height="40" alt="Icono perros">
                <h5 class="mt-3 text-orange">Mascotas</h5>
                <p class="text-brown">Perros y gatos en adopción</p>
                <a href="<%=request.getContextPath()%>/listarmascotas" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Ver mascotas</a>
            </div>
        </div>
        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="https://cdn-icons-png.flaticon.com/128/263/263114.png" height="40" alt="Icono refugios">
                <h5 class="mt-3 text-orange">Refugios</h5>
                <p class="text-brown">Colabora con organizaciones cercanas</p>
                <a href="<%=request.getContextPath()%>/listarRefugios.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Ver refugios</a>
            </div>
        </div>
        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="https://cdn-icons-png.flaticon.com/128/4100/4100759.png" height="40" alt="Icono adopciones">
                <h5 class="mt-3 text-orange">Adopciones recientes</h5>
                <p class="text-brown">Historias felices que inspiran</p>
                <a href="<%=request.getContextPath()%>/adopciones.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Ver adopciones</a>
            </div>
        </div>
        <div class="col-md-3 mb-4">
            <div class="p-4 border rounded-4 shadow-sm bg-white">
                <img src="https://cdn-icons-png.flaticon.com/128/3580/3580904.png" height="40" alt="Icono quiz">
                <h5 class="mt-3 text-orange">Quiz de adopción</h5>
                <p class="text-brown">Descubre tu mascota ideal</p>
                <a href="<%=request.getContextPath()%>/quiz.jsp" class="btn btn-sm btn-outline-primary" style="border-color:#FF7700; color:#FF7700;">Hacer quiz</a>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

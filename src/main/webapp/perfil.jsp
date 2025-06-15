<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Usuario" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<%
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<section class="container py-5" style="background-color: #FFE8C3; color: #5B3B00; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; border-radius: 10px;">
    <h2 class="mb-4" style="color:#FF7700;">Perfil de Usuario</h2>

    <div class="card p-4" style="border-radius: 10px; background-color: #fff; color: #5B3B00;">
        <h4>Datos Personales</h4>
        <p><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
        <p><strong>Email:</strong> <%= usuario.getEmail() %></p>
        <p><strong>Rol:</strong> <%= "admin".equals(rol) ? "Refugio" : "Adoptante" %></p>

        <% if ("admin".equals(rol)) { %>
            <h5 class="mt-4">Opciones de Refugio</h5>
            <ul>
                <li><a href="nuevaMascota.jsp" class="btn btn-sm btn-warning mb-2">Añadir Mascota</a></li>
                <li><a href="admin/solicitudes" class="btn btn-sm btn-warning mb-2">Gestionar Solicitudes de Adopción</a></li>
                <li><a href="editarPerfil.jsp" class="btn btn-primary mt-3">Editar Perfil</a></li>
            </ul>
        <% } else { %>
            <h5 class="mt-4">Opciones de Adoptante</h5>
            <ul>
                <li><a href="misSolicitudes.jsp" class="btn btn-sm btn-success mb-2">Ver Mis Solicitudes</a></li>
                <li><a href="quiz.jsp" class="btn btn-sm btn-success mb-2">Realizar Quiz de Adopción</a></li>
                <li><a href="editarPerfil.jsp" class="btn btn-primary mt-3">Editar Perfil</a></li>
            </ul>
        <% } %>
    </div>
</section>

<%@ include file="footer.jsp" %>

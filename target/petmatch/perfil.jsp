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
        <!-- Formulario de edición de usuario -->
        <form action="editar-usuario" method="post" class="mb-4">
            <div class="mb-3">
                <label for="nombre" class="form-label"><strong>Nombre:</strong></label>
                <input type="text" class="form-control" name="nombre" id="nombre" value="<%= usuario.getNombre() %>" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label"><strong>Email:</strong></label>
                <input type="email" class="form-control" name="email" id="email" value="<%= usuario.getEmail() %>" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label"><strong>Contraseña:</strong></label>
                <input type="password" class="form-control" name="password" id="password" value="<%= usuario.getPassword() %>" required>
            </div>
            <div class="mb-3">
                <label for="rol" class="form-label"><strong>Rol:</strong></label>
                <input type="text" class="form-control" id="rol" value="<%= "admin".equals(rol) ? "Refugio" : "Adoptante" %>" readonly>
            </div>
            <button type="submit" class="btn btn-primary">Guardar cambios</button>
        </form>

        <!-- Botón eliminar cuenta -->
        <form action="eliminar-usuario" method="get" onsubmit="return confirm('¿Seguro que quieres eliminar tu cuenta? Esta acción es irreversible.');">
            <button type="submit" class="btn btn-danger mt-3">Eliminar mi cuenta</button>
        </form>
    </div>
</section>

<%@ include file="footer.jsp" %>

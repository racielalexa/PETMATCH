<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.petmatch.model.Usuario" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
    String filtroNombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
    String filtroRol = request.getParameter("rol") != null ? request.getParameter("rol") : "";
    String idDetalleStr = request.getParameter("id");
    Usuario usuarioDetalle = null;

    if (idDetalleStr != null) {
        int idDetalle = Integer.parseInt(idDetalleStr);
        for (Usuario u : usuarios) {
            if (u.getId() == idDetalle) {
                usuarioDetalle = u;
                break;
            }
        }
    }
%>

<div class="container py-4">
    <h2 class="text-orange mb-4">Buscar usuarios</h2>
    <form method="get" action="listarUsuarios" class="row g-3 mb-4">
        <div class="col-md-5">
            <input type="text" name="nombre" placeholder="Nombre" class="form-control" value="<%= filtroNombre %>">
        </div>
        <div class="col-md-3">
            <select name="rol" class="form-select">
                <option value="">Todos</option>
                <option value="user" <%= "user".equals(filtroRol) ? "selected" : "" %>>Adoptante</option>
                <option value="admin" <%= "admin".equals(filtroRol) ? "selected" : "" %>>Refugio</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-orange w-100">Filtrar</button>
        </div>
    </form>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <% if (usuarios != null && !usuarios.isEmpty()) {
            for (Usuario u : usuarios) { %>
                <div class="col">
                    <div class="card shadow-sm h-100">
                        <div class="card-body">
                            <h5 class="card-title text-primary"><%= u.getNombre() %></h5>
                            <p class="card-text"><strong>Email:</strong> <%= u.getEmail() %></p>
                            <p class="card-text"><strong>Rol:</strong> <%= "user".equals(u.getRol()) ? "Adoptante" : "Refugio" %></p>
                            <a href="listarUsuarios?nombre=<%= filtroNombre %>&rol=<%= filtroRol %>&id=<%= u.getId() %>" class="btn btn-sm btn-primary">Ver detalle</a>
                        </div>
                    </div>
                </div>
        <%  }
           } else { %>
            <p class="text-center text-muted">No hay usuarios para mostrar.</p>
        <% } %>
    </div>

    <% if (usuarioDetalle != null) { %>
        <hr class="my-5"/>
        <h3 class="text-orange mb-4">Detalle de Usuario: <%= usuarioDetalle.getNombre() %></h3>
        <div class="card p-4 mb-5" style="max-width: 600px;">
            <p><strong>Email:</strong> <%= usuarioDetalle.getEmail() %></p>
            <p><strong>Rol:</strong> <%= usuarioDetalle.getRol() %></p>
            <p><strong>Fecha registro:</strong> <%= usuarioDetalle.getFechaRegistro() %></p>
            <p><strong>Activo:</strong> <%= usuarioDetalle.isActivo() ? "Sí" : "No" %></p>
        </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Refugio" %>
<%
    // Si viene desde editar, rellenamos el formulario
    Refugio refugio = (Refugio) request.getAttribute("refugio");
    boolean editar = refugio != null;
    String cp = request.getContextPath();
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-7 col-lg-6">
      <h3 class="mb-4"><%= editar ? "Editar refugio" : "Añadir refugio" %></h3>
      <form action="<%= editar ? cp + "/editar-refugio" : cp + "/crear-refugio" %>" method="post">
        <% if (editar) { %>
          <input type="hidden" name="id" value="<%= refugio.getId() %>">
        <% } %>

        <div class="mb-3">
          <label for="nombre" class="form-label">Nombre</label>
          <input class="form-control" id="nombre" name="nombre" required
                 value="<%= editar ? refugio.getNombre() : "" %>">
        </div>
        <div class="mb-3">
          <label for="direccion" class="form-label">Dirección</label>
          <input class="form-control" id="direccion" name="direccion" required
                 value="<%= editar ? refugio.getDireccion() : "" %>">
        </div>
        <div class="mb-3">
          <label for="telefono" class="form-label">Teléfono</label>
          <input class="form-control" id="telefono" name="telefono" required
                 value="<%= editar ? refugio.getTelefono() : "" %>">
        </div>
        <div class="mb-3">
          <label for="email_contacto" class="form-label">Email de contacto</label>
          <input class="form-control" id="email_contacto" name="email_contacto" type="email" required
                 value="<%= editar ? refugio.getEmailContacto() : "" %>">
        </div>
        <div class="mb-3">
          <label for="web" class="form-label">Página web</label>
          <input class="form-control" id="web" name="web"
                 value="<%= editar ? refugio.getWeb() : "" %>">
        </div>
        <div class="mb-3">
  <label for="fecha_alta" class="form-label">Fecha de alta</label>
  <input class="form-control" id="fecha_alta" name="fecha_alta" type="date"
         value="<%= editar && refugio.getFechaAlta() != null ? refugio.getFechaAlta().toString() : "" %>">
</div>
        <div class="mb-3 form-check">
          <input class="form-check-input" id="activo" name="activo" type="checkbox"
                 <%= editar && refugio.isActivo() ? "checked" : (!editar ? "checked" : "") %>>
          <label class="form-check-label" for="activo">Activo</label>
        </div>
        <div class="d-flex justify-content-between">
          <button type="submit" class="btn btn-primary">
            <%= editar ? "Guardar cambios" : "Crear refugio" %>
          </button>
          <a href="<%= cp %>/listarRefugios" class="btn btn-secondary">Cancelar</a>
        </div>
      </form>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

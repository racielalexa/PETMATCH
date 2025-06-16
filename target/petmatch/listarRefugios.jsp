<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.petmatch.model.Refugio" %>

<%
    // La variable 'rol' se obtiene de navbar.jsp (NO declarar aquí).
    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
    int pageCount   = request.getAttribute("pageCount") != null   ? (Integer) request.getAttribute("pageCount")   : 1;
    List<Refugio> refugios = (List<Refugio>) request.getAttribute("refugios");
    if (refugios == null) refugios = java.util.Collections.emptyList();
    String cp = request.getContextPath();
%>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
  <h2 class="text-center mb-4">Listado de Refugios</h2>

  <% if ("admin".equals(rol)) { %>
    <div class="mb-3 text-end">
      <a href="<%= cp %>/formRefugio.jsp" class="btn btn-primary">Añadir refugio</a>
    </div>
  <% } %>

  <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
    <% for (Refugio r : refugios) { %>
      <div class="col">
        <div class="card h-100 shadow-sm">
          <div class="card-body">
            <h5 class="card-title text-primary"><%= r.getNombre() %></h5>
            <p class="card-text">
              <b>Dirección:</b> <%= r.getDireccion() %><br/>
              <b>Email:</b> <%= r.getEmailContacto() %><br/>
              <b>Teléfono:</b> <%= r.getTelefono() %><br/>
              <b>Web:</b> <%= r.getWeb() %><br/>
              <b>Activo:</b> <%= r.isActivo() ? "Sí" : "No" %><br/>
              <b>Fecha alta:</b> <%= r.getFechaAlta() %>
            </p>
          </div>
          <div class="card-footer bg-white border-top-0 d-flex justify-content-between flex-wrap">
            <a href="<%= cp %>/detalleRefugio?id=<%= r.getId() %>" class="btn btn-info btn-sm mb-1">
              Ver detalle
            </a>
            <% if ("admin".equals(rol)) { %>
              <a href="<%= cp %>/editar-refugio?id=<%= r.getId() %>" class="btn btn-warning btn-sm mb-1">Editar</a>
              <a href="<%= cp %>/eliminar-refugio?id=<%= r.getId() %>"
                 class="btn btn-danger btn-sm mb-1"
                 onclick="return confirm('¿Seguro que quieres eliminar este refugio?');">
                Eliminar
              </a>
            <% } %>
          </div>
        </div>
      </div>
    <% } %>
  </div>

  <!-- Paginación -->
  <nav aria-label="Paginación refugios" class="mt-4">
    <ul class="pagination justify-content-center">
      <li class="page-item <%= currentPage <= 1 ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage - 1 %>">Anterior</a>
      </li>
      <% for (int i = 1; i <= pageCount; i++) { %>
        <li class="page-item <%= currentPage == i ? "active" : "" %>">
          <a class="page-link" href="?page=<%= i %>"><%= i %></a>
        </li>
      <% } %>
      <li class="page-item <%= currentPage >= pageCount ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage + 1 %>">Siguiente</a>
      </li>
    </ul>
  </nav>
</div>

<%@ include file="footer.jsp" %>

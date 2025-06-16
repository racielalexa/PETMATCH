<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Refugio" %>
<%
    Refugio r = (Refugio) request.getAttribute("refugio");
    String cp = request.getContextPath();
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
  <h2 class="mb-4 text-center">Detalle de Refugio</h2>
  <% if (r != null) { %>
    <div class="card mx-auto shadow" style="max-width:500px">
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
      <div class="card-footer bg-white">
        <a href="<%= cp %>/listarRefugios" class="btn btn-secondary btn-sm">Volver al listado</a>
      </div>
    </div>
  <% } else { %>
    <div class="alert alert-danger text-center">Refugio no encontrado</div>
  <% } %>
</div>

<%@ include file="footer.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.model.Mascota" %>
<%
  Mascota m = (Mascota) request.getAttribute("mascota");
  if (m == null) {
    response.sendRedirect(request.getContextPath() + "/listarmascotas");
    return;
  }
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
  <h2>Detalle de Mascota</h2>
  <div class="row">
    <div class="col-md-6">
      <img src="<%=request.getContextPath()%>/img_mascotas/<%=m.getImage()%>"
           class="img-fluid" alt="<%=m.getNombre()%>">
    </div>
    <div class="col-md-6">
      <ul class="list-group">
        <li class="list-group-item"><strong>Nombre:</strong> <%= m.getNombre() %></li>
        <li class="list-group-item"><strong>Especie:</strong> <%= m.getEspecie() %></li>
        <li class="list-group-item"><strong>Edad:</strong> <%= m.getEdad() %> años</li>
        <li class="list-group-item"><strong>Peso:</strong> <%= m.getPeso() %> kg</li>
        <li class="list-group-item"><strong>Adoptado:</strong> <%= m.isAdoptado() ? "Sí" : "No" %></li>
        <li class="list-group-item"><strong>Refugio ID:</strong> <%= m.getIdRefugio() %></li>
        <li class="list-group-item"><strong>Fecha Ingreso:</strong> <%= m.getFechaIngreso() %></li>
      </ul>
      <a href="<%=request.getContextPath()%>/listarmascotas" class="btn btn-secondary mt-3">
        Volver al listado
      </a>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

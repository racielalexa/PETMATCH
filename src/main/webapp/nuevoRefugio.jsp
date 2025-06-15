<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<section class="container py-5">
  <h2>Registrar nuevo refugio</h2>
  <form action="crear-refugio" method="post" class="mt-4">
    <div class="mb-3">
      <label for="nombre" class="form-label">Nombre:</label>
      <input type="text" class="form-control" id="nombre" name="nombre" required>
    </div>

    <div class="mb-3">
      <label for="direccion" class="form-label">Dirección:</label>
      <input type="text" class="form-control" id="direccion" name="direccion" required>
    </div>

    <div class="mb-3">
      <label for="telefono" class="form-label">Teléfono:</label>
      <input type="text" class="form-control" id="telefono" name="telefono">
    </div>

    <div class="form-check mb-3">
      <input type="checkbox" class="form-check-input" id="activo" name="activo" checked>
      <label for="activo" class="form-check-label">Activo</label>
    </div>

    <button type="submit" class="btn btn-primary">Guardar Refugio</button>
  </form>
</section>

<%@ include file="footer.jsp" %>

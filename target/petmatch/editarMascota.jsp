
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.dao.MascotasDao" %>
<%@ page import="com.svalero.petmatch.model.Mascota" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    MascotasDao dao = new MascotasDao();
    Mascota mascota = dao.obtenerPorId(id);
%>
<html>
<head><title>Editar Mascota</title></head>
<body>
<h2>Editar Mascota</h2>
<form action="actualizar-mascota" method="post">
    <input type="hidden" name="id" value="<%= mascota.getId() %>">
    <label>Nombre:</label><br>
    <input type="text" name="nombre" value="<%= mascota.getNombre() %>" required><br>

    <label>Edad:</label><br>
    <input type="number" name="edad" value="<%= mascota.getEdad() %>" required><br>

    <label>Especie:</label><br>
    <input type="text" name="especie" value="<%= mascota.getEspecie() %>" required><br>

    <label>Descripción:</label><br>
    <textarea name="descripcion"><%= mascota.getDescripcion() %></textarea><br>

    <label>Disponible:</label>
    <input type="checkbox" name="disponible" <%= mascota.isDisponible() ? "checked" : "" %>><br>

    <button type="submit">Actualizar</button>
</form>
</body>
</html>

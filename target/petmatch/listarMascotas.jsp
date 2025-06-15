<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.sql.SQLException, java.util.Map, java.util.HashMap" %>
<%@ page import="com.svalero.petmatch.model.Mascota" %>
<%@ page import="com.svalero.petmatch.database.Database, com.svalero.petmatch.dao.MascotasDao" %>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<style>
    body {
        background-color: #FFE8C3;
        color: #5B3B00;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    /* Tus estilos aquí */
</style>

<%
    List<Mascota> mascotas;
    Database db = new Database();
    try {
        db.connect();
        MascotasDao dao = new MascotasDao(db.getConnection());
        mascotas = dao.obtenerTodas();
    } catch (ClassNotFoundException | SQLException e) {
        throw new ServletException("Error al cargar mascotas", e);
    } finally {
        try {
            db.close();
        } catch (SQLException ignore) { }
    }

    Map<String, String> realMap = new HashMap<>();
    realMap.put("athenea", "https://tse4.mm.bing.net/th?id=OIP.aO3Li7pGawt1Uy6Q3hosmgHaE8&r=0&pid=Api");
    realMap.put("milo", "https://tse2.mm.bing.net/th?id=OIP.0DOwiD1CB1pHshbZAWg9_gHaFc&r=0&pid=Api");
    realMap.put("copito", "https://tse2.mm.bing.net/th?id=OIP.c-cM7C9ZO0xWc4pafO6oRQHaEo&r=0&pid=Api");
    realMap.put("luna", "https://tse2.mm.bing.net/th?id=OIP.gnckOEFGQnz-7AjTg_pragHaLR&r=0&pid=Api");
%>

<section class="container py-5">
    <h2 class="mb-4 text-center">Listado de Mascotas</h2>

    <% if ("admin".equals(rol)) { %>
        <div class="text-end mb-4">
            <a href="nuevaMascota.jsp" class="btn btn-warning">Añadir nueva mascota</a>
        </div>
    <% } %>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <% for (Mascota m : mascotas) {
            String nombre = m.getNombre() != null ? m.getNombre().toLowerCase() : "";
            String imgBd = m.getImage();
            String src;
            if (imgBd != null && !imgBd.isEmpty()) {
                src = request.getContextPath() + "/img_mascotas/" + imgBd;
            } else if (realMap.containsKey(nombre)) {
                src = realMap.get(nombre);
            } else {
                src = "https://via.placeholder.com/300x200?text=Mascota+Disponible";
            }
        %>
        <div class="col">
            <div class="card h-100">
                <img src="<%= src %>" alt="Foto de <%= m.getNombre() %>" class="card-img-top" />
                <div class="card-body">
                    <h5 class="card-title"><%= m.getNombre() %> - <%= m.getEspecie() %></h5>
                    <p class="card-text">
                        Edad: <%= m.getEdad() %> años<br/>
                        Peso: <%= m.getPeso() %> kg<br/>
                        Estado: <strong><%= m.isAdoptado() ? "Adoptado" : "Disponible" %></strong>
                    </p>
                </div>
                <div class="card-footer d-flex justify-content-between">
                    <a href="detalleMascota.jsp?id=<%= m.getId() %>" class="btn btn-sm btn-warning">Ver Detalle</a>

                    <% if ("admin".equals(rol)) { %>
                        <a href="editarMascota.jsp?id=<%= m.getId() %>" class="btn btn-sm btn-outline-warning">Editar</a>
                        <a href="eliminarMascota?id=<%= m.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Seguro que deseas eliminar esta mascota?');">Eliminar</a>
                    <% } else if ("user".equals(rol) && !m.isAdoptado()) { %>
                        <a href="solicitarAdopcion?id=<%= m.getId() %>" class="btn btn-sm btn-outline-success">Solicitar adopción</a>
                    <% } %>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</section>

<%@ include file="footer.jsp" %>

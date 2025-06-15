<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, com.svalero.petmatch.model.Adopcion" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<%
    // 'usuario' y 'rol' ya han sido definidos en navbar.jsp
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Object solicitudesObj = request.getAttribute("solicitudes");
%>

<section class="container py-5">
    <h2 class="mb-4 text-center" style="color:#FF7700;">Solicitudes de adopción</h2>

    <% if ("admin".equals(rol)) {
        List<Map<String, Object>> solicitudes =
            solicitudesObj != null
                ? (List<Map<String, Object>>) solicitudesObj
                : java.util.Collections.emptyList();

        if (solicitudes.isEmpty()) { %>
            <p class="text-center" style="color:#5B3B00;">
                No hay solicitudes de adopción registradas.
            </p>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-warning">
                        <tr>
                            <th>ID Solicitud</th>
                            <th>Usuario</th>
                            <th>Email Usuario</th>
                            <th>Mascota ID</th>
                            <th>Fecha Solicitud</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (Map<String, Object> s : solicitudes) { %>
                        <tr>
                            <td><%= s.get("id") %></td>
                            <td><%= s.get("nombre_usuario") %></td>
                            <td><%= s.get("email_usuario") %></td>
                            <td><%= s.get("mascota_id") %></td>
                            <td><%= s.get("fecha_solicitud") %></td>
                            <td><strong><%= (Boolean) s.get("aprobada") ? "Aprobada" : "Pendiente" %></strong></td>
                            <td>
                                <% if (!(Boolean) s.get("aprobada")) { %>
                                    <form action="procesarSolicitud" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="<%= s.get("id") %>"/>
                                        <button name="aprobar" value="true" class="btn btn-sm btn-outline-success">Aprobar</button>
                                    </form>
                                    <form action="procesarSolicitud" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="<%= s.get("id") %>"/>
                                        <button name="aprobar" value="false" class="btn btn-sm btn-outline-danger">Rechazar</button>
                                    </form>
                                <% } else { %>
                                    <span class="text-success fw-bold">✔️</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% }
    } else {
        List<Adopcion> solicitudes =
            solicitudesObj != null
                ? (List<Adopcion>) solicitudesObj
                : java.util.Collections.emptyList();

        if (solicitudes.isEmpty()) { %>
            <p class="text-center" style="color:#5B3B00;">
                No tienes solicitudes de adopción registradas.
            </p>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-warning">
                        <tr>
                            <th>ID</th>
                            <th>Mascota ID</th>
                            <th>Fecha Solicitud</th>
                            <th>Estado</th>
                            <th>Detalles</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (Adopcion a : solicitudes) { %>
                        <tr>
                            <td><%= a.getId() %></td>
                            <td><%= a.getMascotaId() %></td>
                            <td><%= a.getFechaSolicitud() %></td>
                            <td><strong><%= a.isAprobada() ? "Aprobada" : "Pendiente" %></strong></td>
                            <td>
                                <a href="detalleMascota.jsp?id=<%= a.getMascotaId() %>"
                                   class="btn btn-sm btn-outline-primary">Ver Mascota</a>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% }
    } %>
</section>

<%@ include file="footer.jsp" %>

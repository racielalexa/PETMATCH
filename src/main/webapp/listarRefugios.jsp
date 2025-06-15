<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.stream.Collectors" %>
<%@ page import="com.svalero.petmatch.dao.RefugiosDao" %>
<%@ page import="com.svalero.petmatch.database.Database" %>
<%@ page import="com.svalero.petmatch.model.Refugio" %>

<%
    // Configuración de paginación
    int currentPage = 1, pageSize = 5;
    String sp = request.getParameter("page");
    try {
      if (sp != null) currentPage = Math.max(1, Integer.parseInt(sp));
    } catch (Exception ignored) {}

    // Carga completa de refugios
    Database db = new Database();
    db.connect();
    RefugiosDao dao = new RefugiosDao(db.getConnection());
    List<Refugio> all = dao.obtenerTodos();
    db.close();

    int total = all.size();
    int pageCount = (int) Math.ceil(total / (double) pageSize);
    if (pageCount < 1) pageCount = 1;
    if (currentPage > pageCount) currentPage = pageCount;

    int start = (currentPage - 1) * pageSize;
    int end = Math.min(start + pageSize, total);
    List<Refugio> subs = all.subList(start, end);

    request.setAttribute("refugios", subs);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("pageCount", pageCount);
%>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
  <h2 class="text-center mb-4">Listado de Refugios</h2>
  <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
    <%
      List<Refugio> refugios = (List<Refugio>) request.getAttribute("refugios");
      for (Refugio r : refugios) {
    %>
      <div class="col">
        <div class="card h-100 shadow-sm">
          <div class="card-body">
            <h5 class="card-title text-primary"><%= r.getNombre() %></h5>
            <p class="card-text">
              📍 <%= r.getDireccion() %><br/>
              📧 <%= r.getEmailContacto() %><br/>
              📞 <%= r.getTelefono() %>
            </p>
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
      <li class="page-item active">
        <span class="page-link"><%= currentPage %></span>
      </li>
      <li class="page-item <%= currentPage >= pageCount ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage + 1 %>">Siguiente</a>
      </li>
    </ul>
  </nav>
</div>

<%@ include file="footer.jsp" %>

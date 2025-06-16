<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="com.svalero.petmatch.model.Mascota, com.svalero.petmatch.model.Refugio, com.svalero.petmatch.model.Usuario" %>

<%

  // Redirigir si no hay datos
  if (request.getAttribute("mascotas") == null) {
    response.sendRedirect(request.getContextPath() + "/listarmascotas");
    return;
  }

  // Cargar listas de mascotas y refugios
  List<Mascota> mascotas = (List<Mascota>) request.getAttribute("mascotas");
  if (mascotas == null) mascotas = Collections.emptyList();
  List<Refugio> refugios = (List<Refugio>) request.getAttribute("refugios");
  if (refugios == null) refugios = Collections.emptyList();

  // Filtros
  String filtroEspecie  = (String) request.getAttribute("filtroEspecie");
  String filtroAdoptado = (String) request.getAttribute("filtroAdoptado");
  String filtroRefugio  = (String) request.getAttribute("filtroRefugio");

  // Paginación
  int currentPage = request.getAttribute("currentPage") != null
       ? (Integer) request.getAttribute("currentPage") : 1;
  int pageSize    = request.getAttribute("pageSize") != null
       ? (Integer) request.getAttribute("pageSize") : mascotas.size();
  int totalItems  = request.getAttribute("totalItems") != null
       ? (Integer) request.getAttribute("totalItems") : mascotas.size();
  int totalPages  = (int) Math.ceil(totalItems / (double) pageSize);

  String cp = request.getContextPath();
%>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>  <%-- Aquí está el navbar incluido --%>

<div class="container py-4">
  <h2 class="text-center mb-4">Listado de Mascotas</h2>

  <!-- FORMULARIO DE BÚSQUEDA -->
  <form class="row g-2 mb-4" method="get" action="listarmascotas">
    <!-- Especie -->
    <div class="col-md-3">
      <select name="especie" class="form-select">
        <option value="">– Especie –</option>
        <option value="Perro"  <%= "Perro".equals(filtroEspecie) ? "selected" : "" %>>Perro</option>
        <option value="Gato"   <%= "Gato".equals(filtroEspecie)  ? "selected" : "" %>>Gato</option>
      </select>
    </div>
    <!-- Estado -->
    <div class="col-md-3">
      <select name="adoptado" class="form-select">
        <option value="">– Estado –</option>
        <option value="true"  <%= "true".equals(filtroAdoptado)  ? "selected" : "" %>>Adoptados</option>
        <option value="false" <%= "false".equals(filtroAdoptado) ? "selected" : "" %>>Disponibles</option>
      </select>
    </div>
    <!-- Refugio -->
    <div class="col-md-3">
      <select name="refugio" class="form-select">
        <option value="">– Refugio –</option>
        <% for (Refugio r : refugios) { %>
          <option value="<%= r.getId() %>"
            <%= String.valueOf(r.getId()).equals(filtroRefugio) ? "selected" : "" %>>
            <%= r.getNombre() %>
          </option>
        <% } %>
      </select>
    </div>
    <div class="col-md-3">
      <button type="submit" class="btn btn-primary w-100">Filtrar</button>
    </div>
  </form>

  <!-- Botón añadir (solo admin) -->
  <% if ("admin".equals(rol)) { %>
    <div class="text-end mb-3">
      <button class="btn btn-warning" id="btn-anadir">Añadir nueva mascota</button>
    </div>
  <% } %>

  <!-- LISTADO -->
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <% for (Mascota m : mascotas) {
         String img = (m.getImage() != null && !m.getImage().isEmpty())
             ? cp + "/img_mascotas/" + m.getImage()
             : "https://via.placeholder.com/300x200?text=Mascota+Disponible";
    %>
      <div class="col" data-id="<%= m.getId() %>">
        <div class="card h-100">
          <img src="<%= img %>" class="card-img-top" alt="<%= m.getNombre() %>">
          <div class="card-body">
            <h5><%= m.getNombre() %> — <%= m.getEspecie() %></h5>
            <p>
              Edad: <%= m.getEdad() %> años<br/>
              Peso: <%= m.getPeso() %> kg<br/>
              Estado: <strong><%= m.isAdoptado() ? "Adoptado" : "Disponible" %></strong>
            </p>
          </div>
          <div class="card-footer d-flex justify-content-between flex-wrap">
            <!-- Ver detalle -->
            <a href="<%= cp %>/verMascota?id=<%= m.getId() %>"
               class="btn btn-sm btn-info mb-1">Ver detalle</a>

            <% if ("admin".equals(rol)) { %>
              <button class="btn btn-sm btn-outline-warning editar-btn mb-1"
                      data-id="<%= m.getId() %>"
                      data-nombre="<%= m.getNombre() %>"
                      data-especie="<%= m.getEspecie() %>"
                      data-edad="<%= m.getEdad() %>"
                      data-peso="<%= m.getPeso() %>"
                      data-adoptado="<%= m.isAdoptado() %>"
                      data-refugio="<%= m.getIdRefugio() %>">
                Editar
              </button>
              <button class="btn btn-sm btn-outline-danger eliminar-btn mb-1"
                      data-id="<%= m.getId() %>">
                Eliminar
              </button>
            <% } else if ("user".equals(rol) && !m.isAdoptado()) { %>
              <a href="<%= cp %>/solicitarAdopcion?id=<%= m.getId() %>"
                 class="btn btn-sm btn-outline-success mb-1">Solicitar adopción</a>
            <% } %>
          </div>
        </div>
      </div>
    <% } %>
  </div>

  <!-- Sin resultados -->
  <% if (mascotas.isEmpty()) { %>
    <div class="alert alert-info text-center mt-4">No hay mascotas registradas.</div>
  <% } %>

  <!-- PAGINACIÓN -->
  <nav aria-label="Paginación mascotas" class="mt-4">
    <ul class="pagination justify-content-center">
      <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage - 1 %>">&laquo; Anterior</a>
      </li>
      <% for (int p = 1; p <= totalPages; p++) { %>
        <li class="page-item <%= p == currentPage ? "active" : "" %>">
          <a class="page-link" href="?page=<%= p %>"><%= p %></a>
        </li>
      <% } %>
      <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage + 1 %>">Siguiente &raquo;</a>
      </li>
    </ul>
  </nav>
</div>

<!-- Modal Añadir/Editar Mascota -->
<div class="modal fade" id="modal-mascota" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <form id="form-mascota" enctype="multipart/form-data">
        <div class="modal-header">
          <h5 class="modal-title">Mascota</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="id" id="mascota-id">
          <input name="nombre" id="mascota-nombre" class="form-control mb-2" placeholder="Nombre" required>
          <input name="especie" id="mascota-especie" class="form-control mb-2" placeholder="Especie" required>
          <input name="edad" id="mascota-edad" type="number" class="form-control mb-2" placeholder="Edad" required>
          <input name="peso" id="mascota-peso" type="number" step="0.1" class="form-control mb-2" placeholder="Peso (kg)" required>
          <div class="form-check mb-2">
            <input name="adoptado" id="mascota-adoptado" class="form-check-input" type="checkbox">
            <label class="form-check-label" for="mascota-adoptado">Adoptado</label>
          </div>
          <select name="idRefugio" id="mascota-refugio" class="form-select mb-2" required>
            <option value="">Selecciona un refugio</option>
            <% for (Refugio r : refugios) { %>
              <option value="<%= r.getId() %>" <%= String.valueOf(r.getId()).equals(filtroRefugio) ? "selected" : "" %>><%= r.getNombre() %></option>
            <% } %>
          </select>
          <input name="imagen" type="file" class="form-control mb-2">
          <div id="msg-mascota" class="mt-2"></div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Guardar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<!-- URLs AJAX -->
<script>
  const CP         = '<%= cp %>';
  const INSERT_URL = CP + '/insertarMascotaAJAX';
  const EDIT_URL   = CP + '/editarMascotaAJAX';
  const DELETE_URL = CP + '/eliminarMascotaAJAX';
</script>

<!-- AJAX CRUD -->
<script>
document.addEventListener("DOMContentLoaded", function() {
  const form = document.getElementById('form-mascota');
  const modal = new bootstrap.Modal(document.getElementById('modal-mascota'));

  // Botón Añadir
  document.getElementById('btn-anadir')?.addEventListener("click", function() {
    form.reset();
    document.getElementById('msg-mascota').innerHTML = "";
    document.getElementById('mascota-id').value = "";
    modal.show();
  });

  // Guardar (insertar o editar)
  form.addEventListener("submit", function(e) {
    e.preventDefault();
    const fd = new FormData(form);
    const url = fd.get('id') ? EDIT_URL : INSERT_URL;
    fetch(url, { method: "POST", body: fd })
      .then(function(r) { return r.json(); })
      .then(function(json) {
        const msg = document.getElementById('msg-mascota');
        if (json.success) {
          msg.innerHTML = '<div class="alert alert-success">Guardado correctamente</div>';
          setTimeout(function() { location.reload(); }, 800);
        } else {
          msg.innerHTML = `<div class="alert alert-danger">${json.message}</div>`;
        }
      })
      .catch(function() { alert("Error guardando mascota"); });
  });

  // Editar existente (precarga datos)
  document.querySelectorAll(".editar-btn").forEach(function(btn) {
    btn.addEventListener("click", function() {
      if (!confirm("¿Seguro que quieres editar esta mascota?")) return;
      document.getElementById('mascota-id').value       = btn.getAttribute('data-id');
      document.getElementById('mascota-nombre').value   = btn.getAttribute('data-nombre');
      document.getElementById('mascota-especie').value  = btn.getAttribute('data-especie');
      document.getElementById('mascota-edad').value     = btn.getAttribute('data-edad');
      document.getElementById('mascota-peso').value     = btn.getAttribute('data-peso');
      document.getElementById('mascota-adoptado').checked = btn.getAttribute('data-adoptado') === "true";
      document.getElementById('mascota-refugio').value   = btn.getAttribute('data-refugio');
      document.getElementById('msg-mascota').innerHTML  = "";
      modal.show();
    });
  });

  // Eliminar mascota
  document.querySelectorAll(".eliminar-btn").forEach(function(btn) {
    btn.addEventListener("click", function() {
      if (!confirm("¿Seguro que deseas eliminar esta mascota?")) return;

      const id = btn.getAttribute('data-id');
      if (!id) {
        alert("Error: ID de mascota no válido.");
        return;
      }

      fetch(DELETE_URL + "?id=" + encodeURIComponent(id), { method: "DELETE" })
        .then(function(r) {
          if (!r.ok) throw new Error("HTTP " + r.status);
          return r.json();
        })
        .then(function(json) {
          if (json.success) {
            btn.closest(".col").remove();
          } else {
            alert(json.message);
          }
        })
        .catch(function() {
          alert("Error eliminando mascota");
        });
    });
  });
});
</script>

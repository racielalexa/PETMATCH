<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="com.svalero.petmatch.model.Mascota, com.svalero.petmatch.model.Refugio" %>

<%
  // Si no vienen mascotas, redirigimos al servlet
  if (request.getAttribute("mascotas") == null) {
    response.sendRedirect(request.getContextPath() + "/listarmascotas");
    return;
  }
%>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<%
  List<Mascota> mascotas = (List<Mascota>) request.getAttribute("mascotas");
  if (mascotas == null) mascotas = Collections.emptyList();

  // rol viene de navbar.jsp

  int currentPage = request.getAttribute("currentPage") != null
    ? (Integer) request.getAttribute("currentPage") : 1;
  int pageSize = request.getAttribute("pageSize") != null
    ? (Integer) request.getAttribute("pageSize") : mascotas.size();
  int totalItems = request.getAttribute("totalItems") != null
    ? (Integer) request.getAttribute("totalItems") : mascotas.size();
  int totalPages = (int) Math.ceil(totalItems / (double) pageSize);

  // Lista de nombres de refugios para el <select>, pasada desde el servlet
  List<Refugio> refugios = (List<Refugio>) request.getAttribute("refugios");
  if (refugios == null) refugios = Collections.emptyList();
%>

<div class="container py-4">
  <h2 class="text-center mb-4">Listado de Mascotas</h2>

  <% if ("admin".equals(rol)) { %>
    <div class="text-end mb-3">
      <button class="btn btn-warning" id="btn-anadir">Añadir nueva mascota</button>
    </div>
  <% } %>

  <div class="row row-cols-1 row-cols-md-3 g-4">
    <% for (Mascota m : mascotas) {
         String img = (m.getImage() != null && !m.getImage().isEmpty())
             ? request.getContextPath() + "/img_mascotas/" + m.getImage()
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
          <div class="card-footer d-flex justify-content-between">
            <% if ("admin".equals(rol)) { %>
              <button class="btn btn-sm btn-outline-warning editar-btn"
                      data-id="<%= m.getId() %>"
                      data-nombre="<%= m.getNombre() %>"
                      data-especie="<%= m.getEspecie() %>"
                      data-edad="<%= m.getEdad() %>"
                      data-peso="<%= m.getPeso() %>"
                      data-adoptado="<%= m.isAdoptado() %>"
                      data-refugio="<%= m.getIdRefugio() %>">
                Editar
              </button>
              <button class="btn btn-sm btn-outline-danger eliminar-btn"
                      data-id="<%= m.getId() %>">
                Eliminar
              </button>
              <div class="card-footer d-flex justify-content-between flex-wrap">
  <!-- Ver detalle -->
  <a href="<%= request.getContextPath() %>/verMascota?id=<%= m.getId() %>"
     class="btn btn-sm btn-info mb-1">
    Ver detalle
  </a>

  <% if ("admin".equals(rol)) { %>
    <!-- tus botones editar/eliminar actuales -->
  <% } else if ("user".equals(rol) && !m.isAdoptado()) { %>
    <!-- botón solicitar adopción -->
  <% } %>
</div>
            <% } else if ("user".equals(rol) && !m.isAdoptado()) { %>
              <a href="<%= request.getContextPath() %>/solicitarAdopcion?id=<%= m.getId() %>"
                 class="btn btn-sm btn-outline-success">Solicitar adopción</a>
            <% } %>
          </div>
        </div>
      </div>
    <% } %>
  </div>

  <% if (mascotas.isEmpty()) { %>
    <div class="alert alert-info text-center mt-4">
      No hay mascotas registradas.
    </div>
  <% } %>

  <!-- Paginación -->
  <nav aria-label="Paginación mascotas" class="mt-4">
    <ul class="pagination justify-content-center">
      <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage - 1 %>">
          &laquo; Anterior
        </a>
      </li>
      <% for (int p = 1; p <= totalPages; p++) { %>
        <li class="page-item <%= p == currentPage ? "active" : "" %>">
          <a class="page-link" href="?page=<%= p %>"><%= p %></a>
        </li>
      <% } %>
      <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
        <a class="page-link" href="?page=<%= currentPage + 1 %>">
          Siguiente &raquo;
        </a>
      </li>
    </ul>
  </nav>
</div>

<!-- Modal común Añadir/Editar con SELECT de refugios -->
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

          <input name="nombre" id="mascota-nombre" class="form-control mb-2"
                 placeholder="Nombre" required>
          <input name="especie" id="mascota-especie" class="form-control mb-2"
                 placeholder="Especie" required>
          <input name="edad" id="mascota-edad" type="number"
                 class="form-control mb-2" placeholder="Edad" required>
          <input name="peso" id="mascota-peso" type="number" step="0.1"
                 class="form-control mb-2" placeholder="Peso (kg)" required>

          <div class="form-check mb-2">
            <input name="adoptado" id="mascota-adoptado"
                   class="form-check-input" type="checkbox">
            <label class="form-check-label" for="mascota-adoptado">
              Adoptado
            </label>
          </div>

          <select name="idRefugio" id="mascota-refugio"
                  class="form-select mb-2" required>
            <option value="">Selecciona un refugio</option>
            <% for (Refugio r : refugios) { %>
              <option value="<%= r.getId() %>"><%= r.getNombre() %></option>
            <% } %>
          </select>

          <input name="imagen" type="file" class="form-control">
          <div id="msg-mascota" class="mt-2"></div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Guardar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  // Creamos una constante con el context path real
  const CONTEXT_PATH = '<%= request.getContextPath() %>';

  document.addEventListener("DOMContentLoaded", () => {
    const modalEl = document.getElementById('modal-mascota');
    const modal   = new bootstrap.Modal(modalEl);
    const form    = document.getElementById('form-mascota');

    // Botón "Añadir"
    document.getElementById('btn-anadir')?.addEventListener("click", () => {
      form.reset();
      document.getElementById('mascota-id').value = "";
      modal.show();
    });

    // Botones "Editar" CON confirmación
    document.querySelectorAll(".editar-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        if (!confirm("¿Seguro que quieres editar esta mascota?")) return;
        document.getElementById('mascota-id').value      = btn.dataset.id;
        document.getElementById('mascota-nombre').value  = btn.dataset.nombre;
        document.getElementById('mascota-especie').value = btn.dataset.especie;
        document.getElementById('mascota-edad').value    = btn.dataset.edad;
        document.getElementById('mascota-peso').value    = btn.dataset.peso;
        document.getElementById('mascota-adoptado').checked =
          btn.dataset.adoptado === "true";
        document.getElementById('mascota-refugio').value = btn.dataset.refugio;
        modal.show();
      });
    });

    // Botones "Eliminar" CON confirmación
    document.querySelectorAll(".eliminar-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        if (!confirm("¿Seguro que deseas eliminar esta mascota?")) return;

        // Usamos la constante CONTEXT_PATH para construir la URL correcta
        fetch(`${CONTEXT_PATH}/eliminarMascotaAJAX?id=${btn.dataset.id}`, {
          method: "DELETE"
        })
        .then(r => {
          if (!r.ok) throw new Error("HTTP error " + r.status);
          return r.json();
        })
        .then(d => {
          if (d.success) {
            btn.closest(".col").remove();
          } else {
            alert(d.message);
          }
        })
        .catch(err => {
          console.error(err);
          alert("Error eliminando mascota");
        });
      });
    });

    // Añadir/Editar vía AJAX
    form.addEventListener("submit", e => {
      e.preventDefault();
      const fd  = new FormData(form);
      const url = fd.get('id')
        ? `${CONTEXT_PATH}/editarMascotaAJAX`
        : `${CONTEXT_PATH}/insertarMascotaAJAX`;
      fetch(url, { method: "POST", body: fd })
        .then(r => r.json())
        .then(d => {
          document.getElementById('msg-mascota').innerHTML = d.success
            ? '<div class="alert alert-success">Guardado correctamente</div>'
            : `<div class="alert alert-danger">${d.message}</div>`;
          if (d.success) setTimeout(() => location.reload(), 800);
        })
        .catch(() => alert("Error guardando mascota"));
    });
  });
</script>


<%@ include file="footer.jsp" %>

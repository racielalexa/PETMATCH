<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
  <h2 class="text-center mb-4" style="color:#FF7700;">Contribuye con PetMatch</h2>

  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-sm p-4" style="background-color:#FFF5E1; border-radius:10px;">

        <p class="text-brown mb-4">
          Tu donación ayuda a que más mascotas encuentren un hogar. ¡Gracias por colaborar!
        </p>

        <form id="donacionForm">
          <div class="mb-3">
            <label for="nombre" class="form-label">Nombre completo</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Correo electrónico</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>

          <div class="mb-3">
            <label for="monto" class="form-label">Cantidad a donar (€)</label>
            <input type="number" class="form-control" id="monto" name="monto" min="1" step="any" required>
          </div>

          <button type="submit" class="btn btn-primary w-100" style="background-color:#FF7700; border-color:#FF7700;">
            Donar
          </button>
        </form>

        <div id="graciasMensaje" class="text-center mt-4" style="display:none; font-size:1.3rem; color:#5B3B00;">
          <div class="emoji" style="font-size:3rem; animation: bounce 1s infinite;">🐶❤️</div>
          <p>¡Gracias por tu donación! 🐾</p>
          <p>Tu apoyo hace la diferencia.</p>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<style>
  .text-brown {
    color: #5B3B00;
  }
  .form-label {
    font-weight: 600;
    color: #8C6239;
  }

  @keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-15px); }
  }
</style>

<script>
  document.getElementById('donacionForm').addEventListener('submit', function(event) {
    event.preventDefault(); 

    this.style.display = 'none';
    document.getElementById('graciasMensaje').style.display = 'block';
  });
</script>

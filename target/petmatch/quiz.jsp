<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<style>
  body {
    background-color: #FFE8C3;
    color: #5B3B00;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .btn-primary {
    background-color: #FF7700;
    border-color: #FF7700;
    color: white;
  }
  .btn-primary:hover {
    background-color: #e06900;
    border-color: #e06900;
  }
</style>

<section class="container py-5">
  <h2 class="mb-4 text-center" style="color:#FF7700;">Quiz de adopción</h2>
  <p class="text-center mb-4" style="color:#5B3B00;">
    Descubre cuál es la mascota ideal para ti respondiendo a estas preguntas.
  </p>

  <form action="procesarQuiz" method="post" style="max-width: 600px; margin: 0 auto;">
    <div class="mb-3">
      <label for="estiloVida" class="form-label">¿Cuál es tu estilo de vida?</label>
      <select class="form-select" id="estiloVida" name="estiloVida" required>
        <option value="">Selecciona...</option>
        <option value="activo">Activo y deportista</option>
        <option value="tranquilo">Tranquilo y hogareño</option>
        <option value="familia">Con familia y niños</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="tiempo" class="form-label">¿Cuánto tiempo puedes dedicarle a tu mascota?</label>
      <select class="form-select" id="tiempo" name="tiempo" required>
        <option value="">Selecciona...</option>
        <option value="mucho">Muchas horas al día</option>
        <option value="poco">Pocas horas al día</option>
        <option value="finesDeSemana">Solo fines de semana</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="espacio" class="form-label">¿Con cuánto espacio cuentas en casa?</label>
      <select class="form-select" id="espacio" name="espacio" required>
        <option value="">Selecciona...</option>
        <option value="grande">Casa con jardín o patio</option>
        <option value="mediano">Apartamento mediano</option>
        <option value="pequeno">Apartamento pequeño</option>
      </select>
    </div>

    <button type="submit" class="btn btn-primary w-100">Ver resultado</button>
  </form>
</section>

<%@ include file="footer.jsp" %>

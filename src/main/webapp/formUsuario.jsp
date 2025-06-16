<form action="${pageContext.request.contextPath}/editar-usuario" method="post">
    <label>Nombre: <input type="text" name="nombre" value="${usuario.nombre}" required></label><br>
    <label>Email: <input type="email" name="email" value="${usuario.email}" required></label><br>
    <label>Contraseña: <input type="password" name="password" value="${usuario.password}" required></label><br>
    <!-- Si quieres, muestra el campo rol solo para admin -->
    <button type="submit">Actualizar datos</button>
</form>
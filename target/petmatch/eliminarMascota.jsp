
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.petmatch.dao.MascotasDao" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    MascotasDao dao = new MascotasDao();
    dao.eliminarMascota(id);
    response.sendRedirect("listarMascotas.jsp");
%>

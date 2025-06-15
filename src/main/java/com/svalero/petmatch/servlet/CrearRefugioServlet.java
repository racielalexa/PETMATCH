package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.RefugiosDao;
import com.svalero.petmatch.model.Refugio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/crear-refugio")
public class CrearRefugioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String direccion = req.getParameter("direccion");
        String telefono = req.getParameter("telefono");
        String emailContacto = req.getParameter("email_contacto");
        String web = req.getParameter("web");
        boolean activo = req.getParameter("activo") != null;

        Date fechaAlta = new Date(System.currentTimeMillis()); // fecha actual

        Refugio refugio = new Refugio(0, nombre, emailContacto, direccion, telefono, web, activo, fechaAlta);
        RefugiosDao dao = new RefugiosDao();
        dao.insertarRefugio(refugio);

        resp.sendRedirect("index.jsp");
    }
}

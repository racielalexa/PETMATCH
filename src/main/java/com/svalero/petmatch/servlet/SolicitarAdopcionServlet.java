package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.AdopcionesDao;

import com.svalero.petmatch.database.Database;

import com.svalero.petmatch.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/solicitarAdopcion")
public class SolicitarAdopcionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Usuario user = session != null ? (Usuario) session.getAttribute("usuario") : null;
        if (user == null || !"user".equals(user.getRol())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int idMascota = Integer.parseInt(req.getParameter("id"));

        try {
            Database database = new Database();
            database.connect();
            AdopcionesDao dao = new AdopcionesDao(database.getConnection());

            dao.crearSolicitud(user.getId(), idMascota);

            database.close();

            resp.sendRedirect("solicitudes");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}


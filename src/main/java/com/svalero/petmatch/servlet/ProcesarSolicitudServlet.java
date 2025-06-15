package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.AdopcionesDao;
import com.svalero.petmatch.database.Database;  // <--- Importa esto

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/procesarSolicitud")
public class ProcesarSolicitudServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean aprobado = Boolean.parseBoolean(req.getParameter("aprobar"));

        Database db = new Database(); 
        try {
            db.connect();
            AdopcionesDao dao = new AdopcionesDao(db.getConnection());
            if (aprobado) {
                dao.aprobarSolicitud(id);
            } else {
                dao.rechazarSolicitud(id);
            }
            db.close();
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error procesando la solicitud", e);
        }

        resp.sendRedirect(req.getContextPath() + "/solicitudes");
    }
}

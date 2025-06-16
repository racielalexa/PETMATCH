package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.AdopcionesDao;
import com.svalero.petmatch.database.Database;  

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/procesarSolicitud")
public class ProcesarSolicitudServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(req.getParameter("id"));
        boolean aprobar = Boolean.parseBoolean(req.getParameter("aprobar"));

        try {
            Database database = new Database();
            database.connect();
            AdopcionesDao dao = new AdopcionesDao(database.getConnection());

            boolean exito;
            if (aprobar) {
                exito = dao.aprobarSolicitud(idSolicitud);
            } else {
                exito = dao.rechazarSolicitud(idSolicitud);
            }
            database.close();

            if (exito) {
                resp.sendRedirect("solicitudes");
            } else {
                resp.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            
        }
    }
}

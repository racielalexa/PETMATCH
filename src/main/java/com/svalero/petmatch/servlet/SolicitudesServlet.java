package com.svalero.petmatch.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.svalero.petmatch.dao.AdopcionesDao;
import com.svalero.petmatch.database.Database;

import com.svalero.petmatch.model.Usuario;

@WebServlet("/solicitudes")
public class SolicitudesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            Database database = new Database();
            database.connect();

            AdopcionesDao dao = new AdopcionesDao(database.getConnection());
            List<?> lista;

            if ("admin".equals(usuario.getRol())) {
                // Refugio: obtiene todas las solicitudes con info de usuario
                lista = dao.getAllWithUsuario(); // List con info extendida
            } else {
                // Usuario normal: solo sus solicitudes
                lista = dao.getByUsuario(usuario.getId()); // List de Adopcion
            }

            req.setAttribute("solicitudes", lista);
            req.setAttribute("rol", usuario.getRol());

            database.close();

           req.getRequestDispatcher("/solicitudes.jsp").forward(req, resp);


        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/error.jsp");
        }
    }
}

package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.RefugiosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Refugio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Date;

@WebServlet("/editar-refugio")
public class EditarRefugioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Database db = new Database();
        try {
            db.connect();
            RefugiosDao dao = new RefugiosDao(db.getConnection());
            Refugio refugio = dao.obtenerPorId(id);  // Necesitarás este método en tu DAO
            req.setAttribute("refugio", refugio);
            db.close();
            req.getRequestDispatcher("/formRefugio.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Error al cargar refugio", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id             = Integer.parseInt(req.getParameter("id"));
        String nombre      = req.getParameter("nombre");
        String direccion   = req.getParameter("direccion");
        String telefono    = req.getParameter("telefono");
        String email       = req.getParameter("email_contacto");
        String web         = req.getParameter("web");
        boolean activo     = req.getParameter("activo") != null;
        Date fechaAlta     = Date.valueOf(req.getParameter("fecha_alta")); // o puedes recuperar de BD

        Refugio refugio = new Refugio(id, nombre, email, direccion, telefono, web, activo, fechaAlta);

        Database db = new Database();
        try {
            db.connect();
            RefugiosDao dao = new RefugiosDao(db.getConnection());
            dao.actualizarRefugio(refugio); // Necesitarás este método en tu DAO
            db.close();
            resp.sendRedirect(req.getContextPath() + "/listarRefugios");
        } catch (Exception e) {
            throw new ServletException("Error al editar refugio", e);
        }
    }
}

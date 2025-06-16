package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.RefugiosDao;
import com.svalero.petmatch.database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/eliminar-refugio")
public class EliminarRefugioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        Database db = new Database();
        try {
            db.connect();
            RefugiosDao dao = new RefugiosDao(db.getConnection());
            dao.eliminarRefugio(id); // Necesitarás este método en tu DAO
            db.close();
            resp.sendRedirect(req.getContextPath() + "/listarRefugios");
        } catch (Exception e) {
            throw new ServletException("Error al eliminar refugio", e);
        }
    }
}

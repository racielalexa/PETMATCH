

package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.RefugiosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Refugio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/listarRefugios")
public class ListarRefugiosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        Database db = new Database();
        try {
            db.connect();
            RefugiosDao dao = new RefugiosDao(db.getConnection());
            List<Refugio> refugios = dao.obtenerTodos();
            req.setAttribute("refugios", refugios);
            db.close();
            req.getRequestDispatcher("/listarRefugios.jsp").forward(req, resp);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error al listar refugios", e);
        }
    }
}

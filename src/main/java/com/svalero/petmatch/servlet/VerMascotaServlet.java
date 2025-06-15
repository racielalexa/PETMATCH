package com.svalero.petmatch.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.svalero.petmatch.dao.MascotasDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Mascota;

@WebServlet("/verMascota")
public class VerMascotaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Mascota m = null;
        try (Database db = new Database()) {
            db.connect();
            m = new MascotasDao(db.getConnection()).findById(id);
        } catch (Exception e) {
            throw new ServletException(e);
        }
        if (m == null) {
            resp.sendRedirect(req.getContextPath() + "/listarmascotas");
            return;
        }
        req.setAttribute("mascota", m);
        req.getRequestDispatcher("detalleMascota.jsp").forward(req, resp);
    }
}

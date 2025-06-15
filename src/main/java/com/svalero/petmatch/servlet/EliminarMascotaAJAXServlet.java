package com.svalero.petmatch.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.svalero.petmatch.dao.MascotasDao;
import com.svalero.petmatch.database.Database;

@WebServlet("/eliminarMascotaAJAX")
public class EliminarMascotaAJAXServlet extends HttpServlet {
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");

        int id = Integer.parseInt(req.getParameter("id"));
        boolean ok;
        try (Database db = new Database()) {
            db.connect();
            ok = new MascotasDao(db.getConnection()).eliminarMascota(id);
        } catch (Exception e) {
            ok = false;
        }

        resp.getWriter().write(ok
            ? "{\"success\":true}"
            : "{\"success\":false,\"message\":\"Error al eliminar\"}");
    }
}

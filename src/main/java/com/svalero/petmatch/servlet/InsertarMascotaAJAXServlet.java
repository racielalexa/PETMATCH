package com.svalero.petmatch.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.svalero.petmatch.dao.MascotasDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Mascota;

@WebServlet("/insertarMascotaAJAX")
@MultipartConfig
public class InsertarMascotaAJAXServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");

        Mascota m = new Mascota();
        m.setNombre(req.getParameter("nombre"));
        m.setEspecie(req.getParameter("especie"));
        m.setEdad(Integer.parseInt(req.getParameter("edad")));
        m.setPeso(Float.parseFloat(req.getParameter("peso")));
        m.setAdoptado(req.getParameter("adoptado") != null);
        m.setIdRefugio(Integer.parseInt(req.getParameter("idRefugio")));

        boolean ok;
        try (Database db = new Database()) {
            db.connect();
            ok = new MascotasDao(db.getConnection()).insertarMascota(m);
        } catch (Exception e) {
            ok = false;
        }

        resp.getWriter().write(ok
            ? "{\"success\":true}"
            : "{\"success\":false,\"message\":\"Error al insertar\"}");
    }
}

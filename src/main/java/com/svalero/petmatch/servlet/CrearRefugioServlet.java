
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

@WebServlet("/crear-refugio")
public class CrearRefugioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1) Leemos datos del formulario
        String nombre        = req.getParameter("nombre");
        String direccion     = req.getParameter("direccion");
        String telefono      = req.getParameter("telefono");
        String emailContacto = req.getParameter("email_contacto");
        String web           = req.getParameter("web");
        boolean activo       = req.getParameter("activo") != null;

        // fecha actual para fechaAlta
        Date fechaAlta = new Date(System.currentTimeMillis());

        // 2) Creamos el objeto modelo
        Refugio refugio = new Refugio(0, nombre, emailContacto, direccion,
                                      telefono, web, activo, fechaAlta);

        // 3) Insertamos en BD usando Database + DAO
        Database db = new Database();
        try {
            db.connect();
            RefugiosDao dao = new RefugiosDao(db.getConnection());
            dao.insertarRefugio(refugio);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error al crear refugio", e);
        } finally {
            try {
                db.close();
            } catch (SQLException ignored) { }
        }

        // 4) Redirigimos al listado de refugios (o donde prefieras)
        resp.sendRedirect(req.getContextPath() + "/listarRefugios");
    }
}

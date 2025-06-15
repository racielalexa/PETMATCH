package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.MascotasDao;
import com.svalero.petmatch.dao.RefugiosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Mascota;
import com.svalero.petmatch.model.Refugio;
import com.svalero.petmatch.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/listarmascotas")
public class ListarMascotasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1) Obtener rol
        HttpSession session = req.getSession(false);
        Usuario usuario = session != null 
            ? (Usuario) session.getAttribute("usuario") 
            : null;
        String rol = usuario != null ? usuario.getRol() : "guest";

        // 2) Leer filtros de búsqueda
        String especie      = req.getParameter("especie");
        String adoptadoParam = req.getParameter("adoptado");
        String refugioParam  = req.getParameter("refugio");

        Boolean adoptado = null;
        if ("true".equals(adoptadoParam))  adoptado = true;
        if ("false".equals(adoptadoParam)) adoptado = false;

        Integer idRefugio = null;
        if (refugioParam != null && !refugioParam.isEmpty()) {
            try {
                idRefugio = Integer.parseInt(refugioParam);
            } catch (NumberFormatException ignored) {}
        }

        // 3) Leer paginación
        int currentPage = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try { currentPage = Integer.parseInt(pageParam); }
            catch (NumberFormatException ignored) {}
        }
        int pageSize = 9;

        // 4) Conectar y obtener datos
        try (Database db = new Database()) {
            db.connect();
            MascotasDao mascotasDao = new MascotasDao(db.getConnection());
            RefugiosDao  refugiosDao = new RefugiosDao(db.getConnection());

            List<Mascota> mascotas;
            int totalItems;

            // Si hay algún filtro, usar search
            if ((especie != null && !especie.isEmpty())
             || adoptado != null
             || idRefugio != null) {

                mascotas   = mascotasDao.search(especie, adoptado, idRefugio);
                totalItems = mascotas.size();
                currentPage = 1;
                pageSize    = totalItems > 0 ? totalItems : 1;
            } else {
                // paginación normal
                mascotas   = mascotasDao.getPage(currentPage, pageSize);
                totalItems = mascotasDao.countAll();
            }

            List<Refugio> refugios = refugiosDao.obtenerTodos();

            // 5) Pasar atributos a la JSP
            req.setAttribute("mascotas", mascotas);
            req.setAttribute("refugios", refugios);
            req.setAttribute("rol", rol);

            req.setAttribute("currentPage", currentPage);
            req.setAttribute("pageSize", pageSize);
            req.setAttribute("totalItems", totalItems);

            // filtros para reponer el formulario
            req.setAttribute("filtroEspecie", especie);
            req.setAttribute("filtroAdoptado", adoptadoParam);
            req.setAttribute("filtroRefugio", refugioParam);

            req.getRequestDispatcher("/listarMascotas.jsp")
               .forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Error accediendo a la base de datos", e);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

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
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

    HttpSession session = req.getSession(false);
    Usuario usuario = session != null ? (Usuario) session.getAttribute("usuario") : null;
    String rol = usuario != null ? usuario.getRol() : "guest";

    int currentPage = 1;
    String sp = req.getParameter("page");
    if (sp != null) {
      try { currentPage = Integer.parseInt(sp); }
      catch(NumberFormatException ignored){}
    }
    int pageSize = 9;

    try {
      Database db = new Database();
      db.connect();

      MascotasDao mascotasDao = new MascotasDao(db.getConnection());
      RefugiosDao refugiosDao = new RefugiosDao(db.getConnection());
      
      List<Mascota> mascotas = mascotasDao.getPage(currentPage, pageSize);
      List<Refugio> refugios = refugiosDao.obtenerTodos();
      int totalItems = mascotasDao.countAll();

      db.close();

      req.setAttribute("mascotas", mascotas);
      req.setAttribute("refugios", refugios);
      req.setAttribute("rol", rol);
      req.setAttribute("currentPage", currentPage);
      req.setAttribute("pageSize", pageSize);
      req.setAttribute("totalItems", totalItems);

      req.getRequestDispatcher("/listarMascotas.jsp").forward(req, resp);
    } catch(Exception e) {
      e.printStackTrace();
      resp.sendRedirect("error.jsp");
    }
  }
}


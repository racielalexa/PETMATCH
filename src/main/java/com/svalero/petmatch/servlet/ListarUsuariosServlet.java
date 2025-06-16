package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.UsuariosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/listarUsuarios")
public class ListarUsuariosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String rol = request.getParameter("rol");

        Database db = new Database();
        List<Usuario> usuarios = null;

        try {
            db.connect();
            UsuariosDao usuarioDao = new UsuariosDao(db.getConnection());
            usuarios = usuarioDao.buscarUsuarios(nombre, rol);
            db.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Puedes añadir manejo de errores aquí si quieres
        }

        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("/listarUsuarios.jsp").forward(request, response);
    }
}
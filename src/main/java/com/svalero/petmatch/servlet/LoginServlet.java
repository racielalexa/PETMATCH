package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.UsuariosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Database database = new Database();
        try {
            database.connect();
            UsuariosDao usuariosDao = new UsuariosDao(database.getConnection());
            Usuario usuario = usuariosDao.autenticar(email, password);
            database.close();

          if (usuario != null && usuario.isActivo()) {
    HttpSession session = request.getSession();
    session.setAttribute("usuario", usuario);
    session.setAttribute("role", usuario.getRol());

    // Añade mensaje de bienvenida
    session.setAttribute("mensajeBienvenida", "¡Bienvenido, " + usuario.getNombre() + "!");

    response.sendRedirect("index.jsp");

            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2");
        }
    }
}


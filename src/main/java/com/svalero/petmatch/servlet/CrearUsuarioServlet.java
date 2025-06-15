package com.svalero.petmatch.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.petmatch.dao.UsuariosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Usuario;

@WebServlet("/crear-usuario")
public class CrearUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String rol = req.getParameter("rol");
        Date fechaRegistro = new Date(System.currentTimeMillis());
        boolean activo = true;

        Database database = new Database();
        try {
            database.connect();

            Usuario usuario = new Usuario(0, nombre, email, password, fechaRegistro, activo, rol);
            UsuariosDao dao = new UsuariosDao(database.getConnection());
            boolean creado = dao.insertarUsuario(usuario);

            database.close();

            if (creado) {
                resp.sendRedirect("login.jsp?registrado=1");
            } else {
                resp.sendRedirect("registro.jsp?error=1");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("registro.jsp?error=1");
        } finally {
            try {
                database.close();
            } catch (Exception ignore) { }
        }
    }
}

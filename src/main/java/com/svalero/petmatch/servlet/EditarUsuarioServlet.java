

package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.UsuariosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editar-usuario")
public class EditarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
        if (usuarioSesion == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int id = usuarioSesion.getId(); // Edita solo su usuario
        String nombre = req.getParameter("nombre");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String rol = usuarioSesion.getRol();

        Usuario usuarioEditado = new Usuario(
            id, nombre, email, password,
            usuarioSesion.getFechaRegistro(), // Conserva la fecha de registro original
            usuarioSesion.isActivo(),         // Conserva el estado activo original
            rol
        );

        Database db = new Database();
        try {
            db.connect();
            UsuariosDao dao = new UsuariosDao(db.getConnection());
            dao.actualizarUsuario(usuarioEditado);
            db.close();

            session.setAttribute("usuario", usuarioEditado); // Refresca datos en sesión
            resp.sendRedirect(req.getContextPath() + "/perfil.jsp?msg=Perfil actualizado");
        } catch (Exception e) {
            throw new ServletException("Error al editar usuario", e);
        }
    }
}

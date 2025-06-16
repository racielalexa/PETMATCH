package com.svalero.petmatch.servlet;

import com.svalero.petmatch.dao.UsuariosDao;
import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/eliminar-usuario")
public class EliminarUsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

        // Permitir que el usuario elimine su cuenta, o que el admin elimine cualquier usuario
        int idAEliminar;
        String idParam = req.getParameter("id");
        if (usuarioSesion == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if (usuarioSesion.getRol().equals("admin") && idParam != null) {
            // Admin puede borrar cualquier usuario, según parámetro
            idAEliminar = Integer.parseInt(idParam);
        } else {
            // Usuario normal solo puede borrar su propia cuenta
            idAEliminar = usuarioSesion.getId();
        }

        Database db = new Database();
        try {
            db.connect();
            UsuariosDao dao = new UsuariosDao(db.getConnection());
            dao.eliminarUsuario(idAEliminar);
            db.close();

            // Si el usuario se borra a sí mismo, cerrar sesión
            if (idAEliminar == usuarioSesion.getId()) {
                session.invalidate();
                resp.sendRedirect(req.getContextPath() + "/index.jsp?msg=Cuenta eliminada");
            } else {
                resp.sendRedirect(req.getContextPath() + "/listarUsuarios.jsp?msg=Usuario eliminado");
            }
        } catch (Exception e) {
            throw new ServletException("Error al eliminar usuario", e);
        }
    }
}

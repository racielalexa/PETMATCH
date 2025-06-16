package com.svalero.petmatch.dao;

import com.svalero.petmatch.model.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuariosDao {

    private final Connection conn;

    // Constructor con conexión inyectada
    public UsuariosDao(Connection connection) {
        this.conn = connection;
    }
    

  public boolean insertarUsuario(Usuario u) throws SQLException {
    String sql = "INSERT INTO usuarios (nombre, email, password, fecha_registro, activo, rol) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, u.getNombre());
        ps.setString(2, u.getEmail());
        ps.setString(3, u.getPassword());  // contraseña sin cifrar
        ps.setDate(4, u.getFechaRegistro());
        ps.setBoolean(5, u.isActivo());
        ps.setString(6, u.getRol());
        int rowsAffected = ps.executeUpdate();
        return rowsAffected == 1;
    }
}
public Usuario autenticar(String email, String password) {
    String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, email);
        ps.setString(2, password); // compara contraseña sin cifrar
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Usuario(
                rs.getInt("id"),
                rs.getString("nombre"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getDate("fecha_registro"),
                rs.getBoolean("activo"),
                rs.getString("rol")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
public void actualizarUsuario(Usuario usuario) throws SQLException {
    String sql = "UPDATE usuarios SET nombre=?, email=?, password=?, activo=?, rol=? WHERE id=?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
    ps.setString(1, usuario.getNombre());
    ps.setString(2, usuario.getEmail());
    ps.setString(3, usuario.getPassword());
    ps.setBoolean(4, usuario.isActivo());
    ps.setString(5, usuario.getRol());
    ps.setInt(6, usuario.getId());
    ps.executeUpdate();
    ps.close();
    }
}
public void eliminarUsuario(int id) throws SQLException {
    String sql = "DELETE FROM usuarios WHERE id=?";
     try (PreparedStatement ps = conn.prepareStatement(sql)) {
    ps.setInt(1, id);
    ps.executeUpdate();
    ps.close();
}
}
public List<Usuario> buscarUsuarios(String nombre, String rol) throws SQLException {
    List<Usuario> lista = new ArrayList<>();
    StringBuilder query = new StringBuilder("SELECT * FROM usuarios WHERE 1=1");
    if (nombre != null && !nombre.isEmpty()) {
        query.append(" AND nombre LIKE ?");
    }
    if (rol != null && !rol.isEmpty()) {
        query.append(" AND rol = ?");
    }

    try (PreparedStatement ps = conn.prepareStatement(query.toString())) {
        int paramIndex = 1;
        if (nombre != null && !nombre.isEmpty()) {
            ps.setString(paramIndex++, "%" + nombre + "%");
        }
        if (rol != null && !rol.isEmpty()) {
            ps.setString(paramIndex++, rol);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setNombre(rs.getString("nombre"));
            u.setEmail(rs.getString("email"));
            u.setRol(rs.getString("rol"));
            u.setFechaRegistro(rs.getDate("fecha_registro")); 
            u.setActivo(rs.getBoolean("activo")); 
            lista.add(u);
        }
    }
    return lista;
}
}



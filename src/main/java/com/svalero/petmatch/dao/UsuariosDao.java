package com.svalero.petmatch.dao;

import com.svalero.petmatch.model.Usuario;

import java.sql.*;

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
}

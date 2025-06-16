package com.svalero.petmatch.dao;

import com.svalero.petmatch.model.Refugio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RefugiosDao {
    private final Connection conn;

    public RefugiosDao(Connection connection) {
        this.conn = connection;
    }

    public List<Refugio> obtenerTodos() throws SQLException {
        List<Refugio> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, email_contacto, direccion, telefono, web, activo, fecha_alta FROM refugios";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Refugio(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("email_contacto"),
                    rs.getString("direccion"),
                    rs.getString("telefono"),
                    rs.getString("web"),
                    rs.getBoolean("activo"),
                    rs.getDate("fecha_alta")
                ));
            }
        }
        return lista;
    }

    public void insertarRefugio(Refugio r) throws SQLException {
        String sql = "INSERT INTO refugios (nombre, email_contacto, direccion, telefono, web, activo, fecha_alta) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getNombre());
            ps.setString(2, r.getEmailContacto());
            ps.setString(3, r.getDireccion());
            ps.setString(4, r.getTelefono());
            ps.setString(5, r.getWeb());
            ps.setBoolean(6, r.isActivo());
            ps.setDate(7, r.getFechaAlta());
            ps.executeUpdate();
        }
    }
    // Dentro de RefugiosDao.java

public Refugio obtenerPorId(int id) throws SQLException {
    String sql = "SELECT id, nombre, email_contacto, direccion, telefono, web, activo, fecha_alta FROM refugios WHERE id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new Refugio(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("email_contacto"),
                    rs.getString("direccion"),
                    rs.getString("telefono"),
                    rs.getString("web"),
                    rs.getBoolean("activo"),
                    rs.getDate("fecha_alta")
                );
            } else {
                return null;
            }
        }
    }
}

public void actualizarRefugio(Refugio r) throws SQLException {
    String sql = "UPDATE refugios SET nombre=?, email_contacto=?, direccion=?, telefono=?, web=?, activo=?, fecha_alta=? WHERE id=?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, r.getNombre());
        ps.setString(2, r.getEmailContacto());
        ps.setString(3, r.getDireccion());
        ps.setString(4, r.getTelefono());
        ps.setString(5, r.getWeb());
        ps.setBoolean(6, r.isActivo());
        ps.setDate(7, r.getFechaAlta());
        ps.setInt(8, r.getId());
        ps.executeUpdate();
    }
}

public void eliminarRefugio(int id) throws SQLException {
    String sql = "DELETE FROM refugios WHERE id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        ps.executeUpdate();
    }
}

}

package com.svalero.petmatch.dao;

import com.svalero.petmatch.model.Refugio;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RefugiosDao {

    private Connection connect() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/petmatch", "root", "");
    }

    public void insertarRefugio(Refugio r) {
        String sql = "INSERT INTO refugios (nombre, emailContacto, direccion, telefono, web, activo, fechaAlta) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = connect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getNombre());
            ps.setString(2, r.getEmailContacto());
            ps.setString(3, r.getDireccion());
            ps.setString(4, r.getTelefono());
            ps.setString(5, r.getWeb());
            ps.setBoolean(6, r.isActivo());
            ps.setDate(7, r.getFechaAlta());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Refugio> obtenerTodos() {
        List<Refugio> lista = new ArrayList<>();
        String sql = "SELECT * FROM refugios";
        try (Connection conn = connect(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(new Refugio(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("emailContacto"),
                        rs.getString("direccion"),
                        rs.getString("telefono"),
                        rs.getString("web"),
                        rs.getBoolean("activo"),
                        rs.getDate("fechaAlta")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}

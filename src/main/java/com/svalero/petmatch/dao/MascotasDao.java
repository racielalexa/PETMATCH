package com.svalero.petmatch.dao;

import com.svalero.petmatch.database.Database;
import com.svalero.petmatch.model.Mascota;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MascotasDao {

    private final Connection conn;

    public MascotasDao(Connection connection) {
        this.conn = connection;
    }

    public void insertarMascota(Mascota m) throws SQLException {
        String sql = "INSERT INTO mascotas (nombre, especie, edad, peso, fecha_ingreso, adoptado, imagen, id_refugio) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getNombre());
            ps.setString(2, m.getEspecie());
            ps.setInt(3, m.getEdad());
            ps.setFloat(4, m.getPeso());
            ps.setDate(5, m.getFechaIngreso());
            ps.setBoolean(6, m.isAdoptado());
            ps.setString(7, m.getImage());
            ps.setInt(8, m.getIdRefugio());
            ps.executeUpdate();
        }
    }

    public List<Mascota> obtenerTodas() throws SQLException {
        List<Mascota> mascotas = new ArrayList<>();
        String sql = "SELECT * FROM mascotas";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                mascotas.add(new Mascota(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("especie"),
                    rs.getInt("edad"),
                    rs.getFloat("peso"),
                    rs.getDate("fecha_ingreso"),
                    rs.getBoolean("adoptado"),
                    rs.getString("imagen"),
                    rs.getInt("refugio_id")
                ));
            }
        }
        return mascotas;
    }

    public Mascota obtenerPorId(int id) throws SQLException {
        String sql = "SELECT * FROM mascotas WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Mascota(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("especie"),
                        rs.getInt("edad"),
                        rs.getFloat("peso"),
                        rs.getDate("fecha_ingreso"),
                        rs.getBoolean("adoptado"),
                        rs.getString("imagen"),
                        rs.getInt("id_refugio")
                    );
                }
            }
        }
        return null;
    }

    public void actualizarMascota(Mascota m) throws SQLException {
        String sql = "UPDATE mascotas SET nombre=?, especie=?, edad=?, peso=?, adoptado=?, imagen=?, id_refugio=?, fecha_ingreso=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getNombre());
            ps.setString(2, m.getEspecie());
            ps.setInt(3, m.getEdad());
            ps.setFloat(4, m.getPeso());
            ps.setBoolean(5, m.isAdoptado());
            ps.setString(6, m.getImage());
            ps.setInt(7, m.getIdRefugio());
            ps.setDate(8, m.getFechaIngreso());
            ps.setInt(9, m.getId());
            ps.executeUpdate();
        }
    }

    public void eliminarMascota(int id) throws SQLException {
        String sql = "DELETE FROM mascotas WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public List<Mascota> buscarPorNombreOEspecie(String filtro, int offset, int limit) throws SQLException {
        List<Mascota> resultado = new ArrayList<>();
        String sql = "SELECT * FROM mascotas WHERE nombre LIKE ? OR especie LIKE ? LIMIT ? OFFSET ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String f = "%" + filtro + "%";
            ps.setString(1, f);
            ps.setString(2, f);
            ps.setInt(3, limit);
            ps.setInt(4, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(new Mascota(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("especie"),
                        rs.getInt("edad"),
                        rs.getFloat("peso"),
                        rs.getDate("fecha_ingreso"),
                        rs.getBoolean("adoptado"),
                        rs.getString("imagen"),
                        rs.getInt("id_refugio")
                    ));
                }
            }
        }
        return resultado;
    }

    public int getCount(String search) throws SQLException {
        String sql = "SELECT COUNT(*) FROM mascotas WHERE nombre LIKE ? OR especie LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String f = "%" + search + "%";
            ps.setString(1, f);
            ps.setString(2, f);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Mascota> getAll(int pageNumber, String search) throws SQLException {
        int pageSize = 10;
        int offset = (pageNumber - 1) * pageSize;
        return buscarPorNombreOEspecie(search, offset, pageSize);
    }
}

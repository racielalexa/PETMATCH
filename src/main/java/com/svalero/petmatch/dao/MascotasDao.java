package com.svalero.petmatch.dao;

import com.svalero.petmatch.model.Mascota;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MascotasDao {
    private final Connection conn;

    public MascotasDao(Connection connection) {
        this.conn = connection;
    }

    // Devuelve true si se insertó correctamente
    public boolean insertarMascota(Mascota m) throws SQLException {
        String sql = "INSERT INTO mascotas "
                   + "(nombre, especie, edad, peso, adoptado, imagen, refugio_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getNombre());
            ps.setString(2, m.getEspecie());
            ps.setInt(3, m.getEdad());
            ps.setFloat(4, m.getPeso());
            ps.setBoolean(5, m.isAdoptado());
            ps.setString(6, m.getImage());
            ps.setInt(7, m.getIdRefugio());
            return ps.executeUpdate() == 1;
        }
    }

    public List<Mascota> getPage(int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        List<Mascota> list = new ArrayList<>();
        String sql = "SELECT * FROM mascotas LIMIT ? OFFSET ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapear(rs));
                }
            }
        }
        return list;
    }

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM mascotas";
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    // Devuelve true si se actualizó correctamente
    public boolean actualizarMascota(Mascota m) throws SQLException {
        String sql = "UPDATE mascotas SET "
                   + "nombre=?, especie=?, edad=?, peso=?, adoptado=?, imagen=?, refugio_id=? "
                   + "WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getNombre());
            ps.setString(2, m.getEspecie());
            ps.setInt(3, m.getEdad());
            ps.setFloat(4, m.getPeso());
            ps.setBoolean(5, m.isAdoptado());
            ps.setString(6, m.getImage());
            ps.setInt(7, m.getIdRefugio());
            ps.setInt(8, m.getId());
            return ps.executeUpdate() == 1;
        }
    }

    // Sigue devolviendo boolean para que tu AJAX interprete el éxito
    public boolean eliminarMascota(int id) throws SQLException {
        String sql = "DELETE FROM mascotas WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }

    private Mascota mapear(ResultSet rs) throws SQLException {
        Mascota m = new Mascota();
        m.setId(rs.getInt("id"));
        m.setNombre(rs.getString("nombre"));
        m.setEspecie(rs.getString("especie"));
        m.setEdad(rs.getInt("edad"));
        m.setPeso(rs.getFloat("peso"));
        m.setFechaIngreso(rs.getDate("fecha_ingreso")); // si quieres mostrarla
        m.setAdoptado(rs.getBoolean("adoptado"));
        m.setImage(rs.getString("imagen"));
        m.setIdRefugio(rs.getInt("refugio_id"));
        return m;
    }

    public Mascota findById(int id) throws SQLException {
    String sql = "SELECT * FROM mascotas WHERE id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return mapear(rs);
            }
        }
    }
    return null;
}
}

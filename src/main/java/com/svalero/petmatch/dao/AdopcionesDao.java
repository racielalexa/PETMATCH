package com.svalero.petmatch.dao;

import com.svalero.petmatch.model.Adopcion;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdopcionesDao {

    private final Connection conn;

    public AdopcionesDao(Connection connection) {
        this.conn = connection;
    }

    /** Crea una solicitud de adopción */
    public boolean crearSolicitud(int usuarioId, int mascotaId) {
        String sql = "INSERT INTO adopciones (usuario_id, mascota_id, fecha_solicitud, aprobada) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ps.setInt(2, mascotaId);
            ps.setDate(3, new Date(System.currentTimeMillis()));
            ps.setBoolean(4, false); // inicialmente no aprobada
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

public List<Map<String, Object>> getAllWithUsuario() {
    List<Map<String, Object>> lista = new ArrayList<>();
    String sql = "SELECT a.*, u.nombre AS nombre_usuario, u.email AS email_usuario " +
                 "FROM adopciones a JOIN usuarios u ON a.usuario_id = u.id";
    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Map<String, Object> mapa = new HashMap<>();
            mapa.put("id", rs.getInt("id"));
            mapa.put("usuarioId", rs.getInt("usuario_id"));
            mapa.put("mascotaId", rs.getInt("mascota_id"));
            mapa.put("fechaSolicitud", rs.getDate("fecha_solicitud"));
            mapa.put("aprobada", rs.getBoolean("aprobada"));
            mapa.put("nombreUsuario", rs.getString("nombre_usuario"));
            mapa.put("emailUsuario", rs.getString("email_usuario"));
            lista.add(mapa);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}

   public boolean aprobarSolicitud(int idSolicitud) {
    String sql = "UPDATE adopciones SET aprobada = true WHERE id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, idSolicitud);
        return ps.executeUpdate() == 1;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public boolean rechazarSolicitud(int idSolicitud) {
    String sql = "DELETE FROM adopciones WHERE id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, idSolicitud);
        return ps.executeUpdate() == 1;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    /** Obtiene solicitudes de un usuario */
    public List<Adopcion> getByUsuario(int usuarioId) {
        List<Adopcion> lista = new ArrayList<>();
        String sql = "SELECT * FROM adopciones WHERE usuario_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Adopcion a = new Adopcion();
                    a.setId(rs.getInt("id"));
                    a.setUsuarioId(usuarioId);
                    a.setMascotaId(rs.getInt("mascota_id"));
                    a.setFechaSolicitud(rs.getDate("fecha_solicitud"));
                    a.setAprobada(rs.getBoolean("aprobada"));
                    lista.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}

package com.svalero.petmatch.model;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Adopcion {
    private int id;
    private int mascotaId;
    private int usuarioId;
    private boolean aprobada;
    private Date fechaSolicitud;


}

package com.svalero.petmatch.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Usuario {
    private int id;
    private String nombre;
    private String email;
    private String password;
    private Date fechaRegistro;
    private boolean activo;
    private String rol;
}

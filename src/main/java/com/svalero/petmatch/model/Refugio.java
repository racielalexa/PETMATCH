package com.svalero.petmatch.model;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;


import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Refugio {
    private int id;
    private String nombre;
    private String emailContacto;
    private String direccion;
    private String telefono;
    private String web;
    private boolean activo;
    private Date fechaAlta;

}
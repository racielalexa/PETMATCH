package com.svalero.petmatch.model;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mascota {
    private int id;
    private String nombre;
    private String especie;
    private int edad;
    private float peso;
    private Date fechaIngreso;
    private boolean adoptado;
    private String image;
    private int idRefugio;
}

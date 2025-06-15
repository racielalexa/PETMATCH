package com.svalero.petmatch.database;

import lombok.Getter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Getter
public class Database {

    private Connection connection;

    public void connect() throws ClassNotFoundException, SQLException {
        Class.forName("org.mariadb.jdbc.Driver");
        connection = DriverManager.getConnection(
                "jdbc:mariadb://localhost:3307/petmatch", "root", "root");

        System.out.println("Conectado a la base de datos correctamente.");

    }




    public void close() throws  SQLException {
        connection.close();

    }


}
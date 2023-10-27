/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package umariana.tareas;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author David Noguera Definimos los atributos que se le asignaran a cada
 * tarea
 */
public class Tareas implements Serializable {

    private int id;
    private String titulo;
    private String descripcion;
    private Date fechaV;

    public Tareas() {
    }

    public Tareas(int id, String titulo, String descripcion, Date fechaV) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fechaV = fechaV;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFechaV() {
        return fechaV;
    }

    public void setFechaV(Date fechaV) {
        this.fechaV = fechaV;
    }

}

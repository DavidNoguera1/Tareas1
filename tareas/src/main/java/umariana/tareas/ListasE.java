/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package umariana.tareas;

/**
 *
 * @author David Noguera
 */
public class ListasE {
    
    // Referencia a la cabeza de la lista para recorrer la lista con "siguiente"
    public Nodo cabeza = null;

    /**
     * Estrucuta "Nodo" contiene referencias a las tareas y 
     * una referencia al siguiente nodo de la lista
     */
    public class Nodo {

        public Tareas tarea;
        public Nodo siguiente;

        public Nodo(Tareas tarea) {
            this.tarea = tarea;
            this.siguiente = null;
        }
    }

    //Agrega una tarea al principio de la lista
    public void agregarTarea(Tareas tarea) {
        Nodo nodo = new Nodo(tarea);
        nodo.siguiente = cabeza;
        cabeza = nodo;
    }
}

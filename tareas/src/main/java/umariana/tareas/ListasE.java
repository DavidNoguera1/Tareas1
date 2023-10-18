package umariana.tareas;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletContext;

public class ListasE {

    public Nodo inicio = null;
    public Nodo fin = null;

    // Clase interna Nodo que representa un elemento de la lista
    public class Nodo {

        public Tareas tarea;
        public Nodo siguiente;

        public Nodo(Tareas tarea) {
            this.tarea = tarea;
            this.siguiente = null;
        }
    }

    public boolean verificarContenido() {
        if (inicio == null) {
            return true;
        } else {
            return false;
        }
    }

    // Método para agregar una nueva tarea al comienzo de la lista
    public void agregarTareaAlComienzo(Tareas tarea) {
        Nodo nuevoNodo = new Nodo(tarea);

        if (inicio == null) {
            // Si la lista está vacía, el nuevo nodo es tanto el inicio como el fin
            inicio = nuevoNodo;
            fin = nuevoNodo;
        } else {
            // Si no está vacía, el nuevo nodo se agrega al comienzo y se actualiza el inicio
            nuevoNodo.siguiente = inicio;
            inicio = nuevoNodo;
        }
    }

    // Método para agregar una nueva tarea al final de la lista
    public void agregarTareaAlFinal(Tareas tarea) {
        Nodo nuevoNodo = new Nodo(tarea);

        if (inicio == null) {
            // Si la lista está vacía, el nuevo nodo es tanto el inicio como el fin
            inicio = nuevoNodo;
            fin = nuevoNodo;
        } else {
            // Si no está vacía, el nuevo nodo se agrega al final y se actualiza el fin
            fin.siguiente = nuevoNodo;
            fin = nuevoNodo;
        }
    }

    // Método para guardar la lista en un archivo de texto
    public static void guardarLista(ListasE listaActualizada, ServletContext context) {
        // Ruta relativa
        String rutaRelativa = "/data/tareas.txt";

        // Ruta absoluta
        String rutaAbsoluta = context.getRealPath(rutaRelativa);

        File file = new File(rutaAbsoluta);

        try (PrintWriter writer = new PrintWriter(file)) {
            Nodo temp = listaActualizada.inicio;
            while (temp != null) {
                Tareas tarea = temp.tarea;
                // Guarda los atributos de la tarea en el archivo separados por un punto y coma
                writer.println(tarea.getId() + ";" + tarea.getTitulo() + ";" + tarea.getDescripcion() + ";" + tarea.getFechaV());
                temp = temp.siguiente;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Método para leer una lista desde un archivo de texto
    public static ListasE leerLista(ServletContext context) {
        // Ruta relativa
        String rutaRelativa = "/data/tareas.txt";

        // Ruta absoluta
        String rutaAbsoluta = context.getRealPath(rutaRelativa);

        File file = new File(rutaAbsoluta);
        ListasE lista = new ListasE();

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] atributos = line.split(";");
                if (atributos.length == 4) {
                    int id = Integer.parseInt(atributos[0]);
                    String titulo = atributos[1];
                    String descripcion = atributos[2];
                    String fechaVStr = atributos[3];

                    // Realizar el parsing de la fecha desde la cadena
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date fechaV = dateFormat.parse(fechaVStr);

                    Tareas tarea = new Tareas(id, titulo, descripcion, fechaV);
                    lista.agregarTareaAlComienzo(tarea);
                }
            }
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return lista;
    }

}

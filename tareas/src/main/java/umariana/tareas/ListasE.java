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

// Clase que manejara la lista enlazada y sus metodos

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
        return inicio == null;
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

    /**
     * Adiciona una tarea a la lista de tareas antes de la tarea con el id
     * especificado.
     *
     * @param id El id de la tarea antes de la cual se va a insertar la nueva
     * tarea.
     * @param tarea La tarea que se va a agregar.
     */
    public void agregarTareaAntesDe(int id, Tareas tarea) {
        if (inicio == null) {
            // Puedes manejar esto de alguna manera, por ejemplo, lanzar una excepción o manejar el caso especial.
            // throw new NoExisteException(id);
            return;
        } else if (id == inicio.tarea.getId()) {
            Nodo nuevoNodo = new Nodo(tarea);
            nuevoNodo.siguiente = inicio;
            inicio = nuevoNodo;
        } else {
            Nodo anterior = localizarAnteriorPorId(id);
            if (anterior == null) {
                // Puedes manejar esto de alguna manera, por ejemplo, lanzar una excepción o manejar el caso especial.
                // throw new NoExisteException(id);
                return;
            }
            Nodo nuevoNodo = new Nodo(tarea);
            nuevoNodo.siguiente = anterior.siguiente;
            anterior.siguiente = nuevoNodo;
        }
    }

    /**
     * Adiciona una tarea a la lista de tareas después de la tarea con el id
     * especificado.
     *
     * @param id El id de la tarea después de la cual se va a insertar la nueva
     * tarea.
     * @param tarea La tarea que se va a agregar.
     */
    public void agregarTareaDespuesDe(int id, Tareas tarea) {
        Nodo anterior = localizarPorId(id);

        if (anterior == null) {
            // Puedes manejar esto de alguna manera, por ejemplo, lanzar una excepción o manejar el caso especial.
            // throw new NoExisteException(id);
            return;
        } else {
            Nodo nuevoNodo = new Nodo(tarea);
            nuevoNodo.siguiente = anterior.siguiente;
            anterior.siguiente = nuevoNodo;
        }
    }

    /**
     * Busca la tarea con el id dado en la lista de tareas.
     *
     * @param id El id de la tarea que se va a buscar.
     * @return La tarea con el id especificado. Si la tarea no existe, se
     * retorna null.
     */
    public Nodo localizarPorId(int id) {
        Nodo actual = inicio;
        while (actual != null && actual.tarea.getId() != id) {
            actual = actual.siguiente;
        }
        return actual;
    }

    /**
     * Busca la tarea anterior a la tarea con el id especificado.
     *
     * @param id El id de la tarea de la cual se desea encontrar la tarea
     * anterior.
     * @return La tarea anterior a la tarea con el id dado. Se retorna null si
     * la tarea con el id dado no existe o si es la primera de la lista.
     */
    public Nodo localizarAnteriorPorId(int id) {
        Nodo anterior = null;
        Nodo actual = inicio;

        while (actual != null && actual.tarea.getId() != id) {
            anterior = actual;
            actual = actual.siguiente;
        }

        return (actual != null) ? anterior : null;
    }

    //Elimina una tarea
    public void eliminarTarea(int id) {
        if (inicio == null) {
            System.out.println("La lista de tareas está vacía, no se pudo eliminar la tarea con id: " + id);
            return;
        }

        if (id == inicio.tarea.getId()) {
            // La tarea es la primera de la lista
            inicio = inicio.siguiente;
        } else {
            // La tarea es un elemento intermedio de la lista
            Nodo anterior = localizarAnteriorPorId(id);
            if (anterior == null) {
                System.out.println("No se encontró una tarea con id: " + id + " para eliminar.");
                return;
            }
            anterior.siguiente = anterior.siguiente.siguiente; // Desconectar la tarea
        }

    }

    // Este metodo verifica la existencia de una tarea con una ID
    public boolean tareaConIdExiste(int id) {
        Nodo actual = inicio;

        while (actual != null) {
            if (actual.tarea.getId() == id) {
                return true; // La tarea con el ID proporcionado ya existe
            }
            actual = actual.siguiente;
        }

        return false; // No se encontró una tarea con el ID proporcionado

    }

    public void editarTarea(int id, String nuevoTitulo, String nuevaDescripcion, String nuevaFechaStr) {
        Nodo tareaExistente = localizarPorId(id);

        if (tareaExistente != null) {
            // Actualiza los atributos de la tarea
            tareaExistente.tarea.setTitulo(nuevoTitulo);
            tareaExistente.tarea.setDescripcion(nuevaDescripcion);

            // Convierte la cadena de fecha en un objeto Date
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date nuevaFecha = dateFormat.parse(nuevaFechaStr);
                tareaExistente.tarea.setFechaV(nuevaFecha);
            } catch (ParseException e) {
                e.printStackTrace();
            }
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

package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import umariana.tareas.ListasE;
import umariana.tareas.Tareas;

@WebServlet(name = "SvTarea", urlPatterns = {"/SvTarea"})
public class SvTarea extends HttpServlet {

    public ListasE listaTareas;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        if (tipo != null && tipo.equals("delete")) {
            String idToDelete = request.getParameter("id");
            if (idToDelete != null && !idToDelete.isEmpty()) {
                HttpSession session = request.getSession();
                ListasE listaTareas = ListasE.leerLista(getServletContext());

                if (listaTareas != null) {
                    try {
                        int id = Integer.parseInt(idToDelete);
                        listaTareas.eliminarTarea(id);
                        // Guarda la lista actualizada en el archivo
                        // Agrega un atributo para indicar la eliminación exitosa
                        session.setAttribute("tareaEliminada", true);
                        ListasE.guardarLista(listaTareas, getServletContext());
                    } catch (NumberFormatException e) {
                        // Maneja la excepción si no se proporciona un ID válido
                        e.printStackTrace();
                    }
                }
            }
        }
        // Después de eliminar una tarea con éxito en tu servlet
        response.sendRedirect("tareas.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fecha = request.getParameter("fecha");
        String posicion = request.getParameter("posicion");
        String idAntesDe = request.getParameter("idAntesDe");
        String idDespuesDe = request.getParameter("idDespuesDe");

        // Realizar el cast de la fecha
        Date fechaVencimiento = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            fechaVencimiento = dateFormat.parse(fecha);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Cargar la lista de tareas desde el archivo
        HttpSession session = request.getSession();
        ListasE listaTareas = ListasE.leerLista(getServletContext());

        if (listaTareas == null) {
            listaTareas = new ListasE();
        }

        // Verifica si ya existe una tarea con el mismo ID
        if (listaTareas.tareaConIdExiste(Integer.parseInt(id))) {
            // Tarea con el mismo ID ya existe, muestra una alerta
            request.setAttribute("tareaExistente", true);
            // Después de configurar "tareaExistente", redirige a la página tareas.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("tareas.jsp");
            
        } else {
            Tareas nuevaTarea = new Tareas(Integer.parseInt(id), titulo, descripcion, fechaVencimiento);

            // Agregar la tarea según la posición especificada
            if (posicion == null || posicion.equals("primero")) {
                listaTareas.agregarTareaAlComienzo(nuevaTarea);
            } else if (posicion.equals("ultimo")) {
                listaTareas.agregarTareaAlFinal(nuevaTarea);
            } else if (posicion.equals("antesDe")) {
                if (idAntesDe != null && !idAntesDe.isEmpty()) {
                    listaTareas.agregarTareaAntesDe(Integer.parseInt(idAntesDe), nuevaTarea);
                } else {
                    // Si no se proporciona una ID antes de la cual agregar, agregar al comienzo
                    listaTareas.agregarTareaAlComienzo(nuevaTarea);
                }
            } else if (posicion.equals("despuesDe")) {
                if (idDespuesDe != null && !idDespuesDe.isEmpty()) {
                    listaTareas.agregarTareaDespuesDe(Integer.parseInt(idDespuesDe), nuevaTarea);
                } else {
                    // Si no se proporciona una ID después de la cual agregar, agregar al final
                    listaTareas.agregarTareaAlFinal(nuevaTarea);
                }

            }
            
        }
        // Después de agregar una tarea exitosamente en tu servlet
         session.setAttribute("registroExitoso", true);

        // Guardar la tarea en el archivo
        ListasE.guardarLista(listaTareas, getServletContext());

        boolean listaVacia = listaTareas == null || listaTareas.verificarContenido();
        request.setAttribute("listaVacia", listaVacia);

        // Redirige a la página tareas.jsp con el parámetro "registroExitoso"
        response.sendRedirect("tareas.jsp?registroExitoso=true");
    }

}

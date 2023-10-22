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

    private ListasE listaTareas;

    @Override
    public void init() throws ServletException {
        // Inicializa la lista de tareas al cargar el servlet
        listaTareas = ListasE.leerLista(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        if (tipo != null && tipo.equals("delete")) {
            String idToDelete = request.getParameter("id");
            if (idToDelete != null && !idToDelete.isEmpty()) {
                HttpSession session = request.getSession();
                ListasE listaTareas = (ListasE) session.getAttribute("listaTareas");

                if (listaTareas != null) {
                    try {
                        int id = Integer.parseInt(idToDelete);
                        listaTareas.eliminarTarea(id);
                        // Guarda la lista actualizada en el archivo
                        ListasE.guardarLista(listaTareas, getServletContext());
                    } catch (NumberFormatException e) {
                        // Maneja la excepción si no se proporciona un ID válido
                        e.printStackTrace();
                    }
                }
            }
        }
        // Redirige de regreso a la página de tareas después de borrar
        response.sendRedirect("tareas.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fecha = request.getParameter("fecha");
        String posicion = request.getParameter("posicion"); // Obtén el valor del radio button
        String idAntesDe = request.getParameter("idAntesDe"); // Obtén la id antes de la cual agregar
        String idDespuesDe = request.getParameter("idDespuesDe"); // Obtén la id después de la cual agregar

        // Realizar el cast de la fecha
        Date fechaVencimiento = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            fechaVencimiento = dateFormat.parse(fecha);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Obtén la lista actualizada desde la sesión
        HttpSession session = request.getSession();
        ListasE listaTareas = (ListasE) session.getAttribute("listaTareas");

        if (listaTareas == null) {
            listaTareas = new ListasE();
            // Guárdala en la sesión
            session.setAttribute("listaTareas", listaTareas);
        }

        // Verifica si ya existe una tarea con el mismo ID
        if (listaTareas.tareaConIdExiste(Integer.parseInt(id))) {
            // Tarea con el mismo ID ya existe, muestra una alerta
            request.setAttribute("tareaExistente", true);

            // Redirige nuevamente a la página tareas.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("tareas.jsp");
            dispatcher.forward(request, response);
        } else {
            Tareas nuevaTarea = new Tareas(Integer.parseInt(id), titulo, descripcion, fechaVencimiento);

            if (null == posicion) {
                // Por defecto o si se selecciona "primero", agregar al comienzo
                listaTareas.agregarTareaAlComienzo(nuevaTarea);
            } else {
                switch (posicion) {
                    case "ultimo":
                        // Agregar la tarea al final de la lista
                        listaTareas.agregarTareaAlFinal(nuevaTarea);
                        break;
                    case "antesDe":
                        if (idAntesDe != null && !idAntesDe.isEmpty()) {
                            // Agregar la tarea antes de la tarea con la ID especificada
                            listaTareas.agregarTareaAntesDe(Integer.parseInt(idAntesDe), nuevaTarea);
                        } else {
                            // Si no se proporciona una ID antes de la cual agregar, agregar al comienzo
                            listaTareas.agregarTareaAlComienzo(nuevaTarea);
                        }
                        break;
                    case "despuesDe":
                        if (idDespuesDe != null && !idDespuesDe.isEmpty()) {
                            // Agregar la tarea después de la tarea con la ID especificada
                            listaTareas.agregarTareaDespuesDe(Integer.parseInt(idDespuesDe), nuevaTarea);
                        } else {
                            // Si no se proporciona una ID después de la cual agregar, agregar al final
                            listaTareas.agregarTareaAlFinal(nuevaTarea);
                        }
                        break;
                    default:
                        // Por defecto o si se selecciona "primero", agregar al comienzo
                        listaTareas.agregarTareaAlComienzo(nuevaTarea);
                        break;
                }
            }

            // Guarda la tarea en el archivo
            ListasE.guardarLista(listaTareas, getServletContext());

            // Después de agregar una tarea exitosamente en tu servlet
            request.setAttribute("registroExitoso", true);

            // Redirige a la página tareas.jsp con el parámetro "registroExitoso"
            response.sendRedirect("tareas.jsp?registroExitoso=true");
        }
    }
}

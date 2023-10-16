import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fecha = request.getParameter("fecha");

        // Realizar el cast de la fecha
        Date fechaVencimiento = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            fechaVencimiento = dateFormat.parse(fecha);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Tareas nuevaTarea = new Tareas(Integer.parseInt(id), titulo, descripcion, fechaVencimiento);

        // Obtén la lista actualizada desde la sesión
        HttpSession session = request.getSession();
        ListasE listaTareas = (ListasE) session.getAttribute("listaTareas");

        if (listaTareas == null) {
            listaTareas = new ListasE();
            // Guárdala en la sesión
            session.setAttribute("listaTareas", listaTareas);
        }

        listaTareas.agregarTarea(nuevaTarea);

        // Guarda la tarea en el archivo
        ListasE.guardarLista(listaTareas, getServletContext());

        // Redirige a la página tareas.jsp
        response.sendRedirect("tareas.jsp");
    }

}


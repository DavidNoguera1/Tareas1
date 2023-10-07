package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import umariana.tareas.MetodosU;
import umariana.tareas.Usuario;

/**
 *
 * @author David Noguera
 */
@WebServlet(name = "SvUsuario", urlPatterns = {"/SvUsuario"})
public class SvUsuario extends HttpServlet {

    // 
    /**
     * @Override protected void doGet(HttpServletRequest request,
     * HttpServletResponse response) throws ServletException, IOException {
     * processRequest(request, response); }
     */
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Aquí vienen los datos por doPost
        // Manda las variables pero no las muestra por motivos de seguridad
        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String contrasenia = request.getParameter("contrasenia");

        // Validar los datos si es necesario
        // Crear un nuevo objeto Usuario y establecer los valores
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setCedula(cedula);
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setContrasenia(contrasenia);

        // Obtener la lista actual de usuarios
        ArrayList<Usuario> misUsuarios = MetodosU.cargarUsuario(getServletContext());

        // Agregar el nuevo usuario a la lista de usuarios
        misUsuarios.add(nuevoUsuario);

        // Guardar la lista de usuarios en el archivo usuarios.txt
        MetodosU.guardarUsuario(misUsuarios, getServletContext());

        // Redireccionar a la página web destino
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}

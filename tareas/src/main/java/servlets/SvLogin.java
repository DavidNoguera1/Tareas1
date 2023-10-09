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
 * Este Servlet manejara el proceso de Log in
 */
@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Aquí vienen los datos por doPost
        // Manda las variables pero no las muestra por motivos de seguridad
        String cedula = request.getParameter("cedula");
        String contrasenia = request.getParameter("contrasenia");

        // Verificar las credenciales del usuario y obtener el nombre de usuario autenticado
        String nombreUsuarioAutenticado = MetodosU.loginUsuario(cedula, contrasenia, getServletContext());

        if (nombreUsuarioAutenticado != null) {
            // Las credenciales son válidas, puedes redireccionar al usuario a la página deseada
            // En este ejemplo, redireccionamos a una página llamada "perfil.jsp" y almacenamos el nombre de usuario en la sesión
            request.getSession().setAttribute("usuario", nombreUsuarioAutenticado);
            response.sendRedirect("tareas.jsp");
        } else {
            // Las credenciales no son válidas, muestra un mensaje de error
            response.setContentType("text/plain");
            response.getWriter().write("Error al iniciar sesión (Datos incorrectos o el usuario no existe). Vuelva a intentarlo.");
        }
    }
   
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

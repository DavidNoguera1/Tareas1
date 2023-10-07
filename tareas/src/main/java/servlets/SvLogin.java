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
@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Aquí vienen los datos por doPost
        // Manda las variables pero no las muestra por motivos de seguridad
        String nombreUsuario = request.getParameter("nombreUsuario");
        String contrasenia = request.getParameter("contrasenia");

        // Obtener la lista actual de usuarios
        ArrayList<Usuario> misUsuarios = MetodosU.cargarUsuario(getServletContext());

        // Verificar las credenciales del usuario
        boolean credencialesValidas = false;
        Usuario usuarioValido = null;
        for (Usuario usuario : misUsuarios) {
            if (usuario.getNombre().equals(nombreUsuario) && usuario.getContrasenia().equals(contrasenia)) {
                credencialesValidas = true;
                usuarioValido = usuario;
                break;
            }
        }

        if (credencialesValidas) {
            // Las credenciales son válidas, puedes redireccionar al usuario a la página deseada
            // En este ejemplo, redireccionamos a una página llamada "perfil.jsp" y almacenamos el usuario en la sesión
            request.getSession().setAttribute("usuario", usuarioValido);
            response.sendRedirect("tareas.jsp");
        } else {
            // Las credenciales no son válidas, puedes mostrar un mensaje de error o redirigir a una página de inicio de sesión
            response.sendRedirect("index.jsp"); // Redirecciona a una página de inicio de sesión con un parámetro de error
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
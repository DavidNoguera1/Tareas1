/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import umariana.tareas.ListasE;

/**
 *
 * @author David Noguera
 * Servlet destinado a la edicion de tareas para evitar enredos
 */
@WebServlet(name = "SvEditado", urlPatterns = {"/SvEditado"})
public class SvEditado extends HttpServlet {

    /**
     * @Override protected void doGet(HttpServletRequest request,
     * HttpServletResponse response) throws ServletException, IOException {
     * processRequest(request, response); }
     */
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtén los parámetros enviados desde el formulario de edición
        int id = Integer.parseInt(request.getParameter("id"));
        String nuevoTitulo = request.getParameter("titulo");
        String nuevaDescripcion = request.getParameter("descripcion");
        String nuevaFechaStr = request.getParameter("fecha");

        // Obtén la lista de tareas desde la sesión
        ListasE listaTareas = (ListasE) request.getSession().getAttribute("listaTareas");

        if (listaTareas != null) {
            // Realiza validaciones, por ejemplo, verifica si la tarea con el ID proporcionado existe
            if (listaTareas.localizarPorId(id) != null) {
                // Actualiza la tarea en tu lista de tareas
                listaTareas.editarTarea(id, nuevoTitulo, nuevaDescripcion, nuevaFechaStr);

                // Guarda la lista actualizada en el archivo de texto
                ListasE.guardarLista(listaTareas, getServletContext());

                // Establece el atributo de edición exitosa en la solicitud
                request.setAttribute("edicionExitosa", true);
            } else {
                
            }
        }

        // Redirige a la página de tareas (o la página que desees)
        response.sendRedirect("tareas.jsp");
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}

<%-- 
    Document   : tareas
    Created on : 7/10/2023, 1:17:52 p. m.
    Author     : David Noguera
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="umariana.tareas.ListasE"%>
<%@page import="java.util.ArrayList"%>
<%@page import="umariana.tareas.MetodosU"%>
<%@page import="umariana.tareas.Usuario"%>
<%@include file= "templates/header.jsp" %>
<%@include file= "templates/navbar.jsp" %>


<style>
        body {
            background-image: linear-gradient(#c6cca5, #8ab8a8, #54787d);
            background-size: cover; /* Asegura que la imagen de fondo cubra toda la página */
            background-attachment: fixed; /* Mantiene el fondo fijo mientras se desplaza la página */
        }
    </style>
<div class="container mt-4">
    <!-- Bienvenido y Cerrar Sesión -->
    <p class="text-end">Bienvenido <%= session.getAttribute("usuario")%> / <a href="index.jsp">Cerrar sesión</a></p>
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h3 class="card-title">Inserta tu tarea</h3>
                    <form action="SvTarea" method="POST" onsubmit="return verificarIdUnica()">
                        <%@include file="templates/alertasT.jsp" %>
                        <div class="mb-3">
                            <label for="id" class="form-label">Id:</label>
                            <input type="text" name="id" class="form-control" required pattern="\d+" />
                        </div>
                        <div class="mb-3">
                            <label for="titulo" class="form-label">Titulo:</label>
                            <input type="text" name="titulo" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label for="descripcion" class="form-label">Descripción:</label>
                            <textarea name="descripcion" class="form-control" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="fecha" class="form-label">Fecha:</label>
                            <input type="date" name="fecha" class="form-control" required />
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="primeroRadio" value="primero">
                            <label class="form-check-label" for="primeroRadio">Primero en la lista</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="ultimoRadio" value="ultimo">
                            <label class="form-check-label" for="ultimoRadio">Ultimo en la lista</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="antesDeRadio" value="antesDe">
                            <label class="form-check-label" for="antesDeRadio">Después de Tarea con ID:</label>
                            <input type="text" name="idAntesDe" id="idAntesDe" class="form-control" placeholder="ID">
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="despuesDeRadio" value="despuesDe">
                            <label class="form-check-label" for="despuesDeRadio">Antes de Tarea con ID:</label>
                            <input type="text" name="idDespuesDe" id="idDespuesDe" class="form-control" placeholder="ID">
                        </div>
                        <button type="submit" class="btn btn-primary mt-3">Agregar Tarea</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <table class="table table-bordered table-dark">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Título</th>
                        <th>Descripción</th>
                        <th>Fecha</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% ListasE listaTareas = (ListasE) session.getAttribute("listaTareas");
                    if (listaTareas != null) {
                        ListasE.Nodo current = listaTareas.inicio;
                        while (current != null) {
                    %>
                    <tr>
                        <td><%= current.tarea.getId()%></td>
                        <td><%= current.tarea.getTitulo()%></td>
                        <td><%= current.tarea.getDescripcion()%></td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(current.tarea.getFechaV())%></td>
                        <td>
                            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#tareaModal"
                               onclick="showTareaDetails(<%= current.tarea.getId()%>, '<%= current.tarea.getTitulo()%>', '<%= current.tarea.getDescripcion()%>', '<%= new SimpleDateFormat("yyyy-MM-dd").format(current.tarea.getFechaV())%>')">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editarModal"
                               data-id="<%= current.tarea.getId()%>"
                               data-titulo="<%= current.tarea.getTitulo()%>"
                               data-descripcion="<%= current.tarea.getDescripcion()%>"
                               data-fecha="<%= new SimpleDateFormat("yyyy-MM-dd").format(current.tarea.getFechaV())%>">
                                <i class="fas fa-pencil-alt"></i>
                            </a>
                            <a href="#" class="btn btn-danger" onclick="eliminarTarea(<%= current.tarea.getId()%>)">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                        current = current.siguiente;
                        }
                    } else {
                        out.println("No hay tareas disponibles.");
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@include file= "templates/funcionesYNodales.jsp" %>
<%@include file= "templates/footer.jsp" %>



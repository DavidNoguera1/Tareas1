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



<nav class=" navbar navbar-expand-lg navbar-dark bg-dark ">
    <div class="container-fluid">
        <!-- Pagina principal -->
        <a class="navbar-brand" href="index.jsp">Tareas Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Mostrar opciones para ordenar -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Mostrar opciones para ordenar -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Ordenar
                    </a>
                </li>
                <!-- Mostrar opciones para buscar -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Buscar
                    </a>
                </li>
            </ul>

            <!-- Form para buscar // Todavia no se emplea // Ignore la descripcion -->
            <form action="SvCanino" method="GET" class="d-flex" role="search">
                <input class="form-control me-2" name="perroBuscar" type="search" placeholder="Search" aria-label="Search">
                <!-- Input Hidden como bandera que manda tipo=search -->
                <input type="hidden" name="tipo" value="search">
                <button class="btn btn-outline-success" type="submit">Buscar</button>
            </form>
        </div>
    </div>
</nav>



<p> Bienvenido <%= session.getAttribute("usuario")%> / <a href="index.jsp">Cerrar cesion</a>  </p> 

<div class="container p-4"> <!-- clase contenedora -->
    <div class="row">
        <div class="col-md-4">  <!-- clase division por 4 columnas -->
            <div class="card card-body"> 
                <!-- tarjeta de trabajo -->
                <h3>Inserta tu tarea</h3>
                <form action="SvTarea" method="POST">         
                    <!-- Input para el id-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="id">Id:</label>
                        <input type="text" name ="id" class="form-control">
                    </div>                                            
                    <!-- Input para el titulo-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="titulo">Titulo:</label>
                        <input type="text" name="titulo" class="form-control">
                    </div>
                    <!-- Input para la descripcion-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="descripcion">Descripcion:</label>
                        <Textarea type="text" name="descripcion" class="form-control"  ></textarea>
                    </div>
                      <!-- Input para la fecha-->                   
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="fecha">Fecha:</label>
                        <input type="date" name="fecha" class="form-control">
                    </div>
                      <!-- Boton para agregar tarea --> 
                      <input type="submit" value="Agregar Tarea" class ="form-control"</>
                    </form><br>
                    </div>    
            </div> 
                <!-- Tabla de datos -->
            <div class="col-md-8">
    <table class="table table-bordered table-dark">
        <thead>
            <tr>
                <th>Id</th>
                <th>Titulo</th>
                <th>Descripcion</th>
                <th>Fecha</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
                    <%
                        ListasE lista = (ListasE) session.getAttribute("listaTareas");

                        if (lista != null) {
                            ListasE.Nodo current = lista.inicio;
                            while (current != null) {
                    %>
                <tr>
                    <td><%= current.tarea.getId()%></td>
                    <td><%= current.tarea.getTitulo()%></td>
                    <td><%= current.tarea.getDescripcion()%></td>
                    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(current.tarea.getFechaV())%></td>
                    <td>Acciones</td>
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

<%@include file= "templates/footer.jsp" %>
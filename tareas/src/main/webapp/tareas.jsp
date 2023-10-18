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


<p> Bienvenido <%= session.getAttribute("usuario")%> / <a href="index.jsp">Cerrar sesion</a>  </p> 

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
                      
                    <!-- Radio buttons -->
                    
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="primeroRadio" value="primero">
                            <label class="form-check-label" for="primeroRadio">
                                Primero en la lista
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="ultimoRadio" value="ultimo">
                            <label class="form-check-label" for="ultimoRadio">
                                Ultimo en la lista
                            </label>
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
                        ListasE listaTareas = (ListasE) session.getAttribute("listaTareas");

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
                                <button onclick=' if (confirm("¿Desea eliminar la tarea?")) {
                                            location.href = "SvCanino?tipo=delete&nombre="
                                        }' class="btn btn primary" 
                                ><i class="fa-solid fa-trash"></i></button>  
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

<%@include file= "templates/footer.jsp" %>


<!-- Funcion que oculta los radio button mientras la lista este vacia -->
<%
    ListasE lista = (ListasE) session.getAttribute("listaTareas");
    boolean listaVacia = (lista == null) || lista.verificarContenido();
%>
<script>
    var primeroRadio = document.getElementById("primeroRadio");
    var ultimoRadio = document.getElementById("ultimoRadio");

    var listaVacia = <%= listaVacia %>;

    if (listaVacia) {
        primeroRadio.style.display = "none";
        ultimoRadio.style.display = "none";

        var labels = document.querySelectorAll(".form-check-label");
        for (var i = 0; i < labels.length; i++) {
            labels[i].style.display = "none";
        }
    } else {
        primeroRadio.style.display = "block";
        ultimoRadio.style.display = "block";

        var labels = document.querySelectorAll(".form-check-label");
        for (var i = 0; i < labels.length; i++) {
            labels[i].style.display = "block";
        }
    }
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var form = document.querySelector("form"); // Selecciona el formulario

        form.addEventListener("submit", function (event) {
            var primeroRadio = document.getElementById("primeroRadio");
            var ultimoRadio = document.getElementById("ultimoRadio");

            if (primeroRadio.checked) {
                // Si "Primero en la lista" está seleccionado, establece el valor "primero" en el formulario
                form.action = "SvTarea?method=agregarTareaAlComienzo";
            } else if (ultimoRadio.checked) {
                // Si "Ultimo en la lista" está seleccionado, establece el valor "ultimo" en el formulario
                form.action = "SvTarea?method=agregarTareaAlFinal";
            } else {
                // Si ninguno de los dos se seleccionó, se agrega al comienzo por defecto
                form.action = "SvTarea?method=agregarTareaAlComienzo";
            }
        });
    });
</script>

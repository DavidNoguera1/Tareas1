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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<p> Bienvenido <%= session.getAttribute("usuario")%> / <a href="index.jsp">Cerrar sesion</a>  </p> 



<div class="container p-4"> <!-- clase contenedora -->
    <div class="row">
        <div class="col-md-4">  <!-- clase division por 4 columnas -->
            <div class="card card-body"> 
                <!-- tarjeta de trabajo -->
                <h3>Inserta tu tarea</h3>
                <form action="SvTarea" method="POST">       
                    <div class="alert alert-success alert-dismissible fade show" role="alert" style="display: none;" id="registroSuccessAlert">
                        ¡Registro exitoso! La tarea se añadio a la lista.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>

                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="display: none;" id="tareaExistenteAlert">
                        ¡Ya existe una tarea con el ID proporcionado!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    
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
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="antesDeRadio" value="antesDe">
                            <label class="form-check-label" for="antesDeRadio">
                                Despues de Tarea con ID:
                            </label>
                            <input type="text" name="idAntesDe" id="idAntesDe" placeholder="ID">
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="posicion" id="despuesDeRadio" value="despuesDe">
                            <label class="form-check-label" for="despuesDeRadio">
                                Antes de Tarea con ID:
                            </label>
                            <input type="text" name="idDespuesDe" id="idDespuesDe" placeholder="ID">
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
                            <a onclick="eliminarTarea(<%= current.tarea.getId()%>)" class="btn btn-danger"><i class="fas fa-trash-alt"></i> </a></td>
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


<!-- Funcion para eliminar tarea -->
<script>
    function eliminarTarea(id) {
        if (confirm("¿Desea eliminar la tarea?")) {
            location.href = "SvTarea?tipo=delete&id=" + id;
        }
    }
</script>


<!-- Funcion que oculta los radio button mientras la lista este vacia -->
<%
    ListasE lista = (ListasE) session.getAttribute("listaTareas");
    boolean listaVacia = (lista == null) || lista.verificarContenido();
%>
<script>
    var listaVacia = <%= listaVacia%>;
    var radios = document.querySelectorAll(".form-check-input");
    var labels = document.querySelectorAll(".form-check-label");
    var idAntesDeInput = document.getElementById("idAntesDe");
    var idDespuesDeInput = document.getElementById("idDespuesDe");

    if (listaVacia) {
        radios.forEach(function (radio) {
            radio.style.display = "none";
        });
        labels.forEach(function (label) {
            label.style.display = "none";
        });
        idAntesDeInput.style.display = "none";
        idDespuesDeInput.style.display = "none";
    } else {
        radios.forEach(function (radio) {
            radio.style.display = "block";
        });
        labels.forEach(function (label) {
            label.style.display = "block";
        });
        idAntesDeInput.style.display = "block";
        idDespuesDeInput.style.display = "block";
    }
</script>


<!-- Funcion para los casos de adicion a la lista -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var form = document.querySelector("form"); // Selecciona el formulario

        form.addEventListener("submit", function (event) {
            var radios = document.querySelectorAll(".form-check-input");
            var idAntesDeInput = document.getElementById("idAntesDe");
            var idDespuesDeInput = document.getElementById("idDespuesDe");

            if (radios[0].checked) {
                // Si "Primero en la lista" está seleccionado, establece el valor "primero" en el formulario
                form.action = "SvTarea?method=agregarTareaAlComienzo";
            } else if (radios[1].checked) {
                // Si "Ultimo en la lista" está seleccionado, establece el valor "ultimo" en el formulario
                form.action = "SvTarea?method=agregarTareaAlFinal";
            } else if (radios[2].checked) {
                // Si "Antes de" está seleccionado, establece el valor "antesDe" en el formulario
                form.action = "SvTarea?method=agregarTareaAntesDe&id=" + idAntesDeInput.value;
            } else if (radios[3].checked) {
                // Si "Después de" está seleccionado, establece el valor "despuesDe" en el formulario
                form.action = "SvTarea?method=agregarTareaDespuesDe&id=" + idDespuesDeInput.value;
            } else {
                // Si ninguno de los radio buttons está seleccionado, se agrega al comienzo por defecto
                form.action = "SvTarea?method=agregarTareaAlComienzo";
            }
        });
    });
</script>


<script>
    // Obtén el valor del parámetro "registroExitoso" de la URL
    var urlParams = new URLSearchParams(window.location.search);
    var registroExitoso = urlParams.get("registroExitoso");

    if (registroExitoso === "true") {
        // Muestra el mensaje de alerta
        var registroSuccessAlert = document.getElementById("registroSuccessAlert");
        if (registroSuccessAlert) {
            registroSuccessAlert.style.display = "block";
        }
    }
</script>


<script>
    // Verifica si se debe mostrar la alerta de tarea existente
    var tareaExistenteAlert = document.getElementById("tareaExistenteAlert");
    var tareaExistente = <%= request.getAttribute("tareaExistente") %>;

    if (tareaExistente) {
        tareaExistenteAlert.style.display = "block";
    }
</script>
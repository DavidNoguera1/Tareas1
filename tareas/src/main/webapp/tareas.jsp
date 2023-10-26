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
<style>
        body {
            background-image: linear-gradient(#c6cca5, #8ab8a8, #54787d);
            background-size: cover; /* Asegura que la imagen de fondo cubra toda la página */
            background-attachment: fixed; /* Mantiene el fondo fijo mientras se desplaza la página */
        }
    </style>
    
<div class="container p-4"> <!-- clase contenedora -->
    <p class="text-end">Bienvenido <%= session.getAttribute("usuario")%> / <a href="index.jsp">Cerrar sesión</a></p>
    <div class="row">
        <div class="col-md-4">  <!-- clase division por 4 columnas -->
            <div class="card card-body"> 
                <!-- tarjeta de trabajo -->
                <h3>Inserta tu tarea</h3>
                <form action="SvTarea" method="POST" onsubmit="return verificarIdUnica()">

                    <%@include file= "templates/alertasT.jsp" %>

                    <div class="input-group mb-3">
                        <label class="input-group-text" for="id">Id:</label>
                        <input type="text" name="id" class="form-control" required pattern="\d+" />
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="titulo">Titulo:</label>
                        <input type="text" name="titulo" class="form-control" required />
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="descripcion">Descripción:</label>
                        <textarea name="descripcion" class="form-control" required></textarea>
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="fecha">Fecha:</label>
                        <input type="date" name="fecha" class="form-control" required />
                    </div>

                    <!-- Radio buttons (mantenidos intactos) -->
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

                    <button type="submit" class="btn btn-primary">Agregar Tarea</button>
                </form>
                <br>
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
                    <%                        ListasE listaTareas = (ListasE) session.getAttribute("listaTareas");

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
                                <i class="fas fa-eye"></i> </a>

                            <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editarModal"
                               data-id="<%= current.tarea.getId()%>"
                               data-titulo="<%= current.tarea.getTitulo()%>"
                               data-descripcion="<%= current.tarea.getDescripcion()%>"
                               data-fecha="<%= new SimpleDateFormat("yyyy-MM-dd").format(current.tarea.getFechaV())%>">
                                <i class="fas fa-pencil-alt"></i>
                            </a>

                            <a href="#" class="btn btn-danger" onclick="eliminarTarea(<%= current.tarea.getId()%>)"><i class="fas fa-trash-alt"></i></a>

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

<!-- Ventana Modal Informacion Tareas -->
<div class="modal fade" id="tareaModal" tabindex="-1" aria-labelledby="tareaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tareaModalLabel">Detalles de la Tarea</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="tarea-details">
                    <p><strong>ID:</strong> <span id="tarea-id"></span></p>
                    <p><strong>Título:</strong> <span id="tarea-titulo"></span></p>
                    <p><strong>Descripción:</strong> <span id="tarea-descripcion"></span></p>
                    <p><strong>Fecha:</strong> <span id="tarea-fecha"></span></p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Funcion para visualizar informacion actual de la tareas -->
<script>
    function showTareaDetails(id, titulo, descripcion, fecha) {
        var modal = $('#tareaModal');
        modal.find('#tarea-id').text(id);
        modal.find('#tarea-titulo').text(titulo);
        modal.find('#tarea-descripcion').text(descripcion);
        modal.find('#tarea-fecha').text(fecha);
    }
</script>

<!-- Ventana Modal para Editar Tarea -->
<div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarModalLabel">Editar Tarea</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="SvEditado" method="POST">
                    <!-- Campo oculto para almacenar el ID de la tarea -->
                    <input type="hidden" name="id" id="editar-tarea-id" value="">
                    <!-- Input para editar el título -->
                    <div class="mb-3">
                        <label for="titulo" class="form-label">Título</label>
                        <input type="text" class="form-control" id="editar-tarea-titulo" name="titulo">
                    </div>
                    <!-- Input para editar la descripción -->
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea class="form-control" id="editar-tarea-descripcion" name="descripcion"></textarea>
                    </div>
                    <!-- Input para editar la fecha -->
                    <div class="mb-3">
                        <label for="fecha" class="form-label">Fecha</label>
                        <input type="date" class="form-control" id="editar-tarea-fecha" name="fecha">
                    </div>
                    <!-- Botón para guardar cambios -->
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Script para prellenar los campos de edición -->
<script>
    $('#editarModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Botón que desencadenó el evento
        var id = button.data('id'); // Obtén el ID de la tarea
        var titulo = button.data('titulo'); // Obtén el título de la tarea
        var descripcion = button.data('descripcion'); // Obtén la descripción de la tarea
        var fecha = button.data('fecha'); // Obtén la fecha de la tarea

        // Rellena los campos del formulario de edición con los datos de la tarea
        $('#editar-tarea-id').val(id);
        $('#editar-tarea-titulo').val(titulo);
        $('#editar-tarea-descripcion').val(descripcion);
        $('#editar-tarea-fecha').val(fecha);
    });
</script>

<!-- Funcion para confirmar eliminar tarea -->
<script>
    function eliminarTarea(id) {
        if (confirm("¿Desea eliminar la tarea?")) {
            // Si se confirma la eliminación, redirige al servlet para eliminar la tarea
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

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var form = document.querySelector("form"); // Selecciona el formulario
        var idAntesDeInput = document.getElementById("idAntesDe");
        var idDespuesDeInput = document.getElementById("idDespuesDe");

        // Función para mostrar u ocultar los campos de entrada según la selección del radio button
        function toggleInputFields() {
            if (antesDeRadio.checked) {
                idAntesDeInput.style.display = "block";
                idDespuesDeInput.style.display = "none";
            } else if (despuesDeRadio.checked) {
                idAntesDeInput.style.display = "none";
                idDespuesDeInput.style.display = "block";
            } else {
                idAntesDeInput.style.display = "none";
                idDespuesDeInput.style.display = "none";
            }
        }

        // Agregar eventos de cambio a los radio buttons
        var antesDeRadio = document.getElementById("antesDeRadio");
        var despuesDeRadio = document.getElementById("despuesDeRadio");
        antesDeRadio.addEventListener("change", toggleInputFields);
        despuesDeRadio.addEventListener("change", toggleInputFields);

        // Ejecutar la función al cargar la página para establecer el estado inicial
        toggleInputFields();
    });
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


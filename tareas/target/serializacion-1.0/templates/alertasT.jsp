<%-- 
    Document   : alertasT
    Created on : 22/10/2023, 9:15:42 a. m.
    Author     : David Noguera
--%>


<!-- Alerta exito -->
<div class="alert alert-success alert-dismissible fade show" role="alert" style="display: none;" id="registroSuccessAlert">
    ¡Registro exitoso! La tarea se añadió a la lista.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<!-- Alerta ID existente -->
<% if (request.getAttribute("tareaExistente") != null) { %>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    ¡Ya existe una tarea con el ID proporcionado!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>


<div class="alert alert-success alert-dismissible fade" role="alert" id="tareaEliminadaAlert" style="display: none;">
    Tarea eliminada satisfactoriamente.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>


<% if (session.getAttribute("tareaEditadaExitosamente") != null) { %>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    Tarea editada exitosamente.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% 
    session.removeAttribute("tareaEditadaExitosamente");
}
%>


<!-- Funcion para alerta exito-->
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

<!-- Funcion para alerta repetida-->
<script>
    function verificarIdUnica() {
        // Obtenemos el valor del campo ID
        var idInput = document.querySelector('input[name="id"]');
        var id = parseInt(idInput.value);

        // Verificar si la tarea con ID ya existe
        if (listaTareas && listaTareas.tareaConIdExiste(id)) {
            // Mostrar la alerta
            var idRepetidaAlert = document.getElementById("idRepetidaAlert");
            if (idRepetidaAlert) {
                idRepetidaAlert.style.display = "block";
            }
            return false; // Evita que se envíe el formulario
        }
        return true; // Permite enviar el formulario si la ID es única
    }
</script>


<!-- Funcion que rastrea la eliminacion de la Tarea-->
<% if (session.getAttribute("tareaEliminada") != null) { %>
<div class="alert alert-success alert-dismissible fade show" role="alert" id="tareaEliminadaAlert">
    Tarea eliminada satisfactoriamente.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% 
    session.removeAttribute("tareaEliminada");
}
%>














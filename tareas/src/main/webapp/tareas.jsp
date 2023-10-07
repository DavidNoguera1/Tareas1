<%-- 
    Document   : tareas
    Created on : 7/10/2023, 1:17:52 p. m.
    Author     : David Noguera
--%>

<%@include file= "templates/header.jsp" %>

<a class="navbar-brand" href="#">

    <header>

        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <!-- Pagina principal -->
                <a class="navbar-brand" href="index.jsp">Tareas</a>
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

                    <!-- Form por metodo GET que envia el nombre a buscar -->
                    <form action="SvCanino" method="GET" class="d-flex" role="search">
                        <input class="form-control me-2" name="perroBuscar" type="search" placeholder="Search" aria-label="Search">
                        <!-- Input Hidden como bandera que manda tipo=search -->
                        <input type="hidden" name="tipo" value="search">
                        <button class="btn btn-outline-success" type="submit">Buscar</button>
                    </form>
                </div>
            </div>
        </nav>

    </header>

</a>
</nav>

<p> Bienvenido </p> <a href="index.jsp">Cerrar cesion</a> 

<div class="container p-4"> <!-- clase contenedora -->
    <div class="row">
        <div class="col-md-4">  <!-- clase division por 4 columnas -->
            <div class="card card-body"> 
                <!-- tarjeta de trabajo -->
                <h3>Inserta tu tarea</h3>
                <form action="SvPerro" method="POST">         
                    <!-- Input para el nombre-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="id">Id:</label>
                        <input type="text" name ="id" class="form-control">
                    </div>                                            
                    <!-- Input para la raza-->
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
            
                    </tbody> 
                </table>
                </div>
               </div>  
            </div>

    <%@include file= "templates/footer.jsp" %>
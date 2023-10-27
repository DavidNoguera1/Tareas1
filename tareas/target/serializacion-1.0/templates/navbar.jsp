<%-- 
    Document   : navbar
    Created on : 18 oct 2023, 7:42:47
    Author     : PC
--%>

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
                        Decoracion
                    </a>
                </li>
                <!-- Mostrar opciones para buscar -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Decoracion
                    </a>
                </li>
            </ul>

            <!-- Form para buscar // Todavia no se emplea // Ignore la descripcion -->
            <form  class="d-flex" role="search">
                <input class="form-control me-2" name="perroBuscar" type="search" placeholder="Decoracion" aria-label="Search">
                <!-- Input Hidden como bandera que manda tipo=search -->
                <input type="hidden" name="tipo" value="search">
                <button class="btn btn-outline-success" type="submit">Buscar</button>
            </form>
        </div>
    </div>
</nav>
<%-- 
    Document   : index
    Created on : 4/10/2023, 4:55:50?p.?m.
    Author     : jcalp
--%>

<!DOCTYPE html>
<%@include file= "templates/header.jsp" %>

<section class="vh-100" style="background-color: #273B6F;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-6 col-lg-5 d-none d-md-block">
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img1.webp"
                alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
            </div>
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">

                <form>

                  <div class="d-flex align-items-center mb-3 pb-1">
                    <i class="fas fa-cubes fa-2x me-3" style="color: #273B6F;"></i>
                    <span class="h1 fw-bold mb-0">Umariana</span>
                  </div>

                  <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Iniciar Sesion :)</h5>

                  <div class="form-outline mb-4">
                    <input type="email" id="form2Example17" class="form-control form-control-lg" />
                    <label class="form-label" for="form2Example17">Nombre de Usuario</label>
                  </div>

                  <div class="form-outline mb-4">
                    <input type="password" id="form2Example27" class="form-control form-control-lg" />
                    <label class="form-label" for="form2Example27">Contraseña</label>
                  </div>

                  <div class="pt-1 mb-4">
                    <button class="btn btn-dark btn-lg btn-block" type="button">Login</button>
                  </div>

                  <!-- <a class="small text-muted" href="#!">Forgot password?</a> -->
                  <p class="mb-5 pb-lg-2" style="color: #393f81;">No está registrado? <a href="#!" style="color: #393f81;" data-bs-toggle="modal" data-bs-target="#exampleModal">Regístrate aquí</a></p>
                  <a href="#!" class="small text-muted">Terms of use.</a>
                  <a href="#!" class="small text-muted">Privacy policy</a>
                </form>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ventana Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Registrarse</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="usuario-details">
                    <form id="registroForm" action="SvUsuario" method="post">
                        <!-- Campo de cédula -->
                        <div class="form-outline mb-4">
                            <input type="text" id="cedula" name="cedula" class="form-control form-control-lg" />
                            <label class="form-label" for="cedula">Cedula</label>
                        </div>

                        <!-- Campo de nombre de usuario -->
                        <div class="form-outline mb-4">
                            <input type="text" id="nombreUsuario" name="nombre" class="form-control form-control-lg" />
                            <label class="form-label" for="nombre">Nombre de usuario</label>
                        </div>

                        <!-- Campo de contrasenia -->
                        <div class="form-outline mb-4">
                            <input type="password" id="contrasenia" name="contrasenia" class="form-control form-control-lg" />
                            <label class="form-label" for="contrasenia">Contraseña</label>
                        </div>

                        <!-- Botón de envío -->
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Registrarse</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
  $(document).ready(function() {
    // Agrega un controlador de clic al enlace "Regístrate aquí"
    $("a[href='#exampleModal']").on('click', function() {
      // Muestra el modal cuando se hace clic en el enlace
      $('#exampleModal').modal('show');
    });
  });
</script>


<%@include file= "templates/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký tài khoản - Online Cinema Ticket</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
        <link rel="stylesheet" href="../css/stylelogin.css">
    </head>
    <body>
        <!-- Register Section -->
        <section class="login-section p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4 login-card">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="text-center mb-5">
                                            <img src="https://via.placeholder.com/150x50?text=Cinema+Logo" alt="Cinema Logo" class="img-fluid mb-3">
                                            <h3>Đăng ký tài khoản</h3>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty errorform}">
                                    <div class="alert alert-danger mb-3" role="alert">
                                        ${errorform}
                                    </div>
                                </c:if>
                                <form action="<c:url value='/RegisterController'/>" method="POST">
                                    <div class="row gy-3">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required value="<c:out value='${param.email}' default=''/>">
                                                <label for="email" class="form-label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="password" id="password" placeholder="Mật khẩu" required>
                                                <label for="password" class="form-label">Mật khẩu</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="re_password" id="re_password" placeholder="Nhập lại mật khẩu" required>
                                                <label for="re_password" class="form-label">Nhập lại mật khẩu</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="full_name" id="full_name" placeholder="Họ và tên" required value="<c:out value='${param.full_name}' default=''/>">
                                                <label for="full_name" class="form-label">Họ và tên</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="tel" class="form-control" name="phone_number" id="phone_number" placeholder="Số điện thoại" required value="<c:out value='${param.phone_number}' default=''/>">
                                                <label for="phone_number" class="form-label">Số điện thoại</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid mt-4" style="min-height: 60px;">
                                                <button class="btn btn-primary-custom btn-lg" type="submit">Đăng ký ngay</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-12">
                                        <hr class="mt-5 mb-4 border-secondary-subtle">
                                        <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-between">
                                            <a href="<c:url value='/loginController'/>" class="link-secondary text-decoration-none">Đã có tài khoản? Đăng nhập</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var submitButton = document.querySelector('.btn-primary-custom');
            if (submitButton) {
                // Ensure Bootstrap classes are present
                submitButton.classList.add('btn', 'btn-lg');
                // Ensure custom class is present
                submitButton.classList.add('btn-primary-custom');
                // Re-apply any necessary inline styles if they were removed
                submitButton.style.backgroundColor = '#e94560';
                submitButton.style.borderColor = '#e94560';
                submitButton.style.color = 'white';
            }
        });
    </script>
</body>
</html>

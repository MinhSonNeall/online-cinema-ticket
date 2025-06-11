<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập - Online Cinema Ticket</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylelogin.css">
    </head>
    <body>
        <!-- Login Section -->
        <section class="login-section p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4 login-card">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="text-center mb-5"> <!-- Centered heading -->
                                            <!-- Placeholder for a cinema logo or title image -->
<a href="${pageContext.request.contextPath}/jsp/index.jsp">
    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Cinema Logo" class="img-fluid mb-3">
</a>
                                            <h3>Đăng nhập</h3>
                                        </div>
                                    </div>
                                </div>
                                <!-- Hiển thị lỗi nếu có -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        ${error}
                                    </div>
                                </c:if>
                                <!-- Hiển thị thông báo thành công nếu có -->
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" role="alert">
                                        ${successMessage}
                                    </div>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/loginController" method="POST">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
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
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" name="remember_me" id="remember_me">
                                                <label class="form-check-label text-secondary" for="remember_me">
                                                    Ghi nhớ đăng nhập
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid mt-4"> <!-- Added margin top -->
                                                <button class="btn btn-primary-custom btn-lg" type="submit">Đăng nhập ngay</button> <!-- Used custom class and btn-lg -->
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-12">
                                        <hr class="mt-5 mb-4 border-secondary-subtle">
                                        <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-between"> <!-- Changed to justify-content-md-between -->
                                            <a href="<c:url value='/jsp/registerCustomer.jsp'/>" class="link-secondary text-decoration-none">Tạo tài khoản mới</a>
                                            <a href="<c:url value='/forgotPassword'/>" class="link-secondary text-decoration-none">Quên mật khẩu</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 social-login-divider">
                                        <p class="text-center mt-5 mb-4">Hoặc đăng nhập bằng</p> <!-- Centered text -->
                                        <div class="d-flex gap-3 flex-column">
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/OnlineCinemaTicket/loginGoogle&response_type=code&client_id=266099726397-t6uec8o1gni790qbt50cip54ur00dq1o.apps.googleusercontent.com&approval_prompt=force" class="btn btn-social btn-google">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                                                <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                                </svg>
                                                <span class="ms-2 fs-6 text-uppercase">Đăng nhập bằng Google</span>
                                            </a>
                                            <a href="" class="btn btn-social btn-facebook"> <!-- Placeholder link -->
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
                                                <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
                                                </svg>
                                                <span class="ms-2 fs-6 text-uppercase">Đăng nhập bằng Facebook</span>
                                            </a>
                                            <a href="#!" class="btn btn-social btn-twitter"> <!-- Placeholder link -->
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16">
                                                <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z" />
                                                </svg>
                                                <span class="ms-2 fs-6 text-uppercase">Đăng nhập bằng Twitter</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>

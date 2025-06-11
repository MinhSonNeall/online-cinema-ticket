<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Verify OTP & Reset Password - Online Cinema Ticket</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylelogin.css">
    </head>
    <body>
        <!-- Verify OTP & Reset Password Section -->
        <section class="login-section p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4 login-card">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="text-center mb-5">
<a href="${pageContext.request.contextPath}/jsp/index.jsp">
    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Cinema Logo" class="img-fluid mb-3">
</a>
                                            <h3>Verify OTP & Reset Password</h3>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty errorform}">
                                    <div class="alert alert-danger" role="alert">
                                        ${errorform}
                                    </div>
                                </c:if>
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" role="alert">
                                        ${successMessage}
                                    </div>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/forgotPasswordOTPVerify" method="post">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="otp" id="otp" placeholder="Enter OTP" required>
                                                <label for="otp" class="form-label">Enter OTP</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="newPassword" id="newPassword" placeholder="Enter new password (min 12 chars)" required>
                                                <label for="newPassword" class="form-label">New Password (min 12 chars)</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Confirm new password" required>
                                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid mt-4">
                                                <button class="btn btn-primary-custom btn-lg" type="submit">Reset Password</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-12">
                                        <hr class="mt-5 mb-4 border-secondary-subtle">
                                        <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-between">
                                            <a href="<c:url value='/login'/>" class="link-secondary text-decoration-none">Back to Login</a>
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

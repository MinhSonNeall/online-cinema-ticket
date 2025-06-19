<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác nhận OTP - Online Cinema Ticket</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
        <link rel="stylesheet" href="../css/stylelogin.css">
    </head>
    <body>
        <!-- OTP Verification Section -->
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
                                            <h3>Xác nhận OTP</h3>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty er}">
                                    <div class="alert alert-danger" role="alert">
                                        ${er}
                                    </div>
                                </c:if>
                                <form action="verifyEmailOTP" method="post">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="otp" id="otp" placeholder="Nhập mã OTP của bạn" required>
                                                <label for="otp" class="form-label">Mã OTP</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid mt-4">
                                                <button class="btn btn-primary-custom btn-lg" type="submit">Xác nhận</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-12">
                                        <hr class="mt-5 mb-4 border-secondary-subtle">
                                        <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-between">
                                            <a href="<c:url value='/jsp/login.jsp'/>" class="link-secondary text-decoration-none">Quay lại đăng nhập</a>
                                            <a href="<c:url value='/jsp/registerCustomer.jsp'/>" class="link-secondary text-decoration-none">Đăng ký lại</a>
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

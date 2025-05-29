<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Online Cinema Ticket</title>
    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .register-section {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }
        .register-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 28rem;
            padding: 2.5rem;
        }
        .register-card h2 {
            color: #1a1a2e;
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .form-input-custom {
            border-radius: 8px !important;
            border: 1px solid #D1D5DB !important;
            padding: 0.75rem 1rem !important;
            box-shadow: none !important;
        }
        .form-input-custom:focus {
            border-color: #e94560 !important;
            box-shadow: 0 0 0 0.2rem rgba(233, 69, 96, 0.25) !important;
            outline: none !important;
        }
        .btn-primary-custom {
            background-color: #e94560 !important;
            border-color: #e94560 !important;
            color: white !important;
            font-weight: 500 !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 8px !important;
            transition: background-color 0.3s ease, border-color 0.3s ease;
            width: 100%;
        }
        .btn-primary-custom:hover,
        .btn-primary-custom:focus {
            background-color: #c73049 !important;
            border-color: #c73049 !important;
            box-shadow: 0 4px 15px rgba(233, 69, 96, 0.3) !important;
        }
        .link-custom {
            color: #5a5a5a !important;
            transition: color 0.3s ease;
        }
        .link-custom:hover {
            color: #e94560 !important;
            text-decoration: underline;
        }
        .error-message {
            color: #EF4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .general-error-message {
            background-color: #FEE2E2;
            color: #B91C1C;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: 1px solid #FCA5A5;
            margin-bottom: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="register-section">
        <div class="register-card">
            <h2 class="text-2xl">Đăng ký tài khoản</h2>
            <!-- Hiển thị thông báo lỗi chung nếu có -->
            <c:if test="${not empty errorform}">
                <p class="general-error-message">${errorform}</p>
            </c:if>
            <form action="<c:url value='/RegisterController'/>" method="POST" class="space-y-6">
                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email <span class="text-red-500">*</span></label>
                    <input type="email" id="email" name="email" required
                           value="<c:out value='${param.email}' default=''/>"
                           class="mt-1 block w-full form-input-custom"
                           placeholder="nhap@email.com">
                </div>
                <!-- Password -->
                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Mật khẩu <span class="text-red-500">*</span></label>
                    <input type="password" id="password" name="password" required
                           class="mt-1 block w-full form-input-custom"
                           placeholder="Nhập mật khẩu">
                </div>
                <!-- Re-Password -->
                <div>
                    <label for="re_password" class="block text-sm font-medium text-gray-700">Nhập lại mật khẩu <span class="text-red-500">*</span></label>
                    <input type="password" id="re_password" name="re_password" required
                           class="mt-1 block w-full form-input-custom"
                           placeholder="Nhập lại mật khẩu">
                </div>
                <!-- Full Name -->
                <div>
                    <label for="full_name" class="block text-sm font-medium text-gray-700">Họ và tên <span class="text-red-500">*</span></label>
                    <input type="text" id="full_name" name="full_name" required
                           value="<c:out value='${param.full_name}' default=''/>"
                           class="mt-1 block w-full form-input-custom"
                           placeholder="Nhập họ và tên">
                </div>
                <!-- Phone Number -->
                <div>
                    <label for="phone_number" class="block text-sm font-medium text-gray-700">Số điện thoại <span class="text-red-500">*</span></label>
                    <input type="tel" id="phone_number" name="phone_number" required
                           value="<c:out value='${param.phone_number}' default=''/>"
                           class="mt-1 block w-full form-input-custom"
                           placeholder="Nhập số điện thoại">
                </div>
                <!-- Submit Button -->
                <div>
                    <button type="submit" class="btn-primary-custom">
                        Đăng ký
                    </button>
                </div>
            </form>
            <!-- Link to Login -->
            <p class="mt-6 text-center text-sm text-gray-600">
                Đã có tài khoản? <a href="<c:url value='/LoginController'/>" class="link-custom">Đăng nhập</a>
            </p>
        </div>
    </div>
</body>
</html>
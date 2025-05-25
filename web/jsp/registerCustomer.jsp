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
                /* Tailwind handles background, but we'll override for the gradient section */
            }

            .register-section {
                background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); /* Dark cinematic gradient */
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1rem; /* Add some padding for smaller screens */
            }

            .register-card {
                background-color: rgba(255, 255, 255, 0.95); /* Slightly transparent white card */
                border-radius: 15px; /* More rounded corners */
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2); /* Softer, more pronounced shadow */
                width: 100%;
                max-width: 28rem; /* max-w-md equivalent */
                padding: 2.5rem; /* More padding */
            }

            .register-card h2 {
                color: #1a1a2e; /* Dark blue heading */
                font-weight: 600; /* Tailwind's font-bold is 700, Poppins 600 is good */
                margin-bottom: 1.5rem; /* Increased margin */
                text-align: center;
            }

            /* Custom styles for form inputs to match login page */
            .form-input-custom {
                border-radius: 8px !important; /* Rounded input fields */
                border: 1px solid #D1D5DB !important; /* Tailwind gray-300 */
                padding: 0.75rem 1rem !important; /* Adjust padding */
                box-shadow: none !important; /* Remove Tailwind's default shadow if any */
            }

            .form-input-custom:focus {
                border-color: #e94560 !important; /* Cinema red accent for focus */
                box-shadow: 0 0 0 0.2rem rgba(233, 69, 96, 0.25) !important;
                outline: none !important;
            }

            .btn-primary-custom {
                background-color: #e94560 !important; /* Cinema red */
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
                background-color: #c73049 !important; /* Darker cinema red on hover */
                border-color: #c73049 !important;
                box-shadow: 0 4px 15px rgba(233, 69, 96, 0.3) !important;
            }

            .link-custom {
                color: #5a5a5a !important; /* Darker grey for links */
                transition: color 0.3s ease;
            }

            .link-custom:hover {
                color: #e94560 !important; /* Cinema red on hover */
                text-decoration: underline;
            }

            .error-message {
                color: #EF4444; /* Tailwind red-500 */
                font-size: 0.875rem;
                margin-top: 0.25rem; /* Add a little space below the input */
            }

            /* General error message at the top */
            .general-error-message {
                background-color: #FEE2E2; /* Tailwind red-100 */
                color: #B91C1C; /* Tailwind red-700 */
                padding: 0.75rem 1rem;
                border-radius: 8px;
                border: 1px solid #FCA5A5; /* Tailwind red-300 */
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
                <c:if test="${not empty error}">
                    <p class="general-error-message">${error}</p>
                </c:if>

                <form action="RegisterServlet" method="POST" class="space-y-6"> <!-- Increased space-y -->
                    <!-- Email -->
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700">Email <span class="text-red-500">*</span></label>
                        <input type="email" id="email" name="email" required
                               value="<c:out value='${param.email}'/>"
                               class="mt-1 block w-full form-input-custom"
                               placeholder="nhap@email.com">
                        <c:if test="${not empty emailError}">
                            <p class="error-message">${emailError}</p>
                        </c:if>
                    </div>

                    <!-- Password -->
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700">Mật khẩu <span class="text-red-500">*</span></label>
                        <input type="password" id="password" name="password" required
                               class="mt-1 block w-full form-input-custom"
                               placeholder="Nhập mật khẩu">
                        <c:if test="${not empty passwordError}">
                            <p class="error-message">${passwordError}</p>
                        </c:if>
                    </div>

                    <!-- Full Name -->
                    <div>
                        <label for="full_name" class="block text-sm font-medium text-gray-700">Họ và tên <span class="text-red-500">*</span></label>
                        <input type="text" id="full_name" name="full_name" required
                               value="<c:out value='${param.full_name}'/>"
                               class="mt-1 block w-full form-input-custom"
                               placeholder="Nhập họ và tên">
                        <c:if test="${not empty fullNameError}">
                            <p class="error-message">${fullNameError}</p>
                        </c:if>
                    </div>

                    <!-- Phone Number -->
                    <div>
                        <label for="phone_number" class="block text-sm font-medium text-gray-700">Số điện thoại</label>
                        <input type="tel" id="phone_number" name="phone_number"
                               value="<c:out value='${param.phone_number}'/>"
                               class="mt-1 block w-full form-input-custom"
                               placeholder="Nhập số điện thoại">
                        <c:if test="${not empty phoneError}">
                            <p class="error-message">${phoneError}</p>
                        </c:if>
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
                    Đã có tài khoản? <a href="<c:url value='/jsp/login.jsp'/>" class="link-custom">Đăng nhập</a>
                </p>
            </div>
        </div>
    </body>
</html>

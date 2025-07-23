<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lại mật khẩu - Cinema Booking</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                color: #333;
                background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
                min-height: 100vh;
            }
            /* Logo Styles */
            .logo {
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1000;
                text-decoration: none;
                font-size: 1.8rem;
                font-weight: bold;
                background: linear-gradient(45deg, #ff6b6b, #feca57, #48dbfb);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                background-size: 200% 200%;
                animation: logoGradient 3s ease-in-out infinite;
                transition: all 0.3s ease;
                padding: 0.5rem 1rem;
                border-radius: 12px;
                backdrop-filter: blur(10px);
                background-color: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
            }
            .logo:hover {
                transform: scale(1.05);
                box-shadow: 0 5px 20px rgba(255, 107, 107, 0.3);
                background-color: rgba(255, 255, 255, 0.1);
            }
            @keyframes logoGradient {
                0%, 100% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
            }
            /* Main Content */
            .main-content {
                margin-top: 0;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }
            /* Login Container */
            .login-container {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 16px;
                padding: 3rem;
                width: 100%;
                max-width: 450px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
                animation: fadeInUp 0.6s ease forwards;
                position: relative;
            }
            .login-header {
                text-align: center;
                margin-bottom: 2rem;
            }
            .login-title {
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                background: linear-gradient(45deg, #ff6b6b, #feca57, #48dbfb);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                background-size: 200% 200%;
                animation: gradient 3s ease-in-out infinite;
            }
            @keyframes gradient {
                0%, 100% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
            }
            .login-subtitle {
                color: #aaa;
                font-size: 1rem;
            }
            /* Form Styles */
            .login-form {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }
            .form-group {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }
            .form-label {
                color: #fff;
                font-weight: 500;
                font-size: 0.9rem;
            }
            .form-input {
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 8px;
                padding: 0.75rem 1rem;
                color: #fff;
                font-size: 1rem;
                transition: all 0.3s ease;
                font-weight: 500;
            }
            .form-input:focus {
                outline: none;
                border-color: #ff6b6b;
                background: rgba(255, 255, 255, 0.15);
                box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
            }
            .form-input::placeholder {
                color: #aaa;
                font-weight: normal;
            }
            /* Login Button */
            .login-btn {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: #fff;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: bold;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }
            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
            }
            .login-btn:active {
                transform: translateY(0);
            }
            /* Additional Links */
            .login-links {
                text-align: center;
                margin-top: 2rem;
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }
            .login-link {
                color: #aaa;
                text-decoration: none;
                font-size: 0.9rem;
                transition: color 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }
            .login-link:hover {
                color: #ff6b6b;
            }
            .register-link {
                color: #feca57;
                font-weight: 500;
            }
            .register-link:hover {
                color: #ff6b6b;
            }
            /* Divider */
            .divider {
                display: flex;
                align-items: center;
                margin: 1.5rem 0;
                color: #aaa;
                font-size: 0.9rem;
            }
            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: rgba(255, 255, 255, 0.2);
            }
            .divider span {
                padding: 0 1rem;
            }
            /* Error Message */
            .error-message {
                background: rgba(255, 107, 107, 0.1);
                border: 1px solid rgba(255, 107, 107, 0.3);
                color: #ff6b6b;
                padding: 0.75rem;
                border-radius: 8px;
                font-size: 0.9rem;
                margin-bottom: 1rem;
                text-align: center;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }
            /* Success Message */
            .success-message {
                background: rgba(72, 219, 251, 0.1);
                border: 1px solid rgba(72, 219, 251, 0.3);
                color: #48dbfb;
                padding: 0.75rem;
                border-radius: 8px;
                font-size: 0.9rem;
                margin-bottom: 1rem;
                text-align: center;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }
            /* Responsive */
            @media (max-width: 768px) {
                .logo {
                    top: 15px;
                    left: 15px;
                    font-size: 1.5rem;
                    padding: 0.4rem 0.8rem;
                }
                .main-content {
                    padding: 1rem;
                }
                .login-container {
                    padding: 2rem;
                    margin-top: 80px;
                }
                .login-title {
                    font-size: 2rem;
                }
            }
            @media (max-width: 480px) {
                .logo {
                    position: relative;
                    top: 0;
                    left: 0;
                    display: block;
                    text-align: center;
                    margin: 20px auto;
                    width: fit-content;
                }
                .main-content {
                    padding: 0.5rem;
                }
                .login-container {
                    margin-top: 0;
                }
            }
            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            /* Background decoration */
            .login-container::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(45deg, #ff6b6b, #feca57, #48dbfb);
                border-radius: 18px;
                z-index: -1;
                opacity: 0.1;
                animation: borderGlow 3s ease-in-out infinite;
            }
            @keyframes borderGlow {
                0%, 100% { opacity: 0.1; }
                50% { opacity: 0.2; }
            }
        </style>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="logo">🎬 CinePlex</a>
        
        <div class="main-content">
            <div class="login-container">
                <div class="login-header">
                    <h1 class="login-title">Đặt lại mật khẩu</h1>
                    <p class="login-subtitle">Nhập mã OTP và mật khẩu mới của bạn</p>
                                        </div>
                
                                <c:if test="${not empty errorform}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                                        ${errorform}
                                    </div>
                                </c:if>
                
                                <c:if test="${not empty successMessage}">
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                                        ${successMessage}
                                    </div>
                                </c:if>
                
                <form action="${pageContext.request.contextPath}/forgotPasswordOTPVerify" method="post" class="login-form">
                    <div class="form-group">
                        <label for="otp" class="form-label">Mã OTP</label>
                        <input type="text" id="otp" name="otp" class="form-input" placeholder="Nhập mã OTP" required maxlength="6" pattern="[0-9]{6}">
                                            </div>
                    
                    <div class="form-group">
                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                        <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="Nhập mật khẩu mới (tối thiểu 12 ký tự)" required minlength="12">
                                        </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="Xác nhận mật khẩu mới" required>
                                            </div>
                    
                    <button type="submit" class="login-btn">
                        <i class="fas fa-key"></i>
                        Đặt lại mật khẩu
                    </button>
                                </form>
                
                <div class="divider">
                    <span>Trợ giúp</span>
                                        </div>
                
                <div class="login-links">
                    <div style="display: flex; flex-direction: column; align-items: center; margin-bottom: 10px;">
                        <a href="${pageContext.request.contextPath}/forgotPassword" class="login-link register-link">
                            <i class="fas fa-redo"></i>
                            Gửi lại mã OTP
                        </a>
                    </div>
                    <a href="${pageContext.request.contextPath}/loginController" class="login-link">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại đăng nhập
                    </a>
                </div>
            </div>
        </div>
        
        <script>
            // Auto-focus on OTP input
            document.querySelector('input[name="otp"]').focus();
            
            // Only allow numeric input for OTP
            document.querySelector('input[name="otp"]').addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
            
            // Password confirmation validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('Mật khẩu xác nhận không khớp!');
                }
            });
        </script>
    </body>
</html>
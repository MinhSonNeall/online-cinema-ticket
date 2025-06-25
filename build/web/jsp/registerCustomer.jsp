<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlex - Đăng ký tài khoản</title>
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
        
        /* Register Container */
        .register-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 3rem;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 0.6s ease forwards;
            position: relative;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .register-title {
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
        
        .register-subtitle {
            color: #aaa;
            font-size: 1rem;
        }
        
        /* Form Styles */
        .register-form {
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
        }
        
        .form-input:focus {
            outline: none;
            border-color: #ff6b6b;
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
        }
        
        .form-input::placeholder {
            color: #aaa;
        }
        
        /* Password Strength Indicator */
        .password-strength {
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            overflow: hidden;
            margin-top: 0.5rem;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }
        
        .strength-weak { background: #ff6b6b; width: 33%; }
        .strength-medium { background: #feca57; width: 66%; }
        .strength-strong { background: #48dbfb; width: 100%; }
        
        /* Register Button */
        .register-btn {
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
        }
        
        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        
        .register-btn:active {
            transform: translateY(0);
        }
        
        /* Additional Links */
        .register-links {
            text-align: center;
            margin-top: 2rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .register-link {
            color: #aaa;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }
        
        .register-link:hover {
            color: #ff6b6b;
        }
        
        .login-link {
            color: #feca57;
            font-weight: 500;
        }
        
        .login-link:hover {
            color: #ff6b6b;
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
        }
        
        /* Validation Messages */
        .field-error {
            color: #ff6b6b;
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }
        
        .field-success {
            color: #48dbfb;
            font-size: 0.8rem;
            margin-top: 0.25rem;
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
            
            .register-container {
                padding: 2rem;
                margin-top: 80px;
            }
            
            .register-title {
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
            
            .register-container {
                margin-top: 0;
                padding: 1.5rem;
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
        
        /* Loading Animation */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        .loading .register-btn {
            background: linear-gradient(45deg, #aaa, #ccc);
        }
        
        .loading .register-btn::after {
            content: '';
            width: 16px;
            height: 16px;
            border: 2px solid transparent;
            border-top: 2px solid #fff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-left: 0.5rem;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Background decoration */
        .register-container::before {
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
    <a href="Movie/index.jsp" class="logo">🎬 CinePlex</a>
    
    <!-- Main Content -->
    <main class="main-content">
        <div class="register-container">
            <div class="register-header">
                <h1 class="register-title">Đăng ký</h1>
                <p class="register-subtitle">Tạo tài khoản CinePlex của bạn</p>
            </div>
            
            <!-- Error Message -->
            <c:if test="${not empty errorform}">
                <div class="error-message">
                    ${errorform}
                </div>
            </c:if>
            
            <!-- Success Message -->
            <c:if test="${not empty success}">
                <div class="success-message">
                    ${success}
                </div>
            </c:if>
            
            <form class="register-form" action="<c:url value='/RegisterController'/>" method="POST" id="registerForm">
                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        class="form-input"
                        placeholder="Nhập email của bạn"
                        value="<c:out value='${param.email}' default=''/>"
                        required
                    >
                    <div class="field-validation" id="email-validation"></div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-input"
                        placeholder="Nhập mật khẩu"
                        required
                    >
                    <div class="password-strength">
                        <div class="password-strength-bar" id="password-strength-bar"></div>
                    </div>
                    <div class="field-validation" id="password-validation"></div>
                </div>
                
                <div class="form-group">
                    <label for="re_password" class="form-label">Nhập lại mật khẩu</label>
                    <input
                        type="password"
                        id="re_password"
                        name="re_password"
                        class="form-input"
                        placeholder="Nhập lại mật khẩu"
                        required
                    >
                    <div class="field-validation" id="confirm-password-validation"></div>
                </div>
                
                <div class="form-group">
                    <label for="full_name" class="form-label">Họ và tên</label>
                    <input
                        type="text"
                        id="full_name"
                        name="full_name"
                        class="form-input"
                        placeholder="Nhập họ và tên"
                        value="<c:out value='${param.full_name}' default=''/>"
                        required
                    >
                    <div class="field-validation" id="fullname-validation"></div>
                </div>
                
                <div class="form-group">
                    <label for="phone_number" class="form-label">Số điện thoại</label>
                    <input
                        type="tel"
                        id="phone_number"
                        name="phone_number"
                        class="form-input"
                        placeholder="Nhập số điện thoại"
                        value="<c:out value='${param.phone_number}' default=''/>"
                        required
                    >
                    <div class="field-validation" id="phone-validation"></div>
                </div>
                
                <button type="submit" class="register-btn">Đăng ký ngay</button>
            </form>
            
            <div class="register-links">
                <a href="<c:url value='/jsp/login.jsp'/>" class="login-link">Đã có tài khoản? Đăng nhập ngay</a>
            </div>
        </div>
    </main>
    
    <script>
        // Form submission with loading state
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const form = this;
            const container = document.querySelector('.register-container');
            
            // Validate form before submission
            if (!validateForm()) {
                e.preventDefault();
                return;
            }
            
            // Add loading state
            container.classList.add('loading');
            
            // Remove loading state after 3 seconds (fallback)
            setTimeout(() => {
                container.classList.remove('loading');
            }, 3000);
        });
        
        // Input focus animations
        document.querySelectorAll('.form-input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
        
        // Password strength checker
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('password-strength-bar');
            const validation = document.getElementById('password-validation');
            
            let strength = 0;
            let message = '';
            
            if (password.length >= 8) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            strengthBar.className = 'password-strength-bar';
            
            if (password.length === 0) {
                strengthBar.style.width = '0%';
                validation.textContent = '';
            } else if (strength <= 1) {
                strengthBar.classList.add('strength-weak');
                validation.textContent = 'Mật khẩu yếu';
                validation.className = 'field-error';
            } else if (strength <= 2) {
                strengthBar.classList.add('strength-medium');
                validation.textContent = 'Mật khẩu trung bình';
                validation.className = 'field-error';
            } else {
                strengthBar.classList.add('strength-strong');
                validation.textContent = 'Mật khẩu mạnh';
                validation.className = 'field-success';
            }
        });
        
        // Confirm password validation
        document.getElementById('re_password').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            const validation = document.getElementById('confirm-password-validation');
            
            if (confirmPassword === '') {
                validation.textContent = '';
                return;
            }
            
            if (password === confirmPassword) {
                validation.textContent = 'Mật khẩu khớp';
                validation.className = 'field-success';
            } else {
                validation.textContent = 'Mật khẩu không khớp';
                validation.className = 'field-error';
            }
        });
        
        // Phone number validation
        document.getElementById('phone_number').addEventListener('input', function() {
            const phone = this.value;
            const validation = document.getElementById('phone-validation');
            const phoneRegex = /^[0-9]{10,11}$/;
            
            if (phone === '') {
                validation.textContent = '';
                return;
            }
            
            if (phoneRegex.test(phone)) {
                validation.textContent = 'Số điện thoại hợp lệ';
                validation.className = 'field-success';
            } else {
                validation.textContent = 'Số điện thoại không hợp lệ';
                validation.className = 'field-error';
            }
        });
        
        // Full name validation
        document.getElementById('full_name').addEventListener('input', function() {
            const fullName = this.value.trim();
            const validation = document.getElementById('fullname-validation');
            
            if (fullName === '') {
                validation.textContent = '';
                return;
            }
            
            if (fullName.length >= 2) {
                validation.textContent = 'Tên hợp lệ';
                validation.className = 'field-success';
            } else {
                validation.textContent = 'Tên quá ngắn';
                validation.className = 'field-error';
            }
        });
        
        // Email validation
        document.getElementById('email').addEventListener('input', function() {
            const email = this.value;
            const validation = document.getElementById('email-validation');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (email === '') {
                validation.textContent = '';
                return;
            }
            
            if (emailRegex.test(email)) {
                validation.textContent = 'Email hợp lệ';
                validation.className = 'field-success';
            } else {
                validation.textContent = 'Email không hợp lệ';
                validation.className = 'field-error';
            }
        });
        
        // Form validation function
        function validateForm() {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('re_password').value;
            const fullName = document.getElementById('full_name').value.trim();
            const phone = document.getElementById('phone_number').value;
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^[0-9]{10,11}$/;
            
            if (!emailRegex.test(email)) {
                alert('Vui lòng nhập email hợp lệ');
                return false;
            }
            
            if (password.length < 6) {
                alert('Mật khẩu phải có ít nhất 6 ký tự');
                return false;
            }
            
            if (password !== confirmPassword) {
                alert('Mật khẩu xác nhận không khớp');
                return false;
            }
            
            if (fullName.length < 2) {
                alert('Vui lòng nhập họ tên hợp lệ');
                return false;
            }
            
            if (!phoneRegex.test(phone)) {
                alert('Vui lòng nhập số điện thoại hợp lệ (10-11 số)');
                return false;
            }
            
            return true;
        }
        
        // Auto-hide messages after 5 seconds
        setTimeout(() => {
            const messages = document.querySelectorAll('.error-message, .success-message');
            messages.forEach(message => {
                message.style.opacity = '0';
                message.style.transform = 'translateY(-10px)';
                setTimeout(() => {
                    message.style.display = 'none';
                }, 300);
            });
        }, 5000);
        
        // Logo click animation
        document.querySelector('.logo').addEventListener('click', function(e) {
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = 'scale(1.05)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
            }, 100);
        });
    </script>
</body>
</html>
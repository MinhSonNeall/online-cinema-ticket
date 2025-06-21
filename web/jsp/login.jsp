<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlex - Đăng nhập</title>
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
        
        /* Google Login Button */
        .google-btn {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
        }
        
        .google-btn:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.1);
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
        
        /* Loading Animation */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        .loading .login-btn {
            background: linear-gradient(45deg, #aaa, #ccc);
        }
        
        .loading .login-btn::after {
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
    <a href="jsp/Movie/index.jsp" class="logo">🎬 CinePlex</a>
    
    <!-- Main Content -->
    <main class="main-content">
        <div class="login-container">
            <div class="login-header">
                <h1 class="login-title">Đăng nhập</h1>
                <p class="login-subtitle">Chào mừng bạn quay trở lại CinePlex</p>
            </div>
            
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            
            <!-- Success Message -->
            <c:if test="${not empty success}">
                <div class="success-message">
                    ${success}
                </div>
            </c:if>
            
            <form class="login-form" action="loginController" method="post" id="loginForm">
                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        class="form-input"
                        placeholder="Nhập email của bạn"
                        value="${param.email}"
                        required
                    >
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
                </div>
                
                <button type="submit" class="login-btn">Đăng nhập</button>
            </form>
            
            <div class="divider">
                <span>hoặc</span>
            </div>
            
            <a href="LoginGoogleController" class="google-btn">
                <span>🔍</span>
                Đăng nhập với Google
            </a>
            
            <div class="login-links">
                <a href="#" class="login-link">Quên mật khẩu?</a>
                <a href="jsp/registerCustomer.jsp" class="register-link">Chưa có tài khoản? Đăng ký ngay</a>
            </div>
        </div>
    </main>
    
    <script>
        // Form submission with loading state
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const form = this;
            const container = document.querySelector('.login-container');
            
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
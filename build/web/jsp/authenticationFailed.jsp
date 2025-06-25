<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlex - Xác thực thất bại</title>
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
            overflow: hidden;
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
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 2rem;
            position: relative;
        }
        
        /* Error Container */
        .error-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 107, 107, 0.3);
            border-radius: 16px;
            padding: 3rem;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 20px 40px rgba(255, 107, 107, 0.2);
            animation: fadeInUp 0.6s ease forwards;
            position: relative;
            text-align: center;
        }
        
        /* Error Icon */
        .error-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, #ff6b6b, #ff4757);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            font-size: 2.5rem;
            color: #fff;
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }
        
        /* Error Title */
        .error-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
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
        
        /* Error Message */
        .error-message {
            color: #ccc;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .error-code {
            color: #ff6b6b;
            font-weight: bold;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            border: none;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            color: #fff;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.1);
        }
        
        /* Background Animation */
        .floating-shapes {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }
        
        .shape {
            position: absolute;
            background: linear-gradient(45deg, rgba(255, 107, 107, 0.1), rgba(254, 202, 87, 0.1));
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }
        
        .shape:nth-child(1) {
            width: 100px;
            height: 100px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }
        
        .shape:nth-child(2) {
            width: 150px;
            height: 150px;
            top: 60%;
            right: 10%;
            animation-delay: 2s;
        }
        
        .shape:nth-child(3) {
            width: 80px;
            height: 80px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
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
            
            .error-container {
                padding: 2rem;
                margin-top: 80px;
            }
            
            .error-title {
                font-size: 2rem;
            }
            
            .error-message {
                font-size: 1rem;
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
            
            .error-container {
                margin-top: 0;
                padding: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
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
        .error-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #ff6b6b, #feca57, #ff6b6b);
            border-radius: 18px;
            z-index: -1;
            opacity: 0.2;
            animation: borderGlow 3s ease-in-out infinite;
        }
        
        @keyframes borderGlow {
            0%, 100% { opacity: 0.2; }
            50% { opacity: 0.4; }
        }
        
        /* Shake animation for error */
        .shake {
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/ListMovieController" class="logo">🎬 CinePlex</a>
    
    <!-- Floating Background Shapes -->
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>
    
    <!-- Main Content -->
    <main class="main-content">
        <div class="error-container">
            <div class="error-icon">🚫</div>
            
            <h1 class="error-title">Xác thực thất bại</h1>
            
            <div class="error-code">ERROR 403 - FORBIDDEN</div>
            
            <p class="error-message">
                Rất tiếc! Bạn không có quyền truy cập vào trang này.<br>
                Vui lòng đăng nhập để tiếp tục sử dụng dịch vụ CinePlex.
            </p>
            
            <div class="action-buttons">
                
                <a href="${pageContext.request.contextPath}/ListMovieController" class="btn btn-secondary">
                    🏠 Về trang chủ
                </a>
            </div>
        </div>
    </main>
    
    <script>
        // Add shake animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const errorContainer = document.querySelector('.error-container');
            errorContainer.classList.add('shake');
            
            // Remove shake class after animation
            setTimeout(() => {
                errorContainer.classList.remove('shake');
            }, 500);
        });
        
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
        
        // Button click effects
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 100);
            });
        });
        
        // Auto redirect countdown (optional)
        let countdown = 30;
        const countdownElement = document.createElement('div');
        countdownElement.style.cssText = `
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1rem;
            border-radius: 8px;
            color: #aaa;
            font-size: 0.9rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        `;
        
        function updateCountdown() {
            countdownElement.textContent = `Tự động chuyển về trang đăng nhập sau ${countdown}s`;
            countdown--;
            
            if (countdown < 0) {
                window.location.href = '${pageContext.request.contextPath}/jsp/login.jsp';
            }
        }
        
        // Uncomment below lines if you want auto-redirect
        // document.body.appendChild(countdownElement);
        // setInterval(updateCountdown, 1000);
        // updateCountdown();
    </script>
</body>
</html>

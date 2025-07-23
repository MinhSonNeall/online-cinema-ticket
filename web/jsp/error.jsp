<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlex - Thông báo</title>
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
        
        /* Error Container */
        .error-container {
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
            text-align: center;
        }
        
        .error-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .error-title {
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
        
        .error-message {
            color: #fff;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            padding: 1rem;
            background: rgba(255, 107, 107, 0.1);
            border-radius: 8px;
            border: 1px solid rgba(255, 107, 107, 0.3);
        }
        
        /* Home Button */
        .home-btn {
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
            text-decoration: none;
            display: inline-block;
        }
        
        .home-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        
        .home-btn:active {
            transform: translateY(0);
        }
        
        /* Background decoration */
        .error-container::before {
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
            }
        }
    </style>
</head>
<body>
    <a href="<c:url value='/ListMovieController'/>" class="logo">🎬 CinePlex</a>
    
    <!-- Main Content -->
    <main class="main-content">
        <div class="error-container">
            <div class="error-header">
                <h1 class="error-title">Thông báo</h1>
            </div>
            
            <div class="error-message">
                Hiện tại chưa có lịch chiếu của phim này.
            </div>
            
            <a href="<c:url value='/ListMovieController'/>" class="home-btn">Quay về trang chủ</a>
        </div>
    </main>
    
    <script>
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
        
        // Button hover animation
        document.querySelector('.home-btn').addEventListener('mouseover', function() {
            this.style.transform = 'translateY(-2px)';
        });
        
        document.querySelector('.home-btn').addEventListener('mouseout', function() {
            this.style.transform = 'translateY(0)';
        });
    </script>
</body>
</html>

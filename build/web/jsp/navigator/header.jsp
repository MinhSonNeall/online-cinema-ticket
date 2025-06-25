<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    /* Header */
    .header {
        background: rgba(0, 0, 0, 0.95);
        backdrop-filter: blur(10px);
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem 2rem;
    }

    .logo {
        font-size: 1.8rem;
        font-weight: bold;
        color: #ff6b6b;
        text-decoration: none;
        background: linear-gradient(45deg, #ff6b6b, #feca57);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .nav-menu {
        display: flex;
        list-style: none;
        gap: 2rem;
    }

    .nav-menu a {
        color: #fff;
        text-decoration: none;
        transition: all 0.3s ease;
        padding: 0.5rem 1rem;
        border-radius: 8px;
    }

    .nav-menu a:hover {
        background: rgba(255, 107, 107, 0.2);
        color: #ff6b6b;
    }

    .user-profile {
        position: relative;
        display: inline-block;
    }

    .profile-btn {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        background: rgba(255, 107, 107, 0.1);
        border: 1px solid #ff6b6b;
        color: #ff6b6b;
        padding: 0.5rem 1rem;
        border-radius: 25px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .profile-btn:hover {
        background: #ff6b6b;
        color: #fff;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
    }

    .profile-dropdown {
        position: absolute;
        top: 100%;
        right: 0;
        background: rgba(0, 0, 0, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 12px;
        min-width: 250px;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.3s ease;
        margin-top: 0.5rem;
    }

    .user-profile:hover .profile-dropdown {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .profile-info {
        padding: 1.5rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .profile-name {
        color: #fff;
        font-weight: bold;
        margin-bottom: 0.5rem;
    }

    .profile-email {
        color: #aaa;
        font-size: 0.9rem;
    }

    .profile-actions {
        padding: 0.5rem;
    }

    .profile-actions a {
        display: block;
        color: #fff;
        text-decoration: none;
        padding: 0.75rem 1rem;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .profile-actions a:hover {
        background: rgba(255, 107, 107, 0.2);
        color: #ff6b6b;
    }

    .logout-btn {
        color: #ff4757 !important;
    }

    .logout-btn:hover {
        background: rgba(255, 71, 87, 0.2) !important;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .nav-container {
            padding: 1rem;
        }

        .nav-menu {
            display: none;
        }

        .profile-dropdown {
            right: -50px;
            min-width: 200px;
        }
    }
</style>

<header class="header">
    <nav class="nav-container">
        <a href="${pageContext.request.contextPath}/ListMovieController"" class="logo">🎬 CinePlex</a>
        
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/ListMovieController"">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/ListMovieController"">Phim</a></li>
            <li><a href="#theaters">Rạp chiếu</a></li>
            <li><a href="#promotions">Khuyến mãi</a></li>
            <li><a href="#contact">Liên hệ</a></li>
        </ul>

        <div class="auth-section">
    <% if (session.getAttribute("user") == null) { %>
        <!-- Chưa đăng nhập -->
        <div class="auth-buttons">
            <a href="${pageContext.request.contextPath}/loginController" class="auth-link" style="color: white; text-decoration: none;">ĐĂNG NHẬP</a>
           <span class="separator" style="color: white;"> / </span>
            <a href="${pageContext.request.contextPath}/RegisterController" class="auth-link" style="color: white; text-decoration: none;">ĐĂNG KÝ</a>
        </div>
    <% } else { %>
        <!-- Đã đăng nhập - giữ nguyên dropdown -->
        <div class="user-profile">
            <div class="profile-btn">
                <span>👤</span>
                <span><%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></span>
                <span>▼</span>
            </div>
            
            <div class="profile-dropdown">
                <div class="profile-info">
                    <div class="profile-name"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></div>
                    <div class="profile-email"><%= session.getAttribute("email") != null ? session.getAttribute("email") : "user@email.com" %></div>
                </div>
                <div class="profile-actions">
                    <a href="#profile">Thông tin cá nhân</a>
                    <a href="#booking-history">Lịch sử đặt vé</a>
                    <a href="#settings">Cài đặt</a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
                </div>
            </div>
        </div>
    <% } %>
</div>
<%
    } else {
        Users user = (Users) session.getAttribute("user");
        String role = user.getRole().toString();
        if ("CUSTOMER".equals(role)) {
%>
<div class="auth-section">
    <!-- Đã đăng nhập - giữ nguyên dropdown -->
    <div class="user-profile">
        <div class="profile-btn">
            <span>👤</span>
            <!-- this span tag below get attribute of user, not username, and take user.fullname-->
            <span>
                <%
                    String fullName = user.getFull_name();
                %>
                    <%= fullName %>
            </span>
            <span>▼</span>
        </div>
        
        <div class="profile-dropdown">
            <div class="profile-info">
                <%
                    fullName = user.getFull_name();
                %>
                    <div class="profile-name"><%= fullName %></div>
                <div class="profile-email"><%= session.getAttribute("email") != null ? session.getAttribute("email") : "user@email.com" %></div>
            </div>
            <div class="profile-actions">
                <a href="#profile">Thông tin cá nhân</a>
                <a href="#booking-history">Lịch sử đặt vé</a>
                <a href="#settings">Cài đặt</a>
                <a href="${pageContext.request.contextPath}/LogoutController" class="logout-btn">Đăng xuất</a>
            </div>
        </div>
    </div>
</div>
<%
        }
else{
%>
<div class="auth-buttons">
        <a href="${pageContext.request.contextPath}/loginController" class="auth-link" style="color: white; text-decoration: none;">ĐĂNG NHẬP</a>
        <span class="separator" style="color: white;"> / </span>
        <a href="${pageContext.request.contextPath}/loginController" class="auth-link" style="color: white; text-decoration: none;">ĐĂNG KÝ</a>
    </div>
<%
}
    }
%>
    </nav>
</header>

<script>
    // Add scroll effect to header
    window.addEventListener('scroll', () => {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {
            header.style.background = 'rgba(0, 0, 0, 0.98)';
        } else {
            header.style.background = 'rgba(0, 0, 0, 0.95)';
        }
    });

    // Profile dropdown close on outside click
    document.addEventListener('click', function(e) {
        const userProfile = document.querySelector('.user-profile');
        if (!userProfile.contains(e.target)) {
            // Optional: Add class to control dropdown state if needed
        }
    });
</script>

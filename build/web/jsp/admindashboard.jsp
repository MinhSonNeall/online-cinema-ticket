<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="/jsp/authenticationFailed.jsp"/>
</c:if>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #f5f6fa;
            min-height: 100vh;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Enhanced Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(to bottom, #2c3e50, #3498db);
            color: white;
            padding: 20px 0;
            min-height: 100vh;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            overflow-y: auto;
        }

        .logo {
            text-align: center;
            padding: 25px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
        }

        .logo h2 {
            color: white;
            font-size: 24px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .nav-section {
            margin-bottom: 30px;
        }

        .nav-title {
            padding: 12px 25px;
            color: rgba(255,255,255,0.6);
            font-size: 0.85em;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
        }

        .nav-links {
            list-style: none;
        }

        .nav-links li {
            margin: 5px 15px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            display: flex;
            align-items: center;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-links a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.1);
            transform: translateX(5px);
        }

        .welcome-user {
            padding: 20px;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
            margin: 15px;
            text-align: center;
        }

        /* Main Content Area */
        .main-content {
            flex: 1;
            padding: 30px;
            margin-left: 280px;
        }

        .header {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 600;
        }

        /* Enhanced Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            padding: 10px;
        }

        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #3498db, #2ecc71);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .dashboard-card:hover::before {
            opacity: 1;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .dashboard-card h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 20px;
            display: flex;
            align-items: center;
        }

        .dashboard-card h3 i {
            margin-right: 10px;
            color: #3498db;
        }

        .dashboard-card p {
            color: #7f8c8d;
            margin-bottom: 20px;
            font-size: 15px;
            line-height: 1.6;
        }

        .card-link {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .card-link i {
            margin-left: 8px;
        }

        .card-link:hover {
            background: #2980b9;
            transform: translateX(5px);
        }

        /* Logout Button */
        .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            margin: 15px;
            text-align: center;
            display: block;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                position: relative;
                min-height: auto;
            }
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            .header {
                flex-direction: column;
                text-align: center;
            }
        }
        .error-page {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 20px;
            text-align: center;
        }

        .error-icon {
            font-size: 120px;
            color: #e74c3c;
            margin-bottom: 20px;
            animation: bounce 2s ease infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-30px);
            }
            60% {
                transform: translateY(-15px);
            }
        }

        .error-title {
            font-size: 48px;
            color: #2c3e50;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .error-message {
            font-size: 24px;
            color: #7f8c8d;
            margin-bottom: 30px;
            max-width: 600px;
            line-height: 1.6;
        }

        .error-button {
            display: inline-flex;
            align-items: center;
            padding: 15px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-size: 18px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .error-button:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .error-button i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
   <!--  
            <div class="error-page">
                <i class="fas fa-exclamation-circle error-icon"></i>
                <h1 class="error-title">404</h1>
                <p class="error-message">Oops! Page not found. It seems you're not authorized to access this page.</p>
                <a href="loginCustomer.jsp" class="error-button">
                    <i class="fas fa-home"></i>
                    Back to Login
                </a>
            </div> -->
        
        
    <div class="container">
        <!-- Enhanced Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <h2><i class="fas fa-chart-line"></i> Staff Dashboard</h2>
            </div>
            
            <!-- User Info Section -->
            <div class="welcome-user">
                <i class="fas fa-user-circle" style="font-size: 48px; margin-bottom: 10px;"></i>
                <p>Welcome, ${adminUser.getFull_name()}</p>
                <div class="profile-dropdown">
                    <div class="profile-info">
                        <div class="profile-name">${adminUser.getFull_name()}</div>
                        <div class="profile-role">${adminUser.getRole()}</div>
                        <div class="profile-email">${adminUser.getEmail()}</div>
                    </div>
                    <div class="profile-actions">
<c:url var="logoutUrl" value="/LogoutController"/>
                        <a href="${logoutUrl}" class="logout-btn">Logout</a>
                    </div>
                </div>
            </div>

            <!-- Management Menu -->
 <div class="nav-section">
                <div class="nav-title">Management</div>
                <ul class="nav-links">
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
                    <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
                    <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
                    <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageRoomSeat"><i class="fas fa-chair"></i> Rooms & Seats</a></li>
                    <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageTicketPrice"><i class="fas fa-tag"></i> Ticket Prices</a></li>
                    <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageCombo"><i class="fas fa-utensils"></i> Combo Food</a></li>
                </ul>
            </div>
            
<a href="#" class="logout-btn">
                <i class="fas fa-user-cog"></i> Change Profile
            </a>
<c:url var="logoutUrl" value="/LogoutController"/>
            <a href="${logoutUrl}" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                
                <h1><i class="fas fa-tachometer-alt"></i> Staff Management Dashboard</h1>
            </div>

            <!-- Dashboard Grid -->
            <!-- Dashboard Grid -->
<div class="dashboard-grid">
    <div class="dashboard-card">
<h3><i class="fas fa-users"></i> User Accounts</h3>
        <p>Manage user accounts and permissions.</p>
<form action="http://localhost:9999/OnlineCinemaTicket/admin/ManageUserAccount" method="post">
    <button type="submit" class="card-link" style="border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
        Manage Users <i class="fas fa-arrow-right"></i>
    </button>
</form>
    </div>

    <div class="dashboard-card">
        <h3><i class="fas fa-film"></i> Movies</h3>
        <p>Manage movie listings and details.</p>
<form action="http://localhost:9999/OnlineCinemaTicket/admin/ManageMovie" method="post">
    <button type="submit" class="card-link" style="border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
        Manage Movies <i class="fas fa-arrow-right"></i>
    </button>
</form>
    </div>

    <div class="dashboard-card">
        <h3><i class="fas fa-clock"></i> Showtimes</h3>
        <p>Manage movie showtimes and schedules.</p>
<form action="http://localhost:9999/OnlineCinemaTicket/admin/ManageShowtime" method="post">
    <button type="submit" class="card-link" style="border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
        Manage Showtimes <i class="fas fa-arrow-right"></i>
    </button>
</form>
    </div>

    <div class="dashboard-card">
        <h3><i class="fas fa-chair"></i> Rooms & Seats</h3>
        <p>Manage cinema rooms and seat configurations.</p>
        <a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageRoomSeat" class="card-link">Manage Rooms & Seats <i class="fas fa-arrow-right"></i></a>
    </div>

    <div class="dashboard-card">
        <h3><i class="fas fa-tag"></i> Ticket Prices</h3>
        <p>Manage ticket prices and discounts.</p>
        <a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageTicketPrice" class="card-link">Manage Ticket Prices <i class="fas fa-arrow-right"></i></a>
    </div>

    <div class="dashboard-card">
        <h3><i class="fas fa-utensils"></i> Combo Food</h3>
        <p>Manage combo food items and prices.</p>
        <a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageCombo" class="card-link">Manage Combo Food <i class="fas fa-arrow-right"></i></a>
    </div>

           

            </body>
</html>

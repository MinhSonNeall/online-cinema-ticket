<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="/jsp/authenticationFailed.jsp"/>
</c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Cinema - ${cinema.name}</title>
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

.nav-links a.active {
background: rgba(255,255,255,0.2);
}

.welcome-user {
padding: 20px;
background: rgba(255,255,255,0.1);
border-radius: 8px;
margin: 15px;
text-align: center;
}

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

.breadcrumb {
background: white;
padding: 15px 25px;
border-radius: 10px;
box-shadow: 0 2px 10px rgba(0,0,0,0.05);
margin-bottom: 25px;
}

.breadcrumb a {
color: #3498db;
text-decoration: none;
}

.breadcrumb a:hover {
text-decoration: underline;
}

.breadcrumb i {
margin: 0 8px;
color: #95a5a6;
}

/* Form Section */
.form-section {
background: white;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
padding: 30px;
margin-bottom: 30px;
}

.form-section h2 {
color: #2c3e50;
font-size: 24px;
margin-bottom: 25px;
display: flex;
align-items: center;
}

.form-section h2 i {
margin-right: 10px;
color: #3498db;
}

.form-group {
margin-bottom: 20px;
}

.form-group label {
display: block;
margin-bottom: 8px;
font-weight: 500;
color: #2c3e50;
}

.form-group input[type="text"] {
width: 100%;
padding: 12px 15px;
border: 2px solid #e1e8ed;
border-radius: 8px;
font-size: 16px;
transition: all 0.3s ease;
}

.form-group input[type="text"]:focus {
border-color: #3498db;
outline: none;
box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
}

.form-group .hint {
font-size: 14px;
color: #7f8c8d;
margin-top: 5px;
}

.form-actions {
display: flex;
gap: 15px;
margin-top: 30px;
}

/* Cải thiện style cho các nút */
.btn {
    display: inline-block;
    font-weight: 500;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    user-select: none;
    border: 1px solid transparent;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: 0.25rem;
    transition: all 0.3s ease;
    text-decoration: none;
    cursor: pointer;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.btn:active {
    transform: translateY(0);
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.btn i {
    margin-right: 5px;
}

.btn-primary {
    background: linear-gradient(to right, #3498db, #2980b9);
    border-color: #2980b9;
    color: white;
}

.btn-primary:hover {
    background: linear-gradient(to right, #2980b9, #2573a7);
    border-color: #2573a7;
}

.btn-secondary {
    background: linear-gradient(to right, #95a5a6, #7f8c8d);
    border-color: #7f8c8d;
    color: white;
}

.btn-secondary:hover {
    background: linear-gradient(to right, #7f8c8d, #6c7a7d);
    border-color: #6c7a7d;
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
.header {
flex-direction: column;
text-align: center;
gap: 15px;
}
.form-actions {
flex-direction: column;
}
}
</style>
</head>
<body>
<div class="container">
    <div class="sidebar">
        <div class="logo">
            <h2><i class="fas fa-chart-line"></i> Staff Dashboard</h2>
        </div>
        <div class="welcome-user">
            <i class="fas fa-user-circle" style="font-size: 48px; margin-bottom: 10px;"></i>
            <p>Welcome, ${sessionScope.user.full_name}</p>
            <div class="profile-dropdown">
                <div class="profile-info">
                    <div class="profile-name">${sessionScope.user.full_name}</div>
                    <div class="profile-role">${sessionScope.user.role}</div>
                    <div class="profile-email">${sessionScope.user.email}</div>
                </div>
            </div>
        </div>
        <div class="nav-section">
            <div class="nav-title">Management</div>
            <ul class="nav-links">
                <li><a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
                <li><a href="ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
                <li><a href="ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
                <li><a href="ManageRoomSeat" class="active"><i class="fas fa-chair"></i> Cinemas</a></li>                
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
    
    <div class="main-content">
        <div class="header">
            <h1><i class="fas fa-edit"></i> Edit Cinema</h1>
        </div>
        
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/ManageRoomSeat"><i class="fas fa-building"></i> Cinemas</a>
            <i class="fas fa-chevron-right"></i>
            <span>Edit Cinema</span>
        </div>
        
        <div class="form-section">
            <h2><i class="fas fa-building"></i> Cinema Information</h2>
            
            <form action="${pageContext.request.contextPath}/ManageRoomSeat?service=updateCinema" method="post">
                <input type="hidden" name="cinemaId" value="${cinema.cinema_id}">
                
                <div class="form-group">
                    <label for="name">Cinema Name:</label>
                    <input type="text" id="name" name="name" value="${cinema.name}" required>
                    <div class="hint">Enter the full name of the cinema</div>
                </div>
                
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="${cinema.address}" required>
                    <div class="hint">Enter the full address of the cinema</div>
                </div>
                
                <div class="form-group">
                    <label for="city">City:</label>
                    <input type="text" id="city" name="city" value="${cinema.city}" required>
                    <div class="hint">Enter the city where the cinema is located</div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Cinema
                    </button>
                    <a href="${pageContext.request.contextPath}/ManageRoomSeat" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html> 
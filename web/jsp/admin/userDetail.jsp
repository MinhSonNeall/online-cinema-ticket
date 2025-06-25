<%-- 
Document   : userDetail
Created on : Jun 26, 2025, 1:22:52 AM
Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Detail</title>
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

/* User Detail Card */
.user-detail-card {
background: white;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
overflow: hidden;
margin-bottom: 30px;
}

.card-header {
background: linear-gradient(135deg, #3498db, #2980b9);
color: white;
padding: 25px;
text-align: center;
}

.card-header h2 {
font-size: 24px;
margin-bottom: 10px;
}

.card-header .user-avatar {
width: 80px;
height: 80px;
background: rgba(255,255,255,0.2);
border-radius: 50%;
display: flex;
align-items: center;
justify-content: center;
margin: 0 auto 15px;
font-size: 36px;
}

.card-body {
padding: 30px;
}

.user-info-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
gap: 25px;
}

.info-item {
background: #f8f9fa;
padding: 20px;
border-radius: 10px;
border-left: 4px solid #3498db;
transition: all 0.3s ease;
}

.info-item:hover {
transform: translateY(-2px);
box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.info-label {
color: #7f8c8d;
font-size: 14px;
font-weight: 500;
text-transform: uppercase;
letter-spacing: 0.5px;
margin-bottom: 8px;
display: flex;
align-items: center;
}

.info-label i {
margin-right: 8px;
color: #3498db;
}

.info-value {
color: #2c3e50;
font-size: 16px;
font-weight: 600;
word-break: break-all;
}

/* Action Buttons */
.action-section {
background: white;
padding: 25px;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
text-align: center;
}

.action-buttons {
display: flex;
gap: 15px;
justify-content: center;
flex-wrap: wrap;
}

.btn {
padding: 12px 25px;
border: none;
border-radius: 8px;
font-size: 14px;
font-weight: 500;
cursor: pointer;
transition: all 0.3s ease;
display: inline-flex;
align-items: center;
text-decoration: none;
}

.btn i {
margin-right: 8px;
}

.btn-primary {
background: #3498db;
color: white;
}

.btn-primary:hover {
background: #2980b9;
transform: translateY(-2px);
box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
}

.btn-secondary {
background: #95a5a6;
color: white;
}

.btn-secondary:hover {
background: #7f8c8d;
transform: translateY(-2px);
}

.btn-warning {
background: #f39c12;
color: white;
}

.btn-warning:hover {
background: #e67e22;
transform: translateY(-2px);
}

/* Not Found Message */
.not-found {
background: white;
padding: 50px;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
text-align: center;
}

.not-found-icon {
font-size: 80px;
color: #e74c3c;
margin-bottom: 20px;
}

.not-found h2 {
color: #2c3e50;
font-size: 24px;
margin-bottom: 15px;
}

.not-found p {
color: #7f8c8d;
font-size: 16px;
margin-bottom: 25px;
}

/* Status Badge */
.status-badge {
display: inline-block;
padding: 6px 12px;
border-radius: 20px;
font-size: 12px;
font-weight: 600;
text-transform: uppercase;
letter-spacing: 0.5px;
}

.status-active {
background: #d4edda;
color: #155724;
}

.status-inactive {
background: #f8d7da;
color: #721c24;
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
.user-info-grid {
grid-template-columns: 1fr;
}
.action-buttons {
flex-direction: column;
align-items: center;
}
.header {
flex-direction: column;
text-align: center;
}
}
</style>
</head>
<body>
<div class="container">
<!-- Enhanced Sidebar -->
<div class="sidebar">
<div class="logo">
<h2><i class="fas fa-chart-line"></i> Staff Dashboard</h2>
</div>

<!-- User Info Section -->
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

<!-- Management Menu -->
<div class="nav-section">
<div class="nav-title">Management</div>
<ul class="nav-links">
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageUserAccount" class="active"><i class="fas fa-users"></i> User Accounts</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageRoomSeat"><i class="fas fa-chair"></i> Rooms & Seats</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageTicketPrice"><i class="fas fa-tag"></i> Ticket Prices</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageCombo"><i class="fas fa-utensils"></i> Combo Food</a></li>
</ul>
</div>

<a href="ManageUserAccount?service=update&email=${sessionScope.user.email}" class="logout-btn">
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
<h1><i class="fas fa-user-circle"></i> User Details</h1>
</div>

<!-- Breadcrumb -->
<div class="breadcrumb">
<a href="http://localhost:9999/OnlineCinemaTicket/jsp/admindashboard.jsp"><i class="fas fa-home"></i> Dashboard</a> 
<span> / </span>
<a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a>
<span> / </span>
<span>User Details</span>
</div>

<c:set var="userDetails" value="${requestScope.userDetail}" />
<c:if test="${not empty userDetails}">
<c:set var="user" value="${userDetails.get(0)}" />

<!-- User Detail Card -->
<div class="user-detail-card">
<div class="card-header">
<div class="user-avatar">
<i class="fas fa-user"></i>
</div>
<h2><c:out value="${user.full_name}" /></h2>
<p><c:out value="${user.email}" /></p>
</div>
<div class="card-body">
<div class="user-info-grid">
<div class="info-item">
<div class="info-label">
<i class="fas fa-id-card"></i>
User ID
</div>
<div class="info-value">
<c:out value="${user.user_id}" />
</div>
</div>

<div class="info-item">
<div class="info-label">
<i class="fas fa-envelope"></i>
Email Address
</div>
<div class="info-value">
<c:out value="${user.email}" />
</div>
</div>

<div class="info-item">
<div class="info-label">
<i class="fas fa-user"></i>
Full Name
</div>
<div class="info-value">
<c:out value="${user.full_name}" />
</div>
</div>

<div class="info-item">
<div class="info-label">
<i class="fas fa-phone"></i>
Phone Number
</div>
<div class="info-value">
<c:choose>
<c:when test="${not empty user.phone_number}">
<c:out value="${user.phone_number}" />
</c:when>
<c:otherwise>
<span style="color: #95a5a6; font-style: italic;">Not provided</span>
</c:otherwise>
</c:choose>
</div>
</div>

<div class="info-item">
<div class="info-label">
<i class="fas fa-user-tag"></i>
Role
</div>
<div class="info-value">
<span class="status-badge ${user.role == 'ADMIN' ? 'status-active' : 'status-inactive'}">
<c:out value="${user.role}" />
</span>
</div>
</div>

<div class="info-item">
<div class="info-label">
<i class="fas fa-clock"></i>
Last Updated
</div>
<div class="info-value">
<c:choose>
<c:when test="${not empty user.updated_at}">
<fmt:formatDate value="${user.updated_at}" pattern="MMM dd, yyyy 'at' HH:mm:ss" />
</c:when>
<c:otherwise>
<span style="color: #95a5a6; font-style: italic;">Not available</span>
</c:otherwise>
</c:choose>
</div>
</div>
</div>
</div>
</div>

<!-- Action Buttons -->
<div class="action-section">
<h3 style="color: #2c3e50; margin-bottom: 20px;">
<i class="fas fa-cogs"></i> Available Actions
</h3>
<div class="action-buttons">
<a href="ManageUserAccount" class="btn btn-primary">
<i class="fas fa-arrow-left"></i> Back to Manage Users
</a>
<a href="ManageUserAccount?service=update&email=${user.email}" class="btn btn-warning">
<i class="fas fa-edit"></i> Edit User
</a>
<a href="#" class="btn btn-secondary" onclick="window.print()">
<i class="fas fa-print"></i> Print Details
</a>
</div>
</div>

</c:if>

<c:if test="${empty userDetails}">
<!-- Not Found Message -->
<div class="not-found">
<div class="not-found-icon">
<i class="fas fa-user-slash"></i>
</div>
<h2>User Not Found</h2>
<p>The requested user could not be found in the system. Please check the user ID and try again.</p>
<a href="ManageUserAccount" class="btn btn-primary">
<i class="fas fa-arrow-left"></i> Back to Manage Users
</a>
</div>
</c:if>

</div>
</div>
</body>
</html>
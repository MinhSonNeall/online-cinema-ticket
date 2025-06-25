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
<title>Manage Ticket Prices</title>
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

/* Search Section */
.search-section {
background: white;
padding: 25px;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
margin-bottom: 30px;
}

.search-section h3 {
color: #2c3e50;
margin-bottom: 20px;
font-size: 20px;
display: flex;
align-items: center;
}

.search-section h3 i {
margin-right: 10px;
color: #3498db;
}

.search-form {
display: grid;
grid-template-columns: 1fr 2fr auto auto;
gap: 15px;
align-items: end;
}

.form-group {
display: flex;
flex-direction: column;
}

.form-group label {
color: #2c3e50;
font-weight: 500;
margin-bottom: 5px;
font-size: 14px;
}

.form-group select,
.form-group input[type="text"] {
padding: 12px 15px;
border: 2px solid #e1e8ed;
border-radius: 8px;
font-size: 14px;
transition: all 0.3s ease;
}

.form-group select:focus,
.form-group input[type="text"]:focus {
outline: none;
border-color: #3498db;
box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

.btn {
padding: 12px 20px;
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
}

.btn-secondary {
background: #95a5a6;
color: white;
}

.btn-secondary:hover {
background: #7f8c8d;
}

/* Message */
.message {
padding: 15px 20px;
border-radius: 8px;
margin-bottom: 20px;
}

.message.success {
background: #d4edda;
color: #155724;
border: 1px solid #c3e6cb;
}

.message.error {
background: #f8d7da;
color: #721c24;
border: 1px solid #f5c6cb;
}

/* Table Section */
.table-section {
background: white;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
overflow: hidden;
}

.table-header {
background: #f8f9fa;
padding: 20px 25px;
border-bottom: 1px solid #e1e8ed;
}

.table-header h3 {
color: #2c3e50;
font-size: 18px;
display: flex;
align-items: center;
}

.table-header h3 i {
margin-right: 10px;
color: #3498db;
}

.table-container {
overflow-x: auto;
}

table {
width: 100%;
border-collapse: collapse;
}

thead {
background: #f8f9fa;
}

th {
padding: 15px 20px;
text-align: left;
font-weight: 600;
color: #2c3e50;
border-bottom: 2px solid #e1e8ed;
}

td {
padding: 15px 20px;
border-bottom: 1px solid #e1e8ed;
color: #2c3e50;
}

tbody tr:hover {
background: #f8f9fa;
}

.action-buttons {
display: flex;
gap: 8px;
}

.btn-sm {
padding: 6px 12px;
font-size: 12px;
}

.btn-info {
background: #17a2b8;
color: white;
}

.btn-info:hover {
background: #138496;
}

.btn-warning {
background: #ffc107;
color: #212529;
}

.btn-warning:hover {
background: #e0a800;
}

.btn-danger {
background: #dc3545;
color: white;
}

.btn-danger:hover {
background: #c82333;
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
.search-form {
grid-template-columns: 1fr;
}
.header {
flex-direction: column;
text-align: center;
}
.action-buttons {
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
<!-- Management Menu -->
<div class="nav-section">
<div class="nav-title">Management</div>
<ul class="nav-links">
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageRoomSeat"><i class="fas fa-chair"></i> Rooms & Seats</a></li>
<li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageTicketPrice" class="active"><i class="fas fa-tag"></i> Ticket Prices</a></li>
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
<div class="main-content">
<div class="header">
<h1><i class="fas fa-tag"></i> Manage Ticket Prices</h1>
</div>
<div class="breadcrumb">
<a href="http://localhost:9999/OnlineCinemaTicket/jsp/admindashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
<span> / </span>
<span>Ticket Prices</span>
</div>
<%-- TODO: Implement ticket price management functionality here --%>
</div>
</div>
</body>
</html>

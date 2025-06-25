<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, Entity.Users" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update User</title>
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

/* Update Form Card */
.update-form-card {
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

.card-header .user-icon {
width: 60px;
height: 60px;
background: rgba(255,255,255,0.2);
border-radius: 50%;
display: flex;
align-items: center;
justify-content: center;
margin: 0 auto 15px;
font-size: 24px;
}

.card-body {
padding: 40px;
}

.form-container {
max-width: 600px;
margin: 0 auto;
}

.form-group {
margin-bottom: 25px;
}

.form-group label {
display: block;
color: #2c3e50;
font-weight: 600;
margin-bottom: 8px;
font-size: 14px;
display: flex;
align-items: center;
}

.form-group label i {
margin-right: 8px;
color: #3498db;
width: 16px;
}

.form-group input {
width: 100%;
padding: 15px 18px;
border: 2px solid #e1e8ed;
border-radius: 10px;
font-size: 16px;
transition: all 0.3s ease;
background: #fff;
}

.form-group input:focus {
outline: none;
border-color: #3498db;
box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
transform: translateY(-1px);
}

.form-group input[readonly] {
background: #f8f9fa;
color: #6c757d;
cursor: not-allowed;
}

.form-group input[type="password"] {
font-family: 'Courier New', monospace;
letter-spacing: 2px;
}

/* Form Actions */
.form-actions {
display: flex;
gap: 15px;
justify-content: center;
margin-top: 40px;
padding-top: 30px;
border-top: 1px solid #e1e8ed;
}

.btn {
padding: 15px 30px;
border: none;
border-radius: 10px;
font-size: 16px;
font-weight: 600;
cursor: pointer;
transition: all 0.3s ease;
display: inline-flex;
align-items: center;
text-decoration: none;
min-width: 140px;
justify-content: center;
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
box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
}

.btn-secondary {
background: #95a5a6;
color: white;
}

.btn-secondary:hover {
background: #7f8c8d;
transform: translateY(-2px);
}

.btn-outline {
background: transparent;
color: #3498db;
border: 2px solid #3498db;
}

.btn-outline:hover {
background: #3498db;
color: white;
transform: translateY(-2px);
}

/* Back Link */
.back-link {
display: inline-flex;
align-items: center;
color: #3498db;
text-decoration: none;
font-weight: 500;
margin-bottom: 20px;
padding: 10px 15px;
border-radius: 8px;
transition: all 0.3s ease;
}

.back-link:hover {
background: rgba(52, 152, 219, 0.1);
transform: translateX(-5px);
}

.back-link i {
margin-right: 8px;
}

/* Validation Styles */
.form-group.error input {
border-color: #e74c3c;
box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
}

.error-message {
color: #e74c3c;
font-size: 14px;
margin-top: 5px;
display: flex;
align-items: center;
}

.error-message i {
margin-right: 5px;
}

/* Success Message */
.success-message {
background: #d4edda;
color: #155724;
padding: 15px 20px;
border-radius: 8px;
margin-bottom: 20px;
border: 1px solid #c3e6cb;
display: flex;
align-items: center;
}

.success-message i {
margin-right: 10px;
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
.card-body {
padding: 25px;
}
.form-actions {
flex-direction: column;
}
.header {
flex-direction: column;
text-align: center;
}
}
</style>
</head>
<body>
<%
Vector<Users> vector = (Vector<Users>) request.getAttribute("user");
Users user = vector.get(0);
%>

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
<h1><i class="fas fa-user-edit"></i> Update User</h1>
</div>

<!-- Breadcrumb -->
<div class="breadcrumb">
<a href="http://localhost:9999/OnlineCinemaTicket/jsp/admindashboard.jsp"><i class="fas fa-home"></i> Dashboard</a> 
<span> / </span>
<a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a>
<span> / </span>
<span>Update User</span>
</div>

<!-- Back Link -->
<a href="ManageUserAccount" class="back-link">
<i class="fas fa-arrow-left"></i> Back to User Management
</a>

<!-- Update Form Card -->
<div class="update-form-card">
<div class="card-header">
<div class="user-icon">
<i class="fas fa-user-edit"></i>
</div>
<h2>Update User Information</h2>
<p>Modify user details and save changes</p>
</div>
<div class="card-body">
<div class="form-container">
<form action="ManageUserAccount" method="post" id="updateForm">
<input type="hidden" name="service" value="update">

<div class="form-group">
<label for="user_id">
<i class="fas fa-id-card"></i>
User ID
</label>
<input type="text" name="user_id" id="user_id" value="<%= user.getUser_id()%>" readonly>
</div>

<div class="form-group">
<label for="full_name">
<i class="fas fa-user"></i>
Full Name
</label>
<input type="text" name="full_name" id="full_name" value="<%= user.getFull_name()%>" required>
</div>

<div class="form-group">
<label for="email">
<i class="fas fa-envelope"></i>
Email Address
</label>
<input type="email" name="email" id="email" value="<%= user.getEmail()%>" required>
</div>

<div class="form-group">
<label for="password">
<i class="fas fa-lock"></i>
Password
</label>
<input type="password" name="password" id="password" value="<%= user.getPassword()%>" required>
<small style="color: #7f8c8d; font-size: 12px; margin-top: 5px; display: block;">
<i class="fas fa-info-circle"></i> Leave unchanged if you don't want to modify the password
</small>
</div>

<div class="form-group">
<label for="phone_number">
<i class="fas fa-phone"></i>
Phone Number
</label>
<input type="text" name="phone_number" id="phone_number" value="<%= user.getPhone_number()%>" placeholder="Enter phone number">
</div>

<div class="form-actions">
<button type="submit" name="submit" value="Update" class="btn btn-primary">
<i class="fas fa-save"></i> Update User
</button>
</button>
<a href="ManageUserAccount" class="btn btn-outline">
<i class="fas fa-times"></i> Cancel
</a>
</div>
</form>
</div>
</div>
</div>
</div>
</div>

<script>
// Form validation
document.getElementById('updateForm').addEventListener('submit', function(e) {
const fullName = document.getElementById('full_name').value.trim();
const email = document.getElementById('email').value.trim();
const password = document.getElementById('password').value.trim();

if (!fullName || !email || !password) {
e.preventDefault();
alert('Please fill in all required fields.');
return false;
}

// Email validation
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
if (!emailRegex.test(email)) {
e.preventDefault();
alert('Please enter a valid email address.');
return false;
}

// Confirm update
if (!confirm('Are you sure you want to update this user information?')) {
e.preventDefault();
return false;
}
});

// Real-time validation feedback
document.getElementById('email').addEventListener('blur', function() {
const email = this.value.trim();
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const formGroup = this.closest('.form-group');

if (email && !emailRegex.test(email)) {
formGroup.classList.add('error');
if (!formGroup.querySelector('.error-message')) {
const errorMsg = document.createElement('div');
errorMsg.className = 'error-message';
errorMsg.innerHTML = '<i class="fas fa-exclamation-circle"></i> Please enter a valid email address';
formGroup.appendChild(errorMsg);
}
} else {
formGroup.classList.remove('error');
const errorMsg = formGroup.querySelector('.error-message');
if (errorMsg) {
errorMsg.remove();
}
}
});
</script>
</body>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Change Admin Profile</title>
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
/* Profile Form Styling */
.profile-form-container {
background: white;
border-radius: 15px;
padding: 30px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
margin-bottom: 30px;
}
.form-section {
margin-bottom: 25px;
}
.form-section h2 {
color: #2c3e50;
font-size: 20px;
margin-bottom: 20px;
padding-bottom: 10px;
border-bottom: 1px solid #eee;
}
.form-group {
margin-bottom: 20px;
}
.form-group label {
display: block;
margin-bottom: 8px;
color: #2c3e50;
font-weight: 500;
}
.form-control {
width: 100%;
padding: 12px 15px;
border: 1px solid #ddd;
border-radius: 8px;
font-size: 16px;
transition: all 0.3s ease;
}
.form-control:focus {
border-color: #3498db;
box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
outline: none;
}
.btn-primary {
background: #3498db;
color: white;
border: none;
padding: 12px 20px;
border-radius: 8px;
font-size: 16px;
font-weight: 500;
cursor: pointer;
transition: all 0.3s ease;
}
.btn-primary:hover {
background: #2980b9;
transform: translateY(-2px);
}
.alert {
padding: 15px;
border-radius: 8px;
margin-bottom: 20px;
}
.alert-success {
background-color: rgba(46, 204, 113, 0.1);
border: 1px solid rgba(46, 204, 113, 0.3);
color: #27ae60;
}
.alert-danger {
background-color: rgba(231, 76, 60, 0.1);
border: 1px solid rgba(231, 76, 60, 0.3);
color: #e74c3c;
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
<p>Welcome, ${sessionScope.user.getFull_name()}</p>
<div class="profile-dropdown">
<div class="profile-info">
<div class="profile-name">${sessionScope.user.getFull_name()}</div>
<div class="profile-role">${sessionScope.user.getRole()}</div>
<div class="profile-email">${sessionScope.user.getEmail()}</div>
</div>
</div>
</div>
<!-- Management Menu -->
<div class="nav-section">
<div class="nav-title">Management</div>
<ul class="nav-links">
<li><a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
<li><a href="ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
<li><a href="ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
<li><a href="ManageRoomSeat"><i class="fas fa-chair"></i> Cinemas</a></li>
</ul>
</div>
<a href="ChangeUserAdminProfile" class="logout-btn" style="background: #3498db;">
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
<h1><i class="fas fa-user-cog"></i> Change Admin Profile</h1>
</div
>

<!-- Profile Form -->
<div class="profile-form-container">
<c:if test="${not empty successMessage}">
<div class="alert alert-success">
<i class="fas fa-check-circle"></i> ${successMessage}
</div>
</c:if>
<c:if test="${not empty errorMessage}">
<div class="alert alert-danger">
<i class="fas fa-exclamation-circle"></i> ${errorMessage}
</div>
</c:if>

<form action="ChangeUserAdminProfile" method="post">
<input type="hidden" name="action" value="update">

<div class="form-section">
<h2>Personal Information</h2>
<div class="form-group">
<label for="fullName">Full Name</label>
<input type="text" id="fullName" name="fullName" class="form-control" value="${adminUser.getFull_name()}" required>
</div>
<div class="form-group">
<label for="email">Email</label>
<input type="email" id="email" name="email" class="form-control" value="${adminUser.getEmail()}" required>
</div>
<div class="form-group">
<label for="phone">Phone Number</label>
<input type="text" id="phone" name="phone" class="form-control" value="${adminUser.getPhone_number()}" required>
</div>
</div>

<div class="form-section">
<h2>Change Password (Optional)</h2>
<div class="form-group">
<label for="currentPassword">Current Password</label>
<input type="password" id="currentPassword" name="currentPassword" class="form-control">
</div>
<div class="form-group">
<label for="newPassword">New Password</label>
<input type="password" id="newPassword" name="newPassword" class="form-control">
</div>
<div class="form-group">
<label for="confirmPassword">Confirm New Password</label>
<input type="password" id="confirmPassword" name="confirmPassword" class="form-control">
</div>
</div>

<button type="submit" class="btn-primary">
<i class="fas fa-save"></i> Save Changes
</button>
</form>
</div>
</div>
</div>

<script>
// Password validation
document.querySelector('form').addEventListener('submit', function(e) {
const currentPassword = document.getElementById('currentPassword').value;
const newPassword = document.getElementById('newPassword').value;
const confirmPassword = document.getElementById('confirmPassword').value;

// If current password is filled, make sure new password and confirm password are also filled
if (currentPassword && (!newPassword || !confirmPassword)) {
e.preventDefault();
alert('Please fill in both new password and confirm password fields.');
return;
}

// If new password is filled, make sure current password is also filled
if (newPassword && !currentPassword) {
e.preventDefault();
alert('Please enter your current password to change to a new password.');
return;
}

// If new password and confirm password don't match
if (newPassword && newPassword !== confirmPassword) {
e.preventDefault();
alert('New password and confirm password do not match.');
return;
}
});
</script>
</body>
</html> 
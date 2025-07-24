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
<title>Manage Rooms - ${cinema.name}</title>
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

.btn-sm {
    padding: 0.25rem 0.5rem;
    font-size: 0.875rem;
    line-height: 1.5;
    border-radius: 0.2rem;
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

.btn-info {
    background: linear-gradient(to right, #17a2b8, #138496);
    border-color: #138496;
    color: white;
}

.btn-info:hover {
    background: linear-gradient(to right, #138496, #117a8b);
    border-color: #117a8b;
}

.btn-danger {
    background: linear-gradient(to right, #dc3545, #c82333);
    border-color: #c82333;
    color: white;
}

.btn-danger:hover {
    background: linear-gradient(to right, #c82333, #bd2130);
    border-color: #bd2130;
}

.btn-success {
    background: linear-gradient(to right, #28a745, #218838);
    border-color: #218838;
    color: white;
}

.btn-success:hover {
    background: linear-gradient(to right, #218838, #1e7e34);
    border-color: #1e7e34;
}

.btn-warning {
    background: linear-gradient(to right, #ffc107, #e0a800);
    border-color: #e0a800;
    color: #212529;
}

.btn-warning:hover {
    background: linear-gradient(to right, #e0a800, #d39e00);
    border-color: #d39e00;
    color: #212529;
}

.header .btn-primary {
    padding: 10px 20px;
    font-size: 16px;
    box-shadow: 0 4px 10px rgba(52, 152, 219, 0.3);
    transition: all 0.3s ease;
}

.header .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(52, 152, 219, 0.4);
}

/* Message Alerts */
.alert {
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    animation: fadeIn 0.5s ease;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

.alert-success {
    background: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}

.alert-danger {
    background: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}

/* Cinema Info Card */
.cinema-info-card {
    background: white;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    padding: 25px;
    margin-bottom: 30px;
    border-left: 5px solid #3498db;
}

.cinema-info-card h2 {
    color: #2c3e50;
    font-size: 24px;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
}

.cinema-info-card h2 i {
    margin-right: 10px;
    color: #3498db;
}

.cinema-info-card p {
    margin: 10px 0;
    color: #2c3e50;
    font-size: 16px;
}

.cinema-info-card p strong {
    display: inline-block;
    width: 100px;
    color: #7f8c8d;
}

/* Table Section */
.table-section {
background: white;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
overflow: hidden;
margin-bottom: 30px;
}

.table-header {
background: #f8f9fa;
padding: 20px 25px;
border-bottom: 1px solid #e1e8ed;
display: flex;
justify-content: space-between;
align-items: center;
}

.table-header h3 {
color: #2c3e50;
font-size: 18px;
display: flex;
align-items: center;
margin: 0;
}

.table-header h3 i {
margin-right: 10px;
color: #3498db;
}

.table-container {
    overflow-x: auto;
    border-radius: 0 0 15px 15px;
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
}

thead {
    background: linear-gradient(to right, #f8f9fa, #e9ecef);
}

th {
    padding: 15px 20px;
    text-align: left;
    font-weight: 600;
    color: #2c3e50;
    border-bottom: 2px solid #e1e8ed;
    position: sticky;
    top: 0;
    background: #f8f9fa;
    z-index: 10;
}

td {
    padding: 15px 20px;
    border-bottom: 1px solid #e1e8ed;
    color: #2c3e50;
    vertical-align: middle;
}

/* Cải thiện hiệu ứng hover cho các dòng trong bảng */
tbody tr {
    transition: all 0.2s ease;
}

tbody tr:hover {
    background: #f8f9fa;
    transform: scale(1.01);
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    z-index: 1;
    position: relative;
}

.action-buttons {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.action-buttons .btn {
    margin-bottom: 5px;
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
.action-buttons {
flex-direction: column;
}
.cinema-info-card p strong {
    width: 80px;
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
        <a href="ChangeUserAdminProfile" class="logout-btn">
            <i class="fas fa-user-cog"></i> Change Profile
        </a>
        <c:url var="logoutUrl" value="/LogoutController"/>
        <a href="${logoutUrl}" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
    
    <div class="main-content">
        <div class="header">
            <h1><i class="fas fa-door-open"></i> Manage Rooms</h1>
            <a href="${pageContext.request.contextPath}/ManageRoomSeat?service=addRoom&cinemaId=${cinema.cinema_id}" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Room
            </a>
        </div>
        
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/ManageRoomSeat"><i class="fas fa-building"></i> Cinemas</a>
            <i class="fas fa-chevron-right"></i>
            <span>${cinema.name}</span>
        </div>
        
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${sessionScope.success}
                <c:remove var="success" scope="session" />
            </div>
        </c:if>
        
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
                <c:remove var="error" scope="session" />
            </div>
        </c:if>
        
        <div class="cinema-info-card">
            <h2><i class="fas fa-building"></i> Cinema Information</h2>
            <p><strong>ID:</strong> ${cinema.cinema_id}</p>
            <p><strong>Name:</strong> ${cinema.name}</p>
            <p><strong>Address:</strong> ${cinema.address}</p>
            <p><strong>City:</strong> ${cinema.city}</p>
        </div>
        
        <div class="table-section">
            <div class="table-header">
                <h3><i class="fas fa-door-open"></i> All Rooms</h3>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Room Name</th>
                            <th>Total Seats</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty rooms}">
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 30px;">
                                        <i class="fas fa-info-circle" style="font-size: 24px; color: #3498db; margin-bottom: 10px; display: block;"></i>
                                        <p>No rooms found for this cinema.</p>
                                        <p>Click "Add New Room" to create one.</p>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="room" items="${rooms}">
                                    <tr>
                                        <td>${room.room_id}</td>
                                        <td>${room.name}</td>
                                        <td>${room.total_seats}</td>
                                        <td class="action-buttons">
                                            
                                            <a href="${pageContext.request.contextPath}/ManageRoomSeat?service=editRoom&id=${room.room_id}" class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/ManageRoomSeat?service=deleteRoom&id=${room.room_id}" 
                                               class="btn btn-danger btn-sm" 
                                               onclick="return confirm('Are you sure you want to delete this room? This action cannot be undone if the room is not used in any showtime.')">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="/jsp/authenticationFailed.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Showtimes</title>
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
display: flex;
justify-content: space-between;
align-items: center;
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
.btn-danger {
background: #dc3545;
color: white;
}
.btn-danger:hover {
background: #c82333;
}
.btn-success {
background: #28a745;
color: white;
}
.btn-success:hover {
background: #218838;
}
.btn-primary {
background: #3498db;
color: white;
}
.btn-primary:hover {
background: #2980b9;
}
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
                <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
                <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
                <li><a href="http://localhost:9999/OnlineCinemaTicket/admin/ManageShowtime" class="active"><i class="fas fa-clock"></i> Showtimes</a></li>
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
    <div class="main-content">
        <div class="header">
            <h1><i class="fas fa-clock"></i> Manage Showtimes</h1>
            <a href="${pageContext.request.contextPath}/ManageShowtime?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm Đợt Chiếu Mới</a>
        </div>
        
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success" style="background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                <i class="fas fa-check-circle"></i> ${sessionScope.success}
                <c:remove var="success" scope="session" />
            </div>
        </c:if>
        
        <div class="table-section">
            <div class="table-header">
                <h3><i class="fas fa-clock"></i> Danh sách Đợt Chiếu</h3>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID Đợt chiếu</th>
                            <th>Tên Phim</th>
                            <th>Rạp</th>
                            <th>Phòng</th>
                            <th>Ngày Bắt Đầu</th>
                            <th>Ngày Kết Thúc</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="showtime" items="${showtimeList}">
                            <tr>
                                <td>${showtime.showtime_id}</td>
                                <td>${showtime.movie_title}</td>
                                <td>${showtime.cinema_name}</td>
                                <td>${showtime.room_name}</td>
                                <td><fmt:formatDate value="${showtime.start_time}" pattern="dd/MM/yyyy" /></td>
                                <td><fmt:formatDate value="${showtime.end_time}" pattern="dd/MM/yyyy" /></td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/ManageShowtime?action=edit&id=${showtime.showtime_id}" class="btn btn-info btn-sm"><i class="fas fa-edit"></i> Sửa</a>
                                    <a href="${pageContext.request.contextPath}/ManageShowtime?action=delete&id=${showtime.showtime_id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa đợt chiếu này? Tất cả các suất chiếu và ghế liên quan cũng sẽ bị xóa vĩnh viễn.')"><i class="fas fa-trash-alt"></i> Xóa</a>
                                    <a href="${pageContext.request.contextPath}/ManageShowtime?action=add-slot&id=${showtime.showtime_id}" class="btn btn-success btn-sm"><i class="fas fa-plus"></i> Thêm Suất Chiếu</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>

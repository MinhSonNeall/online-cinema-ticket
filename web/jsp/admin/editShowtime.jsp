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
<title>Chỉnh Sửa Đợt Chiếu</title>
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
.form-section {
background: white;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
padding: 30px;
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
.form-control {
width: 100%;
padding: 12px 15px;
border: 2px solid #e1e8ed;
border-radius: 8px;
font-size: 14px;
transition: all 0.3s ease;
}
.form-control:focus {
outline: none;
border-color: #3498db;
box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}
.form-control-plaintext {
width: 100%;
padding: 12px 15px;
background-color: #f8f9fa;
border: 1px solid #e1e8ed;
border-radius: 8px;
font-size: 14px;
color: #6c757d;
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
                <li><a href="ManageShowtime" class="active"><i class="fas fa-clock"></i> Showtimes</a></li>
                <li><a href="ManageRoomSeat"><i class="fas fa-chair"></i> Cinemas</a></li>
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
            <h1><i class="fas fa-edit"></i> Chỉnh Sửa Đợt Chiếu</h1>
            <a href="${pageContext.request.contextPath}/ManageShowtime" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
        </div>
        <div class="form-section">
            <form action="${pageContext.request.contextPath}/ManageShowtime?action=edit" method="post">
                <input type="hidden" name="showtimeId" value="${showtime.showtime_id}">
                
                <div class="form-group">
                    <label>ID Đợt chiếu:</label>
                    <input type="text" class="form-control-plaintext" value="${showtime.showtime_id}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Tên Phim:</label>
                    <input type="text" class="form-control-plaintext" value="${showtime.movie_title}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Rạp:</label>
                    <input type="text" class="form-control-plaintext" value="${showtime.cinema_name}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Phòng:</label>
                    <input type="text" class="form-control-plaintext" value="${showtime.room_name}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="startTime">Ngày bắt đầu đợt chiếu:</label>
                    <input type="date" class="form-control" id="startTime" name="startTime" 
                           value="<fmt:formatDate value='${showtime.start_time}' pattern='yyyy-MM-dd' />" required>
                </div>
                
                <div class="form-group">
                    <label for="endTime">Ngày kết thúc đợt chiếu:</label>
                    <input type="date" class="form-control" id="endTime" name="endTime" 
                           value="<fmt:formatDate value='${showtime.end_time}' pattern='yyyy-MM-dd' />" required>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu Thay Đổi</button>
                    <a href="${pageContext.request.contextPath}/ManageShowtime" class="btn btn-secondary"><i class="fas fa-times"></i> Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html> 
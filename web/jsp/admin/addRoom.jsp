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
    <title>Add Room</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageMovie.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="logo">
                <h2><i class="fas fa-chart-line"></i> Staff Dashboard</h2>
            </div>
            <div class="nav-section">
                <div class="nav-title">Management</div>
                <ul class="nav-links">
                    <li><a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
                    <li><a href="ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
                    <li><a href="ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
                    <li><a href="ManageRoomSeat" class="active"><i class="fas fa-chair"></i> Rooms & Seats</a></li>
                    <li><a href="ManageTicketPrice"><i class="fas fa-tag"></i> Ticket Prices</a></li>
                    <li><a href="ManageCombo"><i class="fas fa-utensils"></i> Combo Food</a></li>
                </ul>
            </div>
            <a href="#" class="logout-btn"><i class="fas fa-user-cog"></i> Change Profile</a>
            <c:url var="logoutUrl" value="/LogoutController"/>
            <a href="${logoutUrl}" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <div class="main-content">
            <div class="header">
                <h1><i class="fas fa-plus"></i> Add Room</h1>
            </div>
            <div class="breadcrumb">
                <a href="adminController"><i class="fas fa-home"></i> Dashboard</a> / <a href="ManageRoomSeat">Rooms & Seats</a> / <span>Add Room</span>
            </div>
            
            <div class="form-container">
                <form action="ManageRoomSeat?service=add" method="post">
                    <div class="form-group">
                        <label for="roomName">Room Name</label>
                        <input type="text" name="roomName" id="roomName" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="totalSeats">Total Seats</label>
                        <input type="number" name="totalSeats" id="totalSeats" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Add Room</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 
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
    <title>Add Showtime</title>
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
                    <li><a href="ManageShowtime" class="active"><i class="fas fa-clock"></i> Showtimes</a></li>
                    <li><a href="ManageRoomSeat"><i class="fas fa-chair"></i> Rooms & Seats</a></li>
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
                <h1><i class="fas fa-plus"></i> Add Showtime</h1>
            </div>
            <div class="breadcrumb">
                <a href="adminController"><i class="fas fa-home"></i> Dashboard</a> / <a href="ManageShowtime">Showtimes</a> / <span>Add Showtime</span>
            </div>
            
            <div class="form-container">
                <form action="ManageShowtime?service=add" method="post">
                    <div class="form-group">
                        <label for="movieId">Movie</label>
                        <select name="movieId" id="movieId" class="form-control">
                            <c:forEach var="movie" items="${requestScope.movies}">
                                <option value="${movie.movie_id}">${movie.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="roomId">Room</label>
                        <select name="roomId" id="roomId" class="form-control">
                            <c:forEach var="room" items="${requestScope.rooms}">
                                <option value="${room.room_id}">${room.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="startTime">Start Time</label>
                        <input type="datetime-local" name="startTime" id="startTime" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="endTime">End Time</label>
                        <input type="datetime-local" name="endTime" id="endTime" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="ticketPrice">Ticket Price</label>
                        <input type="number" name="ticketPrice" id="ticketPrice" class="form-control" step="0.01">
                    </div>
                    <button type="submit" class="btn btn-primary">Add Showtime</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 
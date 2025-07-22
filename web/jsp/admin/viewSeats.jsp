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
    <title>View Seats</title>
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
                <h1><i class="fas fa-eye"></i> View Seats for Room ${requestScope.roomId}</h1>
            </div>
            <div class="breadcrumb">
                <a href="adminController"><i class="fas fa-home"></i> Dashboard</a> / <a href="ManageRoomSeat">Rooms & Seats</a> / <span>View Seats</span>
            </div>
            
            <div class="table-section">
                <div class="table-header">
                    <h3>All Seats</h3>
                    <a href="ManageRoomSeat?service=addSeat&roomId=${requestScope.roomId}" class="btn btn-primary"><i class="fas fa-plus"></i> Add New Seat</a>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Seat Number</th>
                                <th>Type</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="seat" items="${requestScope.seats}">
                                <tr>
                                    <td>${seat.seat_id}</td>
                                    <td>${seat.seat_number}</td>
                                    <td>${seat.type}</td>
                                    <td>${seat.price}</td>
                                    <td class="action-buttons">
                                        <a href="ManageRoomSeat?service=editSeat&id=${seat.seat_id}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Edit</a>
                                        <a href="ManageRoomSeat?service=deleteSeat&id=${seat.seat_id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')"><i class="fas fa-trash-alt"></i> Delete</a>
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
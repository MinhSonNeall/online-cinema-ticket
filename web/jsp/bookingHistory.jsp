<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking History</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold mb-6 text-center">Lịch Sử Đặt Vé</h1>
        <c:if test="${empty bookingHistory}">
            <p class="text-center text-gray-500">Bạn chưa có lịch sử đặt vé.</p>
        </c:if>
        <c:if test="${not empty bookingHistory}">
            <table class="w-full border-collapse border border-gray-300">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="border border-gray-300 p-2">Phim</th>
                        <th class="border border-gray-300 p-2">Suất Chiếu</th>
                        <th class="border border-gray-300 p-2">Ghế</th>
                        <th class="border border-gray-300 p-2">Tổng Tiền</th>
                        <th class="border border-gray-300 p-2">Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ticket" items="${bookingHistory}">
                        <tr>
                            <td class="border border-gray-300 p-2">${ticket.movieTitle}</td>
                            <td class="border border-gray-300 p-2">${ticket.showtimeStartTime}</td>
                            <td class="border border-gray-300 p-2">${ticket.seatNumber}</td>
                            <td class="border border-gray-300 p-2">${ticket.total_amount} VNĐ</td>
                            <td class="border border-gray-300 p-2">${ticket.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>
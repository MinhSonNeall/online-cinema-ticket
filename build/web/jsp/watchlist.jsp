<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Watchlist</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold mb-6 text-center">Danh Sách Yêu Thích</h1>
        <c:if test="${empty watchlist}">
            <p class="text-center text-gray-500">Danh sách yêu thích của bạn đang trống.</p>
        </c:if>
        <c:if test="${not empty watchlist}">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <c:forEach var="movie" items="${watchlist}">
                    <div class="bg-white p-4 rounded shadow">
                        <h2 class="text-xl font-bold mb-2">${movie.title}</h2>
                        <p class="text-gray-600 mb-2">Thời lượng: ${movie.duration} phút</p>
                        <p class="text-gray-600 mb-2">Giới hạn tuổi: ${movie.age_restriction}+</p>
                        <a href="WatchlistController?action=remove&movieId=${movie.movie_id}" class="bg-red-500 text-white px-4 py-2 rounded">Xóa</a>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</body>
</html>

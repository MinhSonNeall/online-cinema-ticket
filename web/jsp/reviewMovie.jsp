<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Review Movie</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold mb-6 text-center">Đánh Giá Phim</h1>
        <form action="ReviewController" method="POST" class="mb-6">
            <input type="hidden" name="movieId" value="${movieId}">
            <div class="mb-4">
                <label class="block text-gray-700">Rating (1-5):</label>
                <select name="rating" class="w-full p-2 border rounded">
                    <option value="1">1 sao</option>
                    <option value="2">2 sao</option>
                    <option value="3">3 sao</option>
                    <option value="4">4 sao</option>
                    <option value="5">5 sao</option>
                </select>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700">Bình Luận:</label>
                <textarea name="comment" class="w-full p-2 border rounded" rows="4"></textarea>
            </div>
            <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded">Gửi Đánh Giá</button>
        </form>
        <h2 class="text-2xl font-bold mb-4">Danh Sách Đánh Giá</h2>
        <c:if test="${empty reviews}">
            <p class="text-center text-gray-500">Chưa có đánh giá nào cho phim này.</p>
        </c:if>
        <c:if test="${not empty reviews}">
            <c:forEach var="review" items="${reviews}">
                <div class="bg-white p-4 mb-4 rounded shadow">
                    <p><strong>${review.userName}</strong> - ${review.rating} sao</p>
                    <p>${review.comment}</p>
                    <p class="text-gray-500 text-sm">Ngày: ${review.created_at}</p>
                </div>
            </c:forEach>
        </c:if>
    </div>
</body>
</html>

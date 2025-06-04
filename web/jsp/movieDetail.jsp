<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .movie-details {
            display: flex;
            gap: 20px;
        }
        .movie-details img {
            width: 300px;
            height: 400px;
            object-fit: cover;
            border-radius: 8px;
        }
        .movie-info {
            flex: 1;
        }
        .movie-info h1 {
            margin-top: 0;
        }
        .movie-info p {
            margin: 10px 0;
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back-link:hover {
            background-color: #0056b3;
        }
        @media (max-width: 600px) {
            .movie-details {
                flex-direction: column;
            }
            .movie-details img {
                width: 100%;
                height: auto;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Movie Details</h1>
    <c:choose>
        <c:when test="${not empty movie}">
            <div class="movie-details">
                <img src="${not empty movie.poster_url ? movie.poster_url : 'https://via.placeholder.com/300x400?text=No+Poster'}" alt="${movie.title} Poster">
                <div class="movie-info">
                    <h1>${movie.title}</h1>
                    <p><strong>Description:</strong> ${movie.description}</p>
                    <p><strong>Duration:</strong>
                        <c:set var="hours" value="${movie.duration div 60}"/>
                        <c:set var="minutes" value="${movie.duration mod 60}"/>
                            ${hours}h ${minutes}m
                    </p>
                    <p><strong>Age Required:</strong> ${movie.age_restriction}+</p>
                    <p><strong>Release Date:</strong> ${movie.release_date}</p>
                    <p><strong>Status:</strong> ${movie.status}</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <p style="color: red;">Movie not found!</p>
        </c:otherwise>
    </c:choose>
    <a href="MovieController?action=list" class="back-link">Back to Movie List</a>
</div>
</body>
</html>
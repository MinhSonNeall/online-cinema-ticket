<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .tabs {
            margin-bottom: 20px;
        }
        .tabs a {
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #ddd;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
        }
        .tabs a.active {
            background-color: #007bff;
            color: white;
        }
        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .movie-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
            text-align: center;
            padding: 10px;
        }
        .movie-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }
        .movie-card h3 {
            font-size: 1.2em;
            margin: 10px 0;
        }
        .movie-card p {
            color: #666;
            font-size: 0.9em;
            margin: 5px 0;
        }
        .movie-card .description-preview {
            font-style: italic;
            color: #555;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .movie-card a {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .movie-card a:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }
        @media (max-width: 600px) {
            .movie-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Movie List</h1>
    <div class="tabs">
        <a href="MovieController?action=list&status=now_showing" class="${selectedStatus == 'now_showing' ? 'active' : ''}">Now Showing</a>
        <a href="MovieController?action=list&status=coming_soon" class="${selectedStatus == 'coming_soon' ? 'active' : ''}">Coming Soon</a>
    </div>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <div class="movie-grid">
        <c:set var="movies" value="${selectedStatus == 'now_showing' ? nowShowingMovies : comingSoonMovies}"/>
        <c:choose>
            <c:when test="${not empty movies}">
                <c:forEach var="movie" items="${movies}">
                    <div class="movie-card">
                        <img src="${not empty movie.poster_url ? movie.poster_url : 'https://via.placeholder.com/200x250?text=No+Poster'}" alt="${movie.title} Poster">
                        <h3>${movie.title}</h3>
                        <p>Duration:
                            <c:set var="hours" value="${movie.duration div 60}"/>
                            <c:set var="minutes" value="${movie.duration mod 60}"/>
                                ${hours}h ${minutes}m
                        </p>
                        <p>Age: ${movie.age_restriction}+</p>
                        <p class="description-preview">${fn:substring(movie.description, 0, 50)}${fn:length(movie.description) > 50 ? '...' : ''}</p>
                        <a href="MovieController?action=detail&movieId=${movie.movie_id}">View Details</a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No movies available in this category.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
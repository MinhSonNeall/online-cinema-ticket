<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Movie List</title>
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
        .movie-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .movie-table th, .movie-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .movie-table th {
            background-color: #f8f8f8;
        }
        .movie-table img {
            width: 50px;
            height: 75px;
            object-fit: cover;
            border-radius: 4px;
        }
        .movie-table .actions a {
            margin-right: 10px;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 4px;
        }
        .movie-table .actions .view {
            background-color: #007bff;
            color: white;
        }
        .movie-table .actions .view:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }
        @media (max-width: 600px) {
            .movie-table, .movie-table thead, .movie-table tbody, .movie-table th, .movie-table td, .movie-table tr {
                display: block;
            }
            .movie-table thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            .movie-table tr {
                border: 1px solid #ddd;
                margin-bottom: 10px;
            }
            .movie-table td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: left;
            }
            .movie-table td:before {
                position: absolute;
                left: 10px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                font-weight: bold;
            }
            .movie-table td:nth-of-type(1):before { content: "Title"; }
            .movie-table td:nth-of-type(2):before { content: "Poster"; }
            .movie-table td:nth-of-type(3):before { content: "Duration"; }
            .movie-table td:nth-of-type(4):before { content: "Age"; }
            .movie-table td:nth-of-type(5):before { content: "Status"; }
            .movie-table td:nth-of-type(6):before { content: "Actions"; }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Admin Movie List</h1>
    <div class="tabs">
        <a href="MovieController?action=list&status=now_showing" class="${selectedStatus == 'now_showing' ? 'active' : ''}">Now Showing</a>
        <a href="MovieController?action=list&status=coming_soon" class="${selectedStatus == 'coming_soon' ? 'active' : ''}">Coming Soon</a>
    </div>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <table class="movie-table">
        <thead>
        <tr>
            <th>Title</th>
            <th>Poster</th>
            <th>Duration</th>
            <th>Age</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="movies" value="${selectedStatus == 'now_showing' ? nowShowingMovies : comingSoonMovies}"/>
        <c:choose>
            <c:when test="${not empty movies}">
                <c:forEach var="movie" items="${movies}">
                    <tr>
                        <td>${movie.title}</td>
                        <td><img src="${not empty movie.poster_url ? movie.poster_url : 'https://via.placeholder.com/50x75?text=No+Poster'}" alt="${movie.title} Poster"></td>
                        <td>
                            <c:set var="hours" value="${movie.duration div 60}"/>
                            <c:set var="minutes" value="${movie.duration mod 60}"/>
                                ${hours}h ${minutes}m
                        </td>
                        <td>${movie.age_restriction}+</td>
                        <td>${movie.status}</td>
                        <td class="actions">
                            <a href="MovieController?action=detail&movieId=${movie.movie_id}" class="view">View Details</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6" style="text-align: center;">No movies available in this category.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
</body>
</html>
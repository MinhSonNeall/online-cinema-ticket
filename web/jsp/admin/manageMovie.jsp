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
<title>Manage Movies</title>
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

/* Enhanced Sidebar */
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

/* Main Content Area */
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

.breadcrumb {
background: white;
padding: 15px 25px;
border-radius: 10px;
box-shadow: 0 2px 10px rgba(0,0,0,0.05);
margin-bottom: 25px;
}

.breadcrumb a {
color: #3498db;
text-decoration: none;
}

.breadcrumb a:hover {
text-decoration: underline;
}

/* Search Section */
.search-section {
background: white;
padding: 25px;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
margin-bottom: 30px;
}

.search-section h3 {
color: #2c3e50;
margin-bottom: 20px;
font-size: 20px;
display: flex;
align-items: center;
}

.search-section h3 i {
margin-right: 10px;
color: #3498db;
}

.search-form {
display: grid;
grid-template-columns: 1fr 2fr auto auto;
gap: 15px;
align-items: end;
}

.form-group {
display: flex;
flex-direction: column;
}

.form-group label {
color: #2c3e50;
font-weight: 500;
margin-bottom: 5px;
font-size: 14px;
}

.form-group select,
.form-group input[type="text"] {
padding: 12px 15px;
border: 2px solid #e1e8ed;
border-radius: 8px;
font-size: 14px;
transition: all 0.3s ease;
}

.form-group select:focus,
.form-group input[type="text"]:focus {
outline: none;
border-color: #3498db;
box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
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

/* Message */
.message {
padding: 15px 20px;
border-radius: 8px;
margin-bottom: 20px;
}

.message.success {
background: #d4edda;
color: #155724;
border: 1px solid #c3e6cb;
}

.message.error {
background: #f8d7da;
color: #721c24;
border: 1px solid #f5c6cb;
}

/* Table Section */
.table-section {
background: white;
border-radius: 15px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
overflow: hidden;
}

.table-header {
background: #f8f9fa;
padding: 20px 25px;
border-bottom: 1px solid #e1e8ed;
}

.table-header h3 {
color: #2c3e50;
font-size: 18px;
display: flex;
align-items: center;
}

.table-header h3 i {
margin-right: 10px;
color: #3498db;
}

.table-container {
overflow-x: auto;
}

table {
width: 100%;
border-collapse: collapse;
}

thead {
background: #f8f9fa;
}

th {
padding: 15px 20px;
text-align: left;
font-weight: 600;
color: #2c3e50;
border-bottom: 2px solid #e1e8ed;
}

td {
padding: 15px 20px;
border-bottom: 1px solid #e1e8ed;
color: #2c3e50;
}

tbody tr:hover {
background: #f8f9fa;
}

.action-buttons {
display: flex;
gap: 8px;
}

.btn-sm {
padding: 6px 12px;
font-size: 12px;
}

.btn-info {
background: #17a2b8;
color: white;
}

.btn-info:hover {
background: #138496;
}

.btn-warning {
background: #ffc107;
color: #212529;
}

.btn-warning:hover {
background: #e0a800;
}

.btn-danger {
background: #dc3545;
color: white;
}

.btn-danger:hover {
background: #c82333;
}

/* Responsive Design */
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
.search-form {
grid-template-columns: 1fr;
}
.header {
flex-direction: column;
text-align: center;
}
.action-buttons {
flex-direction: column;
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
<!-- Management Menu -->
<div class="nav-section">
<div class="nav-title">Management</div>
<ul class="nav-links">
<li><a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
<li><a href="ManageMovie" class="active"><i class="fas fa-film"></i> Movies</a></li>
<li><a href="ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
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
<h1><i class="fas fa-film"></i> Manage Movies</h1>
</div>
<div class="breadcrumb">
<a href="adminController"><i class="fas fa-home"></i> Dashboard</a>
<span> / </span>
<span>Movies</span>
</div>
<div class="search-section">
    <h3><i class="fas fa-search"></i> Search Movies</h3>
    <form action="ManageMovie" method="get" class="search-form">
        <input type="hidden" name="service" value="searchMovie"/>
        <div class="form-group">
            <label for="searchTitle">Movie Title</label>
            <input type="text" id="searchTitle" name="title" placeholder="Enter movie title" value="${requestScope.searchTitle != null ? requestScope.searchTitle : ''}">
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
        <a href="manageMovie?service=listAllMovies" class="btn btn-secondary"><i class="fas fa-sync-alt"></i> Reset</a>
    </form>
</div>

<c:if test="${not empty sessionScope.successMessage}">
    <div class="message success">
        <i class="fas fa-check-circle"></i>
        ${sessionScope.successMessage}
    </div>
   
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="message error">
        <i class="fas fa-exclamation-circle"></i>
        ${sessionScope.errorMessage}
    </div>
    
</c:if>

<div class="table-section">
    <div class="table-header">
        <h3><i class="fas fa-film"></i> All Movies</h3>
        <a href="ManageMovie?service=addMovieForm" class="btn btn-primary"><i class="fas fa-plus"></i> Add New Movie</a>
    </div>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Director</th>
                    <th>Release Date</th>
                    <th>Duration (min)</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="movie" items="${requestScope.moviesList}">
                    <tr>
                        <td>${movie.movie_id}</td>
                        <td>${movie.title}</td>
                        <td>${movie.director}</td>
                        <td>${movie.release_date}</td>
                        <td>${movie.duration}</td>
                        <td>
                            <a href="ManageMovie?service=changeMovieStatus&movieId=${movie.movie_id}&currentStatus=${movie.status}" 
                               class="status-toggle-btn status-${movie.status.name().toLowerCase()}">
                                <c:choose>
                                    <c:when test="${movie.status == 'NOW_SHOWING'}">
                                        <i class="fas fa-circle-play"></i> Now Showing
                                    </c:when>
                                    <c:when test="${movie.status == 'COMING_SOON'}">
                                        <i class="fas fa-hourglass-start"></i> Coming Soon
                                    </c:when>
                                    <c:otherwise>
                                        ${movie.status}
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td class="action-buttons">
                            <button type="button" class="btn btn-info btn-sm" onclick="showMovieDetail('${movie.movie_id}')"><i class="fas fa-eye"></i> Detail</button>
                            <a href="ManageMovie?service=editMovieForm&id=${movie.movie_id}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Edit</a>
                            <a href="ManageMovie?service=deleteMovie&id=${movie.movie_id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this movie?');"><i class="fas fa-trash-alt"></i> Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty requestScope.moviesList}">
                    <tr>
                        <td colspan="7" style="text-align: center;">No movies found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>    
    </div>
</div>
</div>
</div>
<style>
    .status-toggle-btn {
        display: inline-flex;
        align-items: center;
        padding: 5px 10px;
        border-radius: 5px;
        font-weight: bold;
        text-decoration: none;
        color: white;
        transition: background-color 0.3s ease;
    }
    .status-toggle-btn i {
        margin-right: 5px;
    }
    .status-now_showing {
        background-color: #28a745; /* Green */
    }
    .status-now_showing:hover {
        background-color: #218838;
    }
    .status-coming_soon {
        background-color: #ffc107; /* Yellow */
        color: #333;
    }
    .status-coming_soon:hover {
        background-color: #e0a800;
    }
</style>
</body>
<div id="movieDetailModal" class="modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h2 id="modalMovieTitle"></h2>
        <div class="modal-body">
            <div class="modal-poster-container">
                <img id="modalMoviePoster" src="" alt="Movie Poster" class="modal-poster-image">
            </div>
            <div class="modal-info">
                <p><strong>Description:</strong> <span id="modalMovieDescription"></span></p>
                <p><strong>Age Restriction:</strong> <span id="modalMovieAgeRestriction"></span></p>
                <p><strong>Director:</strong> <span id="modalMovieDirector"></span></p>
                <p><strong>Genre:</strong> <span id="modalMovieGenre"></span></p>
                <p><strong>Release Date:</strong> <span id="modalMovieReleaseDate"></span></p>
                <p><strong>Duration:</strong> <span id="modalMovieDuration"></span> minutes</p>
                <p><strong>Status:</strong> <span id="modalMovieStatus"></span></p>
                <p><strong>Created At:</strong> <span id="modalMovieCreatedAt"></span></p>
                <p><strong>Updated At:</strong> <span id="modalMovieUpdatedAt"></span></p>
                <p><strong>Trailer:</strong> <a id="modalMovieTrailer" href="#" target="_blank">Watch Trailer</a></p>
            </div>
        </div>
    </div>
</div>

<style>
    /* Modal Styles */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1001; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgba(0,0,0,0.7); /* Black w/ opacity */
        padding-top: 60px;
    }

    .modal-content {
        background-color: #1a1a2e;
        margin: 5% auto; /* 15% from the top and centered */
        padding: 30px;
        border: 1px solid #888;
        width: 80%; /* Could be more or less, depending on screen size */
        max-width: 900px;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(255, 107, 107, 0.3);
        position: relative;
        color: #fff;
    }

    .close-button {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        position: absolute;
        top: 15px;
        right: 25px;
    }

    .close-button:hover,
    .close-button:focus {
        color: #ff6b6b;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-body {
        display: flex;
        gap: 30px;
        margin-top: 20px;
    }

    .modal-poster-container {
        flex-shrink: 0;
        width: 300px;
    }

    .modal-poster-image {
        width: 100%;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .modal-info {
        flex-grow: 1;
    }

    .modal-info p {
        margin-bottom: 10px;
        font-size: 1.1em;
    }

    .modal-info strong {
        color: #feca57;
    }

    #modalMovieTitle {
        font-size: 2em;
        color: #ff6b6b;
        margin-bottom: 15px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        padding-bottom: 10px;
    }

    #modalMovieTrailer {
        color: #48dbfb;
        text-decoration: none;
        font-weight: bold;
    }

    #modalMovieTrailer:hover {
        text-decoration: underline;
    }

    @media (max-width: 768px) {
        .modal-body {
            flex-direction: column;
            align-items: center;
        }
        .modal-poster-container {
            width: 80%;
            max-width: 250px;
        }
        .modal-content {
            width: 95%;
            margin: 20px auto;
        }
    }
</style>

<script>
    function showMovieDetail(movieId) {
        fetch('ManageMovie?service=movieDetail&id=' + movieId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok ' + response.statusText);
                }
                return response.json();
            })
            .then(movieDetail => {
                document.getElementById('modalMovieTitle').textContent = movieDetail.title;
                document.getElementById('modalMoviePoster').src = '${pageContext.request.contextPath}' + movieDetail.poster_url;
                document.getElementById('modalMovieDescription').textContent = movieDetail.description;
                document.getElementById('modalMovieAgeRestriction').textContent = movieDetail.age_restriction;
                document.getElementById('modalMovieDirector').textContent = movieDetail.director;
                document.getElementById('modalMovieGenre').textContent = movieDetail.genere_name;
                document.getElementById('modalMovieReleaseDate').textContent = movieDetail.release_date;
                document.getElementById('modalMovieDuration').textContent = movieDetail.duration;
                document.getElementById('modalMovieStatus').textContent = movieDetail.status;
                document.getElementById('modalMovieCreatedAt').textContent = movieDetail.created_at;
                document.getElementById('modalMovieUpdatedAt').textContent = movieDetail.updated_at;
                
                const trailerLink = document.getElementById('modalMovieTrailer');
                if (movieDetail.trailer_url) {
                    trailerLink.href = '${pageContext.request.contextPath}' + movieDetail.trailer_url;
                    trailerLink.style.display = 'inline';
                } else {
                    trailerLink.style.display = 'none';
                }

                document.getElementById('movieDetailModal').style.display = 'block';
            })
            .catch(error => {
                console.error('Error fetching movie details:', error);
                alert('Failed to load movie details. Please try again.');
            });
    }

    // Get the modal
    var modal = document.getElementById("movieDetailModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close-button")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
</html>

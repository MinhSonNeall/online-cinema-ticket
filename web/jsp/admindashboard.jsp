<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.user.role != 'ADMIN'}">
<c:redirect url="/jsp/authenticationFailed.jsp"/>
</c:if>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Staff Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Add Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
.welcome-user {
padding: 20px;
background: rgba(255,255,255,0.1);
border-radius: 8px;
margin: 15px;
text-align: center;
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
/* Enhanced Dashboard Grid */
.dashboard-grid {
display: grid;
grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
gap: 25px;
padding: 10px;
}
.dashboard-card {
background: white;
border-radius: 15px;
padding: 25px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
transition: all 0.3s ease;
position: relative;
overflow: hidden;
}
.dashboard-card::before {
content: '';
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 5px;
background: linear-gradient(to right, #3498db, #2ecc71);
opacity: 0;
transition: opacity 0.3s ease;
}
.dashboard-card:hover::before {
opacity: 1;
}
.dashboard-card:hover {
transform: translateY(-5px);
box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}
.dashboard-card h3 {
color: #2c3e50;
margin-bottom: 15px;
font-size: 20px;
display: flex;
align-items: center;
}
.dashboard-card h3 i {
margin-right: 10px;
color: #3498db;
}
.dashboard-card p {
color: #7f8c8d;
margin-bottom: 20px;
font-size: 15px;
line-height: 1.6;
}
/* Updated card-link styling to match sidebar nav-links */
.card-link {
color: white;
text-decoration: none;
padding: 12px 20px;
display: flex;
align-items: center;
border-radius: 8px;
transition: all 0.3s ease;
background: #3498db;
border: none;
cursor: pointer;
font-weight: 500;
font-size: 15px;
width: 100%;
justify-content: space-between;
}
.card-link i {
margin-left: 8px;
width: 20px;
text-align: center;
}
.card-link:hover {
background: #2980b9;
transform: translateX(5px);
}
/* Form styling for dashboard cards */
.dashboard-card form {
width: 100%;
}
/* Logout Button */
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
.dashboard-grid {
grid-template-columns: 1fr;
}
.header {
flex-direction: column;
text-align: center;
}
}
.error-page {
min-height: 100vh;
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
padding: 20px;
text-align: center;
}
.error-icon {
font-size: 120px;
color: #e74c3c;
margin-bottom: 20px;
animation: bounce 2s ease infinite;
}
@keyframes bounce {
0%, 20%, 50%, 80%, 100% {
transform: translateY(0);
}
40% {
transform: translateY(-30px);
}
60% {
transform: translateY(-15px);
}
}
.error-title {
font-size: 48px;
color: #2c3e50;
margin-bottom: 20px;
font-weight: 700;
}
.error-message {
font-size: 24px;
color: #7f8c8d;
margin-bottom: 30px;
max-width: 600px;
line-height: 1.6;
}
.error-button {
display: inline-flex;
align-items: center;
padding: 15px 30px;
background: #3498db;
color: white;
text-decoration: none;
border-radius: 50px;
font-size: 18px;
transition: all 0.3s ease;
box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}
.error-button:hover {
background: #2980b9;
transform: translateY(-2px);
box-shadow: 0 6px 20px rgba(0,0,0,0.15);
}
.error-button i {
margin-right: 10px;
}

/* Chart container styles */
.chart-container {
background: white;
border-radius: 15px;
padding: 25px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
margin-top: 30px;
margin-bottom: 30px;
}

.chart-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 20px;
}

.chart-header h2 {
color: #2c3e50;
font-size: 22px;
font-weight: 600;
}

.revenue-highlight {
font-size: 24px;
color: #2ecc71;
font-weight: bold;
}

/* Stats cards */
.stats-container {
display: grid;
grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
gap: 25px;
padding: 10px;
margin-bottom: 30px;
}

.stats-card {
background: white;
border-radius: 15px;
padding: 20px;
box-shadow: 0 5px 15px rgba(0,0,0,0.05);
transition: all 0.3s ease;
}

.stats-card h3 {
color: #2c3e50;
margin-bottom: 10px;
font-size: 18px;
display: flex;
align-items: center;
}

.stats-card .value {
font-size: 28px;
font-weight: bold;
color: #3498db;
margin-top: 10px;
}

.stats-card .subtitle {
color: #7f8c8d;
font-size: 14px;
}
</style>
</head>
<body>
<!--  
<div class="error-page">
<i class="fas fa-exclamation-circle error-icon"></i>
<h1 class="error-title">404</h1>
<p class="error-message">Oops! Page not found. It seems you're not authorized to access this page.</p>
<a href="loginCustomer.jsp" class="error-button">
<i class="fas fa-home"></i>
Back to Login
</a>
</div> -->
<div class="container">
<!-- Enhanced Sidebar -->
<div class="sidebar">
<div class="logo">
<h2><i class="fas fa-chart-line"></i> Staff Dashboard</h2>
</div>
<!-- User Info Section -->
<div class="welcome-user">
<i class="fas fa-user-circle" style="font-size: 48px; margin-bottom: 10px;"></i>
<p>Welcome, ${sessionScope.user.full_name}</p>
<div class="profile-dropdown">
<div class="profile-info">
<div class="profile-name">${sessionScope.user.full_name}</div>
<div class="profile-role">${sessionScope.user.role}</div>
<div class="profile-email">${sessionScope.user.email}</div>
</div>
<div class="profile-actions">
<c:url var="logoutUrl" value="/LogoutController"/>
</div>
</div>
</div>
<!-- Management Menu -->
<div class="nav-section">
<div class="nav-title">Management</div>
<ul class="nav-links">
<li><a href="ManageUserAccount"><i class="fas fa-users"></i> User Accounts</a></li>
<li><a href="ManageMovie"><i class="fas fa-film"></i> Movies</a></li>
<li><a href="ManageShowtime"><i class="fas fa-clock"></i> Showtimes</a></li>
<li><a href="ManageRoomSeat"><i class="fas fa-chair"></i> Cinemas</a></li>
</ul>
</div>
<a href="ChangeUserAdminProfile" class="logout-btn">
<i class="fas fa-user-cog"></i> Change Profile
</a>
<c:url var="logoutUrl" value="/LogoutController"/>
<a href="${logoutUrl}" class="logout-btn">
<i class="fas fa-sign-out-alt"></i> Logout
</a>
</div>
<!-- Main Content -->
<div class="main-content">
<div class="header">
<h1><i class="fas fa-tachometer-alt"></i> Staff Management Dashboard</h1>
</div>


<!-- Dashboard Grid -->
<div class="dashboard-grid">
<div class="dashboard-card">
<h3><i class="fas fa-users"></i> User Accounts</h3>
<p>Manage user accounts and permissions.</p>
<form action="ManageUserAccount" method="post">
<button type="submit" class="card-link">
Manage Users <i class="fas fa-arrow-right"></i>
</button>
</form>
</div>
<div class="dashboard-card">
<h3><i class="fas fa-film"></i> Movies</h3>
<p>Manage movie listings and details.</p>
<form action="ManageMovie" method="post">
<button type="submit" class="card-link">
Manage Movies <i class="fas fa-arrow-right"></i>
</button>
</form>
</div>
<div class="dashboard-card">
<h3><i class="fas fa-clock"></i> Showtimes</h3>
<p>Manage movie showtimes and schedules.</p>
<form action="ManageShowtime" method="post">
<button type="submit" class="card-link">
Manage Showtimes <i class="fas fa-arrow-right"></i>
</button>
</form>
</div>
<div class="dashboard-card">
<h3><i class="fas fa-chair"></i> Cinemas</h3>
<p>Manage cinema rooms.</p>
<form action="ManageRoomSeat" method="post">
<button type="submit" class="card-link">
Manage Cinemas <i class="fas fa-arrow-right"></i>
</button>
</form>
</div>
</div>
<!-- Biểu đồ doanh thu và phim đặt vé nhiều nhất -->
<div style="display: flex; gap: 40px; margin-bottom: 40px; flex-wrap: wrap;">
  <div style="flex: 1; min-width: 350px;">
    <h3 style="text-align:center;">Total Revenue</h3>
    <canvas id="revenueChart"></canvas>
  </div>
  <div style="flex: 1; min-width: 350px;">
    <h3 style="text-align:center;">Top Movie</h3>
    <canvas id="movieChart"></canvas>
  </div>
</div>
</div>
</div>
<script>
// Biểu đồ tổng doanh thu
const revenueCtx = document.getElementById('revenueChart').getContext('2d');
const revenueChart = new Chart(revenueCtx, {
    type: 'bar',
    data: {
        labels: ['Total Revenue'],
        datasets: [{
            label: 'Total Ticket Price',
            data: [${totalRevenue}],
            backgroundColor: 'rgba(54, 162, 235, 0.6)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: false }
        },
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) { return 'VND ' + value; }
                }
            }
        }
    }
});
// Biểu đồ top phim đặt vé nhiều nhất
const movieCtx = document.getElementById('movieChart').getContext('2d');
const movieLabels = [
  <c:forEach items="${movieLabels}" var="label" varStatus="status">
    "${label}"<c:if test="${!status.last}">,</c:if>
  </c:forEach>
];
const movieData = [
  <c:forEach items="${movieData}" var="data" varStatus="status">
    ${data}<c:if test="${!status.last}">,</c:if>
  </c:forEach>
];
const movieChart = new Chart(movieCtx, {
    type: 'pie',
    data: {
        labels: movieLabels,
        datasets: [{
            label: 'Total Ticket',
            data: movieData,
            backgroundColor: [
                'rgba(255, 99, 132, 0.6)',
                'rgba(54, 162, 235, 0.6)',
                'rgba(255, 206, 86, 0.6)',
                'rgba(75, 192, 192, 0.6)',
                'rgba(153, 102, 255, 0.6)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { position: 'right' },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        let label = context.label || '';
                        if (label) label += ': ';
                        label += context.raw + ' tickets';
                        return label;
                    }
                }
            }
        }
    }
});
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlex - Đặt vé xem phim</title>
    <style>
        :root {
    --primary-color: #ff6b6b;
    --secondary-color: #ffa500;
    --dark-bg: #0f0f23;
    --dark-card: #1a1a2e;
    --accent-bg: #16213e;
    --glass-bg: rgba(255, 255, 255, 0.05);
    --glass-border: rgba(255, 255, 255, 0.1);
    --text-primary: #ffffff;
    --text-secondary: rgba(255, 255, 255, 0.8);
    --shadow-primary: 0 8px 32px rgba(0, 0, 0, 0.3);
    --shadow-glow: 0 8px 25px rgba(255, 107, 107, 0.3);
    --border-radius: 16px;
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    background: linear-gradient(135deg, var(--dark-bg) 0%, var(--dark-card) 50%, var(--accent-bg) 100%);
    color: var(--text-primary);
    min-height: 100vh;
    line-height: 1.6;
}

/* Header Styles */
.header {
    background: rgba(0, 0, 0, 0.9);
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--glass-border);
    position: sticky;
    top: 0;
    z-index: 100;
}

.main-content {
    margin-top: 80px;
    min-height: calc(100vh - 160px);
}

.logo {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--primary-color);
    text-decoration: none;
}

.logo::before {
    content: "🎬";
    font-size: 2.2rem;
    filter: drop-shadow(0 0 10px var(--primary-color));
}

.nav-menu {
    display: flex;
    gap: 1.5rem;
    list-style: none;
}

.nav-menu a {
    color: var(--text-primary);
    text-decoration: none;
    padding: 0.5rem 1rem;
    border-radius: 12px;
    transition: var(--transition);
    font-weight: 500;
    position: relative;
}

.nav-menu a::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    border-radius: 12px;
    opacity: 0;
    transition: var(--transition);
    z-index: -1;
}

.nav-menu a:hover::before {
    opacity: 0.2;
}

.nav-menu a:hover {
    color: var(--primary-color);
    transform: translateY(-2px);
}

.user-profile {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.5rem 1.25rem;
    background: var(--glass-bg);
    border: 2px solid var(--primary-color);
    border-radius: 50px;
    cursor: pointer;
    transition: var(--transition);
    backdrop-filter: blur(10px);
}

.user-profile:hover {
    background: rgba(255, 107, 107, 0.1);
    transform: translateY(-2px);
    box-shadow: var(--shadow-glow);
}

/* Main Container */
.container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Section Base Styles */
.section {
    background: var (--glass-bg);
    border-radius: var(--border-radius);
    padding: 1.5rem;
    margin-bottom: 1.5rem;
    backdrop-filter: blur(20px);
    border: 1px solid var(--glass-border);
    box-shadow: var(--shadow-primary);
}

.section-title {
    font-size: 1.5rem;
    margin-bottom: 1.25rem;
    color: var(--primary-color);
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

/* Date Selector */
.date-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(90px, 1fr));
    gap: 0.75rem;
}

.date-item {
    background: var(--glass-bg);
    border: 2px solid transparent;
    border-radius: 12px;
    padding: 1rem 0.5rem;
    text-align: center;
    cursor: pointer;
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.date-item::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    opacity: 0;
    transition: var(--transition);
}

.date-item:hover::before,
.date-item.active::before {
    opacity: 1;
}

.date-item:hover,
.date-item.active {
    border-color: transparent;
    transform: translateY(-4px);
    box-shadow: var(--shadow-glow);
}

.date-item > * {
    position: relative;
    z-index: 1;
}

.date-num {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 0.25rem;
    color: var(--text-primary);
}

.date-day {
    font-size: 0.85rem;
    opacity: 0.9;
    font-weight: 500;
    color: var(--text-secondary);
}

/* Location Selector */
.location-tabs {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
}

.location-tab {
    padding: 0.75rem 1.5rem;
    background: var(--glass-bg);
    border: 2px solid transparent;
    border-radius: 50px;
    color: var(--text-primary);
    cursor: pointer;
    transition: var(--transition);
    font-weight: 600;
    font-size: 0.95rem;
    position: relative;
    overflow: hidden;
}

.location-tab::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    opacity: 0;
    transition: var(--transition);
}

.location-tab:hover::before,
.location-tab.active::before {
    opacity: 1;
}

.location-tab:hover,
.location-tab.active {
    transform: translateY(-3px);
    box-shadow: var(--shadow-glow);
    color: white;
}

.location-tab > * {
    position: relative;
    z-index: 1;
}

/* Showtime Selector */
.showtime-container {
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
}

movie-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 20px;
}

.movie-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    max-width: 250px; /* Giới hạn kích thước tối đa */
}

.movie-poster {
    width: 100%;
    height: 300px;
    object-fit: fill;         
    object-position: center;   
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
    display: block;
}
.movie-info {
    padding: 15px;
    height: 120px; /* Chiều cao cố định cho phần thông tin */
    overflow: hidden;
}

.movie-title {
    font-size: 1.4rem;
    font-weight: 700;
    color: var(--primary-color);
    margin-bottom: 0.75rem;
}

.movie-details {
    margin-bottom: 0.4rem;
    color: var(--text-secondary);
    font-size: 0.9rem;
}

.trailer-video {
    max-width: 100%;
}

.cinema-showtimes {
    flex: 1;
    min-width: 300px;
}

.cinema-name {
    font-size: 1.1rem;
    color: var(--primary-color);
    margin-bottom: 1.25rem;
    font-weight: 600;
}

.showtime-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
    gap: 0.75rem;
}

.showtime-btn {
    background: var(--glass-bg);
    border: 2px solid var(--glass-border);
    border-radius: 12px;
    padding: 0.75rem;
    color: var(--text-primary);
    cursor: pointer;
    transition: var(--transition);
    text-align: center;
    position: relative;
    overflow: hidden;
}

.showtime-btn::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    opacity: 0;
    transition: var(--transition);
}

.showtime-btn:hover:not(:disabled)::before,
.showtime-btn.active::before {
    opacity: 1;
}

.showtime-btn:hover:not(:disabled),
.showtime-btn.active {
    border-color: transparent;
    transform: translateY(-3px);
    box-shadow: var(--shadow-glow);
}

.showtime-btn > * {
    position: relative;
    z-index: 1;
}

.showtime-btn .time {
    font-size: 1.1rem;
    font-weight: 700;
    margin-bottom: 0.4rem;
}

.showtime-btn .price {
    font-size: 0.9rem;
    font-weight: 600;
    color: var(--secondary-color);
    margin-bottom: 0.2rem;
}

.showtime-btn.active .price {
    color: white;
}

.showtime-btn .seats-left {
    font-size: 0.75rem;
    opacity: 0.8;
}

.showtime-btn.sold-out {
    opacity: 0.5;
    cursor: not-allowed;
}

.showtime-btn.sold-out .price {
    color: #999;
}

/* Cinema Showtime Info */
.cinema-showtime-info {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-bottom: 1.5rem;
    padding: 0.75rem;
    background: var(--glass-bg);
    border-radius: 12px;
    flex-wrap: wrap;
}

.cinema-name-display,
.showtime-display {
    font-weight: 600;
    font-size: 1rem;
}

#selectedShowtime {
    color: var(--primary-color);
}

/* Seat Selection */
.seat-selection {
    text-align: center;
}

.seat-selection .section-title {
    font-size: 1.75rem;
    justify-content: center;
    margin-bottom: 1.5rem;
}

.seat-info {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
}

.seat-legend {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.85rem;
}

.legend-seat {
    width: 18px;
    height: 18px;
    border-radius: 6px;
    border: 2px solid;
}

.legend-available { background: var(--glass-bg); border-color: var(--glass-border); }
.legend-selected { background: var(--primary-color); border-color: var(--primary-color); }
.legend-booked { background: #666; border-color: #666; }

.seat-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(45px, 1fr));
    gap: 0.5rem;
    margin: 1.5rem 0;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
}

.seat {
    aspect-ratio: 1;
    background: var(--glass-bg);
    border: 2px solid var(--glass-border);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: var(--transition);
    font-weight: 600;
    font-size: 0.85rem;
    position: relative;
}

.seat:hover:not(.booked) {
    background: rgba(255, 107, 107, 0.2);
    border-color: var(--primary-color);
    transform: scale(1.1);
}

.seat.selected {
    background: var(--primary-color);
    border-color: var(--primary-color);
    color: white;
    transform: scale(1.05);
    box-shadow: var(--shadow-glow);
}

.seat.booked {
    background: #666;
    border-color: #666;
    cursor: not-allowed;
    opacity: 0.6;
}

/* Booking Form */
.booking-form {
    background: var(--glass-bg);
    border-radius: var(--border-radius);
    padding: 1.5rem;
    margin-top: 1.5rem;
    text-align: center;
}

.booking-summary {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.booking-btn {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    border: none;
    border-radius: 50px;
    padding: 0.75rem 2rem;
    color: white;
    font-size: 1rem;
    font-weight: 700;
    cursor: pointer;
    transition: var(--transition);
    text-transform: uppercase;
    letter-spacing: 1px;
}

.booking-btn:hover {
    transform: translateY(-3px);
    box-shadow: var(--shadow-glow);
}

.booking-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    transform: none;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .container {
        padding: 1rem;
    }
    
    .section {
        padding: 1rem;
    }
}

@media (max-width: 768px) {
    .header {
        padding: 0.75rem;
    }
    
    .nav-menu {
        display: none;
    }
    
    .container {
        padding: 0.75rem;
    }
    
    .section {
        padding: 0.75rem;
    }
    
    .date-grid {
        grid-template-columns: repeat(auto-fit, minmax(70px, 1fr));
    }
    
    .seat-grid {
        grid-template-columns: repeat(auto-fit, minmax(35px, 1fr));
        gap: 0.4rem;
    }
    
    .booking-summary {
        flex-direction: column;
        text-align: center;
    }
    
    .seat-info {
        flex-direction: column;
        gap: 0.75rem;
    }

    .showtime-container {
        flex-direction: column;
    }

    .movie-card {
        min-width: auto;
    }

    .cinema-showtimes {
        min-width: auto;
    }

    .showtime-grid {
        grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
    }

    .cinema-showtime-info {
        flex-direction: column;
        gap: 0.75rem;
        text-align: center;
    }
}

@media (max-width: 480px) {
    .logo {
        font-size: 1.4rem;
    }
    
    .section-title {
        font-size: 1.2rem;
    }
    
    .seat-selection .section-title {
        font-size: 1.4rem;
    }

    .date-num {
        font-size: 1.2rem;
    }

    .date-day {
        font-size: 0.75rem;
    }

    .location-tab {
        padding: 0.5rem 1rem;
        font-size: 0.85rem;
    }
}

/* Animation */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.section {
    animation: fadeInUp 0.6s ease-out;
}

.section:nth-child(2) { animation-delay: 0.1s; }
.section:nth-child(3) { animation-delay: 0.2s; }
.section:nth-child(4) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    <!-- Header -->
    <%@ include file="../navigator/header.jsp" %>
    <main class="main-content">
        <div class="container">
        <!-- Date Selector -->
        <section class="section">
            <h3 class="section-title">📅 Chọn ngày chiếu</h3>
            <div class="date-grid">
                <c:forEach var="date" items="${dateListTesst}">
                    <a href="${pageContext.request.contextPath}/ListMovieDetailController?movieId=${movieId}&selectedDate=${date.fullDate}"
                       class="date-item ${date.active ? 'active' : ''}">
                        <div class="date-num">${date.day}</div>
                        <div class="date-day">${date.dayName}</div>
                    </a>
                </c:forEach>
            </div>
        </section>

        <!-- Location Selector -->
        <section class="section">
            <h3 class="section-title">📍 Chọn địa điểm</h3>
            <div class="location-tabs" id="locationTabs">
                <c:choose>
                    <c:when test="${not empty locationList}">
                        <c:forEach var="location" items="${locationList}">
                            <button class="location-tab ${location.active ? 'active' : ''}">
                                ${location.name}
                            </button>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>Không có rạp chiếu cho ngày này</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Showtime Selector -->
        <section class="section">
            <h3 class="section-title">🕐 Chọn suất chiếu</h3>
            <div class="showtime-container">
                <div class="movie-card">
                    <div class="movie-poster">
                        <img src="${pageContext.request.contextPath}${poster}" alt="${movieTitle}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;">
                    </div>
                    <div class="movie-info">
                        <h4 class="movie-title">Chi tiết: ${movieTitle != null ? movieTitle : 'Avengers: Endgame'}</h4>
                        <p class="movie-details">Thể loại: Hành động, Khoa học viễn tưởng</p>
                        <p class="movie-details">Thời lượng: ${movieDuration != null ? movieDuration : '1'}</p>
                        <p class="movie-details">Độ tuổi: ${movieAge != null ? movieAge : '1'}</p>
                    </div>
                </div>
                
                <div class="cinema-showtimes">
                    <h5 class="cinema-name">🏢 CGV Bắc Giang</h5>
                    <div class="showtime-grid">
                        <c:forEach var="showtime" items="${showtimeList}">
                            <button class="showtime-btn active"}" 
                                    data-time="${showtime.time}" 
                                    data-price="${showtime.ticketPrice}">
                                <div class="time">${showtime.time}</div>
                                <div class="price">${showtime.ticketPrice}đ</div>
                                <div class="seats-left">${showtime.remainingSeats} ghế trống</div>
                            </button>
                        </c:forEach>
                        <!-- Static example -->
                        <button class="showtime-btn" data-time="14:30" data-price="120000">
                            <div class="time">14:30</div>
                            <div class="price">120.000đ</div>
                            <div class="seats-left">28 ghế trống</div>
                        </button>
                        <button class="showtime-btn" data-time="17:15" data-price="140000">
                            <div class="time">17:15</div>
                            <div class="price">140.000đ</div>
                            <div class="seats-left">15 ghế trống</div>
                        </button>
                        <button class="showtime-btn" data-time="20:00" data-price="160000">
                            <div class="time">20:00</div>
                            <div class="price">160.000đ</div>
                            <div class="seats-left">22 ghế trống</div>
                        </button>
                        <button class="showtime-btn" data-time="22:45" data-price="140000">
                            <div class="time">22:45</div>
                            <div class="price">140.000đ</div>
                            <div class="seats-left">31 ghế trống</div>
                        </button>
                        <button class="showtime-btn sold-out" disabled>
                            <div class="time">19:30</div>
                            <div class="price">160.000đ</div>
                            <div class="seats-left">Hết vé</div>
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Seat Selection Section -->
        <section class="section seat-selection">
            <h2 class="section-title">🎭 Chọn ghế</h2>
            <div class="cinema-showtime-info">
                <span class="cinema-name-display">📍 CGV Hùng Vương Plaza</span>
                <span class="showtime-display">🕐 Suất chiếu: <span id="selectedShowtime">14:30</span></span>
            </div>
            
            <!-- Seat Legend -->
            <div class="seat-info">
                <div class="seat-legend">
                    <div class="legend-seat legend-available"></div>
                    <span>Có thể chọn</span>
                </div>
                <div class="seat-legend">
                    <div class="legend-seat legend-selected"></div>
                    <span>Đã chọn</span>
                </div>
                <div class="seat-legend">
                    <div class="legend-seat legend-booked"></div>
                    <span>Đã đặt</span>
                </div>
            </div>

            <p style="margin-bottom: 1rem;"><strong>Tổng số ghế còn lại:</strong> ${remainingSeats != null ? remainingSeats : '24'}</p>
            
            <div class="seat-grid">
                <c:forEach var="seat" items="${seatList}">
                    <div class="seat ${seat.booked ? 'booked' : ''} ${seat.selected ? 'selected' : ''}">
                        ${seat.name}
                    </div>
                </c:forEach>
                <!-- Static example -->
                <div class="seat">A1</div>
                <div class="seat">A2</div>
                <div class="seat booked">A3</div>
                <div class="seat">A4</div>
                <div class="seat">A5</div>
                <div class="seat">A6</div>
                <div class="seat">A7</div>
                <div class="seat">A8</div>
                <div class="seat">B1</div>
                <div class="seat">B2</div>
                <div class="seat booked">B3</div>
                <div class="seat">B4</div>
                <div class="seat">B5</div>
                <div class="seat">B6</div>
                <div class="seat">B7</div>
                <div class="seat">B8</div>
                <div class="seat">C1</div>
                <div class="seat">C2</div>
                <div class="seat">C3</div>
                <div class="seat">C4</div>
                <div class="seat booked">C5</div>
                <div class="seat">C6</div>
                <div class="seat">C7</div>
                <div class="seat">C8</div>
                <div class="seat">D1</div>
                <div class="seat">D2</div>
                <div class="seat">D3</div>
                <div class="seat">D4</div>
                <div class="seat">D5</div>
                <div class="seat">D6</div>
                <div class="seat">D7</div>
                <div class="seat">D8</div>
            </div>

            <!-- Booking Form -->
            <form class="booking-form" action="bookTicket" method="post">
                <div class="booking-summary">
                    <div>
                        <strong>Ghế đã chọn:</strong> <span id="selectedSeatsDisplay">Chưa chọn ghế</span>
                    </div>
                    <div class="booking-total">
                        <strong>Tổng tiền:</strong> <span style="color: var(--primary-color); font-size: 1.2rem;">0 VNĐ</span>
                    </div>
                </div>
                
                <input type="hidden" name="movieId" value="${movieId}">
                <input type="hidden" name="cinemaName" value="CGV Hùng Vương Plaza">
                <input type="hidden" name="selectedSeats" value="${selectedSeats}">
                <button type="submit" class="booking-btn">Đặt vé ngay</button>
            </form>
        </section>
    </div></main>
    
                
    <%@ include file="../navigator/footer.jsp" %>

    <script>
        // Simple seat selection interaction
        document.querySelectorAll('.seat:not(.booked)').forEach(seat => {
            seat.addEventListener('click', function() {
                this.classList.toggle('selected');
                updateSelectedSeats();
            });
        });

        // Date selection
        document.querySelectorAll('.date-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.date-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Location selection
        document.querySelectorAll('.location-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.location-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Showtime selection
        document.querySelectorAll('.showtime-btn:not(:disabled)').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.showtime-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                const selectedTime = this.dataset.time;
                const selectedPrice = this.dataset.price;
                
                document.getElementById('selectedShowtime').textContent = selectedTime;
                updateTotalPrice();
            });
        });

        function updateSelectedSeats() {
            const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
                .map(seat => seat.textContent.trim());
            document.getElementById('selectedSeatsDisplay').textContent = 
                selectedSeats.length > 0 ? selectedSeats.join(', ') : 'Chưa chọn ghế';
            updateTotalPrice();
        }

        function updateTotalPrice() {
            const selectedSeats = document.querySelectorAll('.seat.selected').length;
            const activeShowtime = document.querySelector('.showtime-btn.active');
            
            if (selectedSeats > 0 && activeShowtime) {
                const pricePerSeat = parseInt(activeShowtime.dataset.price);
                const totalPrice = selectedSeats * pricePerSeat;
                
                document.querySelector('.booking-summary .booking-total').innerHTML = 
                    `<strong>Tổng tiền:</strong> <span style="color: var(--primary-color); font-size: 1.2rem;">${totalPrice.toLocaleString('vi-VN')} VNĐ</span>`;
            } else {
                document.querySelector('.booking-summary .booking-total').innerHTML = 
                    `<strong>Tổng tiền:</strong> <span style="color: var(--primary-color); font-size: 1.2rem;">0 VNĐ</span>`;
            }
        }
    </script>
</body>
</html>
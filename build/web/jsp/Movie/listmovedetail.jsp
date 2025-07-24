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

            .date-grid a {
                text-decoration: none;
            }

            .date-item a {
                text-decoration: none;
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
                color:  #ff6b35 !important;
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

            .legend-available {
                background: var(--glass-bg);
                border-color: var(--glass-border);
            }
            .legend-selected {
                background: var(--primary-color);
                border-color: var(--primary-color);
            }
            .legend-booked {
                background: #666;
                border-color: #666;
            }

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

            .seat input[type="checkbox"]:checked + span,
            .seat input[type="checkbox"]:checked {
                background: var(--primary-color);
                color: white;
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

            .section:nth-child(2) {
                animation-delay: 0.1s;
            }
            .section:nth-child(3) {
                animation-delay: 0.2s;
            }
            .section:nth-child(4) {
                animation-delay: 0.3s;
            }
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

                <section class="section">
                    <h3 class="section-title">🏙️ Chọn thành phố</h3>
                    <div class="location-tabs" id="cityTabs">
                        <c:choose>
                            <c:when test="${not empty locationList}">
                                <c:forEach var="location" items="${locationList}">
                                    <a href="${pageContext.request.contextPath}/ListMovieDetailController?movieId=${movieId}&cityName=${location.name}&selectedDate=${selectedDate}" 
                                       class="location-tab ${location.active ? 'active' : ''}">
                                        ${location.name}
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có rạp chiếu cho ngày này</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <!-- Location Selector -->
                <section class="section">
                    <h3 class="section-title">📍 Chọn địa điểm</h3>
                    <div class="location-tabs" id="locationTabs">
                        <c:choose>
                            <c:when test="${not empty listCinema}">
                                <c:forEach var="cinema" items="${listCinema}">
                                    <a href="${pageContext.request.contextPath}/ListMovieDetailController?movieId=${movieId}&selectedDate=${selectedDate}&cityName=${cinema.city}&room_id=${cinema.cinema_id}" 
                                       class="location-tab">
                                        ${cinema.name}
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có rạp chiếu phim ở thành phố này</p>
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
                                <h4 class="movie-title">${movieTitle != null ? movieTitle : 'Avengers: Endgame'}</h4>
                                <p class="movie-details">Thể loại: Hành động, Khoa học viễn tưởng</p>
                                <p class="movie-details">Thời lượng: ${movieDuration != null ? movieDuration : '1'}</p>
                                <p class="movie-details">Độ tuổi: ${movieAge != null ? movieAge : '1'}</p>
                            </div>
                        </div>

                        <div class="cinema-showtimes">
                            <div class="showtime-grid">
                                <c:forEach var="showtime" items="${showtimeListOf}">
                                    <a href="${pageContext.request.contextPath}/ListMovieDetailController?movieId=${movieId}&selectedDate=${selectedDate}&cityName=${showtime.city}&room_id=${showtime.room_id}&slot_id=${showtime.slot_id}" class="showtime-btn active" 
                                       data-time="${showtime.start_time}">
                                        <div class="time">${showtime.start_time} - ${showtime.end_time}</div>
                                        <div class="price">${showtime.price}đ</div>
                                        <div class="seats-left">${showtime.seat_avaiable} ghế trống</div>
                                    </a>
                                </c:forEach>
                                <!-- Static example -->
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Seat Selection Section -->
                <section class="section seat-selection">
                    <h2 class="section-title">🎭 Chọn ghế</h2>
                    <div class="cinema-showtime-info">
                        <span class="cinema-name-display">📍 ${infomationMovie.name}</span>
                        <span class="showtime-display">🕐 Suất chiếu: <span id="selectedShowtime">${infomationMovie.start_time} - ${infomationMovie.end_time}</span></span>
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

                    <p style="margin-bottom: 1rem;"><strong>Tổng số ghế còn lại:</strong> ${infomationMovie.avaiable_seat != null ? infomationMovie.avaiable_seat : 'Vui lòng chọn rạp xem phim'}</p>

                    <div class="seat-grid">
                        <c:forEach var="seat" items="${showSeatList}">
                            <div class="seat ${seat.check_seat == 1 ? 'booked' : ''}"
                                 data-price="${seat.price != null ? seat.price : 0}"
                                 data-seat-id="${seat.seat_id}">
                                ${seat.seat_number}
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Booking Form -->
                    <form class="booking-form" action="InformationTicketController" method="post">
                        <div class="booking-summary">
                            <div>
                                <strong>Ghế đã chọn:</strong> <span id="selectedSeatsDisplay">Chưa chọn ghế</span>
                            </div>
                            <div class="booking-total">
                                <strong>Tổng tiền:</strong> 
                                <span id="totalPriceDisplay" style="color: var(--primary-color); font-size: 1.2rem;">
                                    <span id="priceValue">0</span> VNĐ
                                </span>
                                </span>
                            </div>

                        </div>

                        <!-- SỬA: Các input hidden cơ bản (đã có, nhưng cập nhật selectedSeats động bằng JS) -->
                        <input type="hidden" name="movieId" value="${movieId}">
                        <input type="hidden" name="selectedSeats" id="selectedSeatsInput" value="">  <!-- SỬA: Thêm id để JS dễ set, value ban đầu empty -->

                        <!-- SỬA: Thêm hidden cho các thông tin động từ server -->
                        <input type="hidden" name="movieTitle" value="${movieTitle != null ? movieTitle : 'Avengers: Endgame'}">  <!-- Tên phim -->
                        <input type="hidden" name="cinemaName" value="${infomationMovie.name != null ? infomationMovie.name : 'CGV Hùng Vương Plaza'}">  <!-- Tên rạp động, thay hardcoded -->
                        <input type="hidden" name="showtime" id="showtimeInput" value="${infomationMovie.start_time} - ${infomationMovie.end_time}">  <!-- Thời gian chiếu, thêm id để JS sync nếu cần -->
                        <input type="hidden" name="selectedDate" value="${selectedDate}">  <!-- Ngày chiếu -->
<!--                        <input type="hidden" name="room_id" value="${room_id != null ? room_id : infomationMovie.showtime_id}">   Room ID (giả định từ param hoặc infomationMovie) -->
                        <input type="hidden" name="slot_id" value="${slot_id != null ? slot_id : infomationMovie.showtime_id}">  <!-- Slot ID (giả định từ param hoặc infomationMovie) -->
<input type="hidden" name="showtimeid" value="${infomationMovie.showtime_id}">
                        <!-- SỬA: Thêm hidden cho tổng giá tiền, sẽ cập nhật bằng JS -->
                        <input type="hidden" name="totalPrice" id="totalPriceInput" value="0">
                        <button type="submit" class="booking-btn">Đặt vé ngay</button>
                    </form>
                </section>
            </div></main>


        <%@ include file="../navigator/footer.jsp" %>

        <script>
            // Simple seat selection interaction
            document.querySelectorAll('.seat:not(.booked)').forEach(seat => {
                seat.addEventListener('click', function () {
                    this.classList.toggle('selected');
                    updateSelectedSeats();
                });
            });

            // Date selection
            document.querySelectorAll('.date-item').forEach(item => {
                item.addEventListener('click', function () {
                    document.querySelectorAll('.date-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Location selection
            document.querySelectorAll('.location-tab').forEach(tab => {
                tab.addEventListener('click', function () {
                    document.querySelectorAll('.location-tab').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            function updateSelectedSeats() {
                const selectedSeats = document.querySelectorAll('.seat.selected');
                // Hiển thị seat_number cho người dùng
                const seatNumbers = Array.from(selectedSeats).map(seat => seat.textContent.trim());
                document.getElementById('selectedSeatsDisplay').textContent =
                        seatNumbers.length > 0 ? seatNumbers.join(', ') : 'Chưa chọn ghế';
                
                // Gửi seat_id lên server
                const seatIds = Array.from(selectedSeats).map(seat => seat.getAttribute('data-seat-id'));
                document.querySelector('input[name="selectedSeats"]').value = seatIds.join(',');
                
                updateTotalPrice();
            }

            function updateTotalPrice() {
                const selectedSeats = document.querySelectorAll('.seat.selected');
                let totalPrice = 0;
                selectedSeats.forEach(seat => {
                    const raw = seat.getAttribute('data-price');
                    const price = parseFloat(raw?.trim());
                    if (!isNaN(price)) {
                        totalPrice += price;
                    }
                });
                const priceSpan = document.getElementById('priceValue');
                if (priceSpan) {
                    priceSpan.textContent = totalPrice.toLocaleString('vi-VN');
                }
                document.getElementById('totalPriceInput').value = totalPrice;
            }

            document.addEventListener('DOMContentLoaded', function () {
                updateSelectedSeats();
            });
        </script>


    </body>
</html>
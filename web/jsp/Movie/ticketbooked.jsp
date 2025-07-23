
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CinePlex - Vé Đã Thanh Toán</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                color: #333;
                background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
                min-height: 100vh;
            }

            /* Header */
            .header {
                background: rgba(0, 0, 0, 0.3);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                padding: 1rem 0;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 1.5rem;
                font-weight: bold;
                color: #fff;
                text-decoration: none;
            }

            .logo::before {
                content: '🎬';
                font-size: 1.8rem;
            }

            .nav-links {
                display: flex;
                gap: 2rem;
                list-style: none;
            }

            .nav-links a {
                color: #ccc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .nav-links a:hover {
                color: #fff;
            }

            /* Main Content */
            .main-content {
                margin-top: 80px;
                padding: 2rem;
                min-height: calc(100vh - 80px);
            }

            .page-header {
                text-align: center;
                margin-bottom: 3rem;
            }

            .page-title {
                font-size: 2.5rem;
                color: #fff;
                margin-bottom: 1rem;
                background: linear-gradient(45deg, #ff6b6b, #feca57, #48dbfb);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .page-subtitle {
                color: #aaa;
                font-size: 1.1rem;
            }

            /* Tickets Container */
            .tickets-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .tickets-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
                gap: 2rem;
            }

            /* Ticket Card */
            .ticket-card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                overflow: hidden;
                transition: all 0.3s ease;
                position: relative;
                animation: fadeInUp 0.6s ease forwards;
            }

            .ticket-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(255, 107, 107, 0.2);
                border-color: rgba(255, 107, 107, 0.3);
            }

            .ticket-header {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                padding: 1.5rem;
                position: relative;
            }

            .ticket-header::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 20px;
                height: 20px;
                background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
                border-radius: 50%;
                border: 2px solid #ff6b6b;
            }

            .ticket-status {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                background: rgba(255, 255, 255, 0.2);
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: bold;
                color: #fff;
                margin-bottom: 1rem;
            }

            .ticket-status::before {
                content: '✓';
                background: #fff;
                color: #ff6b6b;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.8rem;
            }

            .movie-title {
                font-size: 1.3rem;
                font-weight: bold;
                color: #fff;
                margin-bottom: 0.5rem;
            }

            .movie-genre {
                color: rgba(255, 255, 255, 0.8);
                font-size: 0.9rem;
            }

            .ticket-body {
                padding: 1.5rem;
            }

            .ticket-info {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .info-item {
                display: flex;
                flex-direction: column;
            }

            .info-label {
                color: #aaa;
                font-size: 0.8rem;
                margin-bottom: 0.25rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                color: #fff;
                font-weight: bold;
                font-size: 1rem;
            }

            .seat-info {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 12px;
                padding: 1rem;
                margin-bottom: 1.5rem;
            }

            .seat-label {
                color: #aaa;
                font-size: 0.8rem;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .seat-numbers {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
            }

            .seat-number {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: #fff;
                padding: 0.3rem 0.8rem;
                border-radius: 15px;
                font-size: 0.9rem;
                font-weight: bold;
            }

            .ticket-footer {
                border-top: 1px dashed rgba(255, 255, 255, 0.2);
                padding: 1rem 1.5rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .total-price {
                font-size: 1.2rem;
                font-weight: bold;
                color: #feca57;
            }

            .ticket-id {
                font-size: 0.8rem;
                color: #aaa;
                font-family: monospace;
            }

            .qr-code {
                width: 60px;
                height: 60px;
                background: linear-gradient(45deg, #333, #666);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 0.7rem;
                text-align: center;
                line-height: 1.2;
            }

            /* Actions */
            .ticket-actions {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
            }

            .action-btn {
                flex: 1;
                padding: 0.8rem 1rem;
                border: none;
                border-radius: 10px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.9rem;
            }

            .download-btn {
                background: rgba(255, 255, 255, 0.1);
                color: #fff;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .download-btn:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateY(-2px);
            }

            .share-btn {
                background: linear-gradient(45deg, #48dbfb, #0abde3);
                color: #fff;
            }

            .share-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(72, 219, 251, 0.3);
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                color: #aaa;
            }

            .empty-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }

            .empty-title {
                font-size: 1.5rem;
                margin-bottom: 1rem;
                color: #fff;
            }

            .empty-desc {
                margin-bottom: 2rem;
                line-height: 1.6;
            }

            .back-btn {
                display: inline-block;
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: #fff;
                padding: 1rem 2rem;
                text-decoration: none;
                border-radius: 25px;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 25px rgba(255, 107, 107, 0.4);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .tickets-grid {
                    grid-template-columns: 1fr;
                    gap: 1.5rem;
                }

                .ticket-info {
                    grid-template-columns: 1fr;
                }

                .ticket-footer {
                    flex-direction: column;
                    gap: 1rem;
                    text-align: center;
                }

                .nav-links {
                    display: none;
                }

                .page-title {
                    font-size: 2rem;
                }
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .ticket-card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .ticket-card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .ticket-card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .ticket-card:nth-child(4) {
                animation-delay: 0.4s;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@ include file="../navigator/header.jsp" %>


        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Vé Đã Thanh Toán</h1>
                <p class="page-subtitle">Quản lý và xem thông tin các vé phim của bạn</p>
            </div>

            <div class="tickets-container">
                <div class="tickets-grid">
                    <!-- Ticket 1 -->
                    <c:choose>
                        <c:when test="${not empty tickets}">
                            <c:forEach var="ticket" items="${tickets}">
                                <div class="ticket-card">
                                    <div class="ticket-header">
                                        <div class="ticket-status">
                                            Đã thanh toán
                                        </div>
                                        <h3 class="movie-title">${ticket.movieTitle}</h3>
                                        <p class="movie-genre">Phim chiếu rạp</p>
                                    </div>
                                    <div class="ticket-body">
                                        <div class="ticket-info">
                                            <div class="info-item">
                                                <span class="info-label">Rạp chiếu</span>
                                                <span class="info-value">${ticket.cinemaName}</span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Phòng chiếu</span>
                                                <span class="info-value">${ticket.roomName}</span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Ngày chiếu</span>
                                                <span class="info-value">${ticket.showDate}</span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Giờ chiếu</span>
                                                <span class="info-value">${ticket.startTime} - ${ticket.endTime}</span>
                                            </div>
                                        </div>

                                        <div class="seat-info">
                                            <div class="seat-label">Ghế đã đặt</div>
                                            <div class="seat-numbers">
                                                <c:forEach var="seat" items="${ticket.seat_ids}">
                                                    <span class="seat-number">${seat}</span>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="ticket-actions">
                                            <button class="action-btn download-btn">Tải xuống</button>
                                            <button class="action-btn share-btn">Chia sẻ</button>
                                        </div>
                                    </div>
                                    <div class="ticket-footer">
                                        <div>
                                            <div class="total-price">${ticket.total_amount} VNĐ</div>
                                            <div class="ticket-id">ID: ${ticket.ticket_id}</div>
                                        </div>
                                        <div class="qr-code">
                                            QR<br>Code
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">🎟️</div>
                                <div class="empty-title">Bạn chưa có vé nào</div>
                                <div class="empty-desc">Hãy đặt vé để bắt đầu trải nghiệm phim tại CinePlex.</div>
                                <a href="/home" class="back-btn">Quay về trang chủ</a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </main>

        <%@ include file="../navigator/footer.jsp" %>


        <script>
            // Add click events for buttons
            document.querySelectorAll('.download-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    alert('Đang tải xuống vé...');
                });
            });

            document.querySelectorAll('.share-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    alert('Chia sẻ vé thành công!');
                });
            });

            // Add hover effects
            document.querySelectorAll('.ticket-card').forEach(card => {
                card.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-5px)';
                });

                card.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0)';
                });
            });
        </script>
    </body>

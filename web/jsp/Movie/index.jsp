<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlex - Đặt vé xem phim online</title>
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

        /* Main Content */
        .main-content {
            margin-top: 80px;
            min-height: calc(100vh - 160px);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><rect fill="%23000" width="1200" height="600"/><circle fill="%23ff6b6b" opacity="0.1" cx="300" cy="150" r="100"/><circle fill="%23feca57" opacity="0.1" cx="900" cy="450" r="150"/><rect fill="%23333" opacity="0.3" x="0" y="0" width="1200" height="1"/></svg>');
            background-size: cover;
            background-position: center;
            padding: 6rem 2rem;
            text-align: center;
            color: #fff;
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ff6b6b, #feca57, #48dbfb);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradient 3s ease-in-out infinite;
        }

        @keyframes gradient {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .cta-btn {
            display: inline-block;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            color: #fff;
            padding: 1rem 2rem;
            text-decoration: none;
            border-radius: 50px;
            font_Reality_Hyperweight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 107, 107, 0.4);
        }

        /* Movies Section */
        .movies-section {
            padding: 4rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            color: #fff;
            margin-bottom: 3rem;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            border-radius: 2px;
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .movie-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            height: fit-content;
        }

        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 107, 107, 0.2);
            border-color: rgba(255, 107, 107, 0.3);
        }

        .movie-poster {
            width: 100%;
            height: 300px;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .movie-info {
            padding: 1.5rem;
        }

        .movie-title {
            color: #fff;
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .movie-genre {
            color: #aaa;
            margin-bottom: 1rem;
        }

        .movie-rating {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .stars {
            color: #feca57;
        }

        .movie-details {
            margin-bottom: 1.5rem;
        }

        .movie-description {
            color: #ccc;
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .movie-meta {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .movie-length, .age-rating {
            color: #aaa;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .age-rating {
            color: #feca57;
            font-weight: 500;
        }

        .book-btn {
            width: 100%;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            color: #fff;
            border: none;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .book-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }

        /* Features Section */
        .features {
            background: rgba(255, 255, 255, 0.02);
            padding: 4rem 2rem;
        }

        .features-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            text-align: center;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.08);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: #fff;
        }

        .feature-title {
            color: #fff;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .feature-desc {
            color: #aaa;
            line-height: 1.6;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .movies-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1rem;
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

        .movie-card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .movie-card:nth-child(1) { animation-delay: 0.1s; }
        .movie-card:nth-child(2) { animation-delay: 0.2s; }
        .movie-card:nth-child(3) { animation-delay: 0.3s; }
        .movie-card:nth-child(4) { animation-delay: 0.4s; }
    </style>
</head>
<body>
    <!-- Import Header -->
    <%@ include file="../navigator/header.jsp" %>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h1>Trải nghiệm điện ảnh tuyệt vời</h1>
                <p>Đặt vé xem phim online nhanh chóng, tiện lợi. Hàng ngàn bộ phim hay đang chờ bạn khám phá!</p>
                <a href="#movies" class="cta-btn">Đặt vé ngay</a>
            </div>
        </section>

        <!-- Movies Section -->
        <section class="movies-section" id="movies">
            <h2 class="section-title">Phim đang chiếu</h2>
            
            <div class="movies-grid">
                <div class="movie-card">
                    <div class="movie-poster">🦸‍♂️ POSTER</div>
                    <div class="movie-info">
                        <h3 class="movie-title">Avengers: Endgame</h3>
                        <p class="movie-genre">Hành động • Phê phàng táo</p>
                        <div class="movie-rating">
                            <span class="stars">★★★★★</span>
                            <span style="color: #aaa;">8.9/10</span>
                        </div>
                        <div class="movie-details">
                            <p class="movie-description">Sau sự kiện của Infinity War, vũ trụ đang trong tình trạng hủy diệt. Với sự trợ giúp của các đồng minh còn lại, Avengers phải tập hợp một lần nữa.</p>
                            <div class="movie-meta">
                                <span class="movie-length">⏱️ 181 phút</span>
                                <span class="age-rating">🔞 T13 - Phù hợp từ 13 tuổi</span>
                            </div>
                        </div>
                        <button class="book-btn">Đặt vé</button>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">🌟 POSTER</div>
                    <div class="movie-info">
                        <h3 class="movie-title">Spider-Man: No Way Home</h3>
                        <p class="movie-genre">Phiêu lưu • Khoa học viễn tưởng</p>
                        <div class="movie-rating">
                            <span class="stars">★★★★☆</span>
                            <span style="color: #aaa;">8.7/10</span>
                        </div>
                        <div class="movie-details">
                            <p class="movie-description">Peter Parker phải đối mặt với hậu quả khi danh tính Spider-Man bị tiết lộ. Anh tìm đến Doctor Strange để xóa ký ức của mọi người.</p>
                            <div class="movie-meta">
                                <span class="movie-length">⏱️ 148 phút</span>
                                <span class="age-rating">🔞 T13 - Phù hợp từ 13 tuổi</span>
                            </div>
                        </div>
                        <button class="book-btn">Đặt vé</button>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">🎭 POSTER</div>
                    <div class="movie-info">
                        <h3 class="movie-title">The Batman</h3>
                        <p class="movie-genre">Hành động • Tâm lý</p>
                        <div class="movie-rating">
                            <span class="stars">★★★★☆</span>
                            <span style="color: #aaa;">8.5/10</span>
                        </div>
                        <div class="movie-details">
                            <p class="movie-description">Trong năm thứ hai chiến đấu với tội phạm, Batman khám phá sự tham nhũng ở Gotham City và mối liên hệ với gia đình của mình.</p>
                            <div class="movie-meta">
                                <span class="movie-length">⏱️ 176 phút</span>
                                <span class="age-rating">🔞 T16 - Phù hợp từ 16 tuổi</span>
                            </div>
                        </div>
                        <button class="book-btn">Đặt vé</button>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">🚀 POSTER</div>
                    <div class="movie-info">
                        <h3 class="movie-title">Top Gun: Maverick</h3>
                        <p class="movie-genre">Hành động • Chính kịch</p>
                        <div class="movie-rating">
                            <span class="stars">★★★★★</span>
                            <span style="color: #aaa;">9.1/10</span>
                        </div>
                        <div class="movie-details">
                            <p class="movie-description">Sau hơn 30 năm phục vụ, Pete "Maverick" Mitchell vẫn là phi công thử nghiệm hàng đầu của Hải quân, tránh thăng chức.</p>
                            <div class="movie-meta">
                                <span class="movie-length">⏱️ 130 phút</span>
                                <span class="age-rating">🔞 T13 - Phù hợp từ 13 tuổi</span>
                            </div>
                        </div>
                        <button class="book-btn">Đặt vé</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features">
            <div class="features-container">
                <h2 class="section-title">Tại sao chọn CinePlex?</h2>
                
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🎫</div>
                        <h3 class="feature-title">Đặt vé nhanh chóng</h3>
                        <p class="feature-desc">Giao diện thân thiện, đặt vé chỉ trong vài cú click. Thanh toán an toàn và bảo mật.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">🎬</div>
                        <h3 class="feature-title">Phim mới nhất</h3>
                        <p class="feature-desc">Cập nhật liên tục các bộ phim blockbuster mới nhất từ Hollywood và Việt Nam.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">🏢</div>
                        <h3 class="feature-title">Rạp hiện đại</h3>
                        <p class="feature-desc">Hệ thống rạp chiếu với công nghệ âm thanh và hình ảnh tiên tiến nhất.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Import Footer -->
    <%@ include file="../navigator/footer.jsp" %>

    <script>
        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Book ticket functionality
        document.querySelectorAll('.book-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const movieTitle = this.closest('.movie-card').querySelector('.movie-title').textContent;
                alert(`Đặt vé cho phim: ${movieTitle}\nChức năng đang được phát triển!`);
            });
        });

        // Add loading animation for movie cards
        window.addEventListener('load', () => {
            const movieCards = document.querySelectorAll('.movie-card');
            movieCards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                0%, 100% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
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
                font-weight: bold;
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
                /* Fixed height for all cards */
                height: 680px;
                display: flex;
                flex-direction: column;
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
                flex-shrink: 0;
            }

            .trailer-video {
                max-height: 100%;
            }

            .movie-info {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .movie-title {
                color: #fff;
                font-size: 1.3rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                /* Limit title to 2 lines */
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                line-height: 1.3;
                min-height: 2.6rem;
            }

            .movie-genre {
                color: #aaa;
                margin-bottom: 1rem;
                font-size: 0.9rem;
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
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }

            .movie-description {
                color: #ccc;
                font-size: 0.9rem;
                line-height: 1.5;
                margin-bottom: 1rem;
                /* Limit description to 3 lines */
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                flex-grow: 1;
            }

            .movie-meta {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
                margin-top: auto;
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

            /* Button Container */
            .movie-buttons {
                display: flex;
                gap: 0.75rem;
                margin-top: auto;
                flex-shrink: 0;
            }

            /* Base button styles */
            .movie-btn {
                flex: 1;
                border: none;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.9rem;
            }

            /* Detail button - outline style */
            .detail-btn {
                background: transparent;
                color: #fff;
                border: 2px solid rgba(255, 255, 255, 0.3);
            }

            .detail-btn:hover {
                background: rgba(255, 255, 255, 0.1);
                border-color: rgba(255, 255, 255, 0.5);
                transform: translateY(-2px);
            }

            /* Book button - gradient style */
            .book-btn {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: #fff;
                border: 2px solid transparent;
            }

            .book-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
            }

            /* Responsive adjustments for buttons */
            @media (max-width: 480px) {
                .movie-buttons {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-direction: row; /* Thay vì column để 2 button nằm ngang */
                    gap: 10px; /* Tăng gap lên một chút */
                }

                .movie-btn {
                    padding: 0.6rem 0.8rem;
                    font-size: 0.85rem;
                    min-width: 80px; /* Đảm bảo 2 button có cùng độ rộng */
                    flex: 1; /* Chia đều không gian */
                    max-width: 120px; /* Giới hạn độ rộng tối đa */
                }
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

                .movie-card {
                    height: 620px;
                }
            }

            @media (max-width: 480px) {
                .movie-card {
                    height: 580px;
                }

                .movie-poster {
                    height: 250px;
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

            .movie-card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .movie-card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .movie-card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .movie-card:nth-child(4) {
                animation-delay: 0.4s;
            }
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
                    <c:forEach var="movie" items="${movieList}">
                        <div class="movie-card">
                            <div class="movie-poster">
                                <video class="trailer-video" poster="${pageContext.request.contextPath}${movie.poster_url}" muted loop>
                                    <source src="${pageContext.request.contextPath}${movie.trailer_url}" type="video/mp4">
                                    <img src="${pageContext.request.contextPath}${movie.poster_url}" alt="${movie.title} Poster" class="poster-fallback">
                                </video>
                            </div>
                            <div class="movie-info">
                                <h3 class="movie-title">${movie.title}</h3>
                                <p class="movie-genre">${movie.genere_name}</p>
                                <div class="movie-rating">
                                    <span class="stars">★★★★☆</span>
                                    <span style="color: #aaa;">8.5/10</span>
                                </div>
                                <div class="movie-details">
                                    <p class="movie-description">${movie.description}</p>
                                    <div class="movie-meta">
                                        <span class="movie-length">⏱️ ${movie.duration} phút</span>
                                        <span class="age-rating">🔞 T${movie.age_restriction} - Phù hợp từ ${movie.age_restriction} tuổi</span>
                                    </div>
                                </div>

                                <div class="movie-buttons">
                                    <form action="MovieDetailController" method="get" style="display: inline;">
                                        <input type="hidden" name="movieId" value="${movie.movie_id}">
                                        <button type="submit" class="movie-btn detail-btn">Chi tiết</button>
                                    </form>
                                    <form action="ListMovieDetailController" method="get" style="display: inline;">
                                        <input type="hidden" name="movieId" value="${movie.movie_id}">
                                        <button type="submit" class="movie-btn book-btn">Đặt vé</button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
            //        document.querySelectorAll('.book-btn').forEach(btn => {
            //            btn.addEventListener('click', function() {
            //                const movieTitle = this.closest('.movie-card').querySelector('.movie-title').textContent;
            //                alert(`Đặt vé cho phim: ${movieTitle}\nChức năng đang được phát triển!`);
            //            });
            //        });
            document.querySelectorAll('.trailer-video').forEach(video => {
                let playTimeout;
                let isPlaying = false;
                video.addEventListener('click', () => {
                    if (isPlaying) {
                        video.currentTime = 0;
                        video.load()
                        return;
                    }
                    clearTimeout(playTimeout);
                    playTimeout = setTimeout(() => {
                        isPlaying = true;
                        video.muted = false;
                        video.play().catch(error => {
                            console.error('Lỗi khi phát video:', error);
                        });
                    }, 100); // Chờ 100ms trước khi phát
                });
                //    video.addEventListener('mouseleave', () => {
                //        clearTimeout(playTimeout);
                //        video.pause();
                //        video.currentTime = 0;
                //    });
                //    video.addEventListener('click', () => {
                //        if (video.paused) {
                //            video.play();
                //            video.muted = false;
                //        } else {
                //            video.pause();
                //            video.currentTime = 0;
                //        }
                //    });
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
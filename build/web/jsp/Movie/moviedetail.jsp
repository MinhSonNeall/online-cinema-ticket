<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!DOCTYPE html>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Phim - CinePlex</title>
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

            /* Header Navigation */
            .header {
                background: rgba(15, 15, 35, 0.95);
                padding: 15px 0;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
            }

            .logo {
                display: flex;
                align-items: center;
                font-size: 1.8em;
                font-weight: bold;
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .logo::before {
                content: "🎬";
                margin-right: 10px;
                font-size: 1.2em;
                background: none;
                -webkit-text-fill-color: initial;
            }

            .nav-menu {
                display: flex;
                list-style: none;
                gap: 40px;
            }

            .nav-menu li a {
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
                position: relative;
            }

            .nav-menu li a:hover {
                color: #ff6b6b;
            }

            .nav-menu li a::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 0;
                width: 0;
                height: 2px;
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                transition: width 0.3s ease;
            }

            .nav-menu li a:hover::after {
                width: 100%;
            }

            .auth-buttons {
                display: flex;
                gap: 15px;
            }

            .auth-btn {
                padding: 8px 20px;
                border: 1px solid #ff6b6b;
                background: transparent;
                color: #ff6b6b;
                text-decoration: none;
                border-radius: 20px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .auth-btn:hover {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: white;
                border-color: transparent;
            }

            /* Main Content */
            .main-content {
                margin-top: 80px;
                min-height: 100vh;
                background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
            }

            /* Movie Detail Section */
            .movie-detail-section {
                padding: 40px 0;
                background: transparent;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .movie-layout {
                display: grid;
                grid-template-columns: 400px 1fr;
                gap: 60px;
                align-items: start;
            }

            .poster-container {
                position: sticky;
                top: 120px;
            }

            .movie-poster {
                width: 100%;
                border-radius: 15px;
                box-shadow: 0 20px 40px rgba(255, 107, 107, 0.2);
                overflow: hidden;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .poster-image {
                width: 100%;
                height: auto;
                display: block;
            }

            /* Button Đặt vé */
            .book-ticket-btn {
                width: 100%;
                padding: 15px 20px;
                margin-top: 20px;
                background: linear-gradient(135deg, #ff6b6b, #ff8e53);
                border: none;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
                position: relative;
                overflow: hidden;
            }

            .book-ticket-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s ease;
            }

            .book-ticket-btn:hover::before {
                left: 100%;
            }

            .book-ticket-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 12px 35px rgba(255, 107, 107, 0.4);
                background: linear-gradient(135deg, #ff5252, #ff7043);
            }

            .book-ticket-btn:active {
                transform: translateY(-1px);
            }

            .btn-text {
                color: white;
                font-size: 16px;
                font-weight: bold;
                letter-spacing: 1.5px;
                text-transform: uppercase;
                position: relative;
                z-index: 1;
            }

            .movie-info {
                padding: 20px 0;
            }

            .movie-title {
                font-size: 2.5em;
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 15px;
                font-weight: bold;
            }

            .movie-description {
                font-size: 1.1em;
                color: #ccc;
                line-height: 1.7;
                margin-bottom: 30px;
                text-align: justify;
            }

            .movie-details {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                padding: 25px;
                border-radius: 15px;
                margin-bottom: 20px;
            }

            .detail-row {
                display: flex;
                margin-bottom: 15px;
                align-items: center;
            }

            .detail-row:last-child {
                margin-bottom: 0;
            }

            .detail-label {
                font-weight: 600;
                color: #fff;
                min-width: 100px;
                margin-right: 15px;
            }

            .detail-value {
                color: #ccc;
                flex: 1;
            }

            .rating-badge {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: white;
                padding: 4px 12px;
                border-radius: 15px;
                font-weight: bold;
                font-size: 0.9em;
                margin-right: 10px;
            }

            .format-badge {
                background: linear-gradient(45deg, #48dbfb, #0abde3);
                color: white;
                padding: 4px 12px;
                border-radius: 15px;
                font-weight: bold;
                font-size: 0.9em;
            }

            .genre-tag {
                background: rgba(255, 107, 107, 0.1);
                color: #ff6b6b;
                padding: 5px 15px;
                border-radius: 15px;
                font-size: 0.9em;
                border: 1px solid rgba(255, 107, 107, 0.3);
                display: inline-block;
                margin-right: 8px;
            }

            .directors-list, .cast-list {
                color: #feca57;
                font-weight: 500;
            }

            .social-buttons {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }

            .social-btn {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                color: white;
                font-weight: bold;
                transition: transform 0.3s ease;
            }

            .social-btn:hover {
                transform: scale(1.1);
            }

            .facebook {
                background: #3b5998;
            }
            .twitter {
                background: #1da1f2;
            }
            .pinterest {
                background: #bd081c;
            }
            .linkedin {
                background: #0077b5;
            }

            /* Trailer Section */
            .trailer-section {
                padding: 60px 0;
                background: rgba(255, 255, 255, 0.02);
            }

            .section-title {
                text-align: center;
                font-size: 2.5em;
                margin-bottom: 40px;
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .video-container {
                position: relative;
                max-width: 800px;
                margin: 0 auto;
                aspect-ratio: 16/9;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 20px 40px rgba(255, 107, 107, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .video-placeholder {
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, #ff6b6b 0%, #feca57 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .video-placeholder:hover {
                transform: scale(1.02);
            }

            .play-button {
                width: 80px;
                height: 80px;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
                transition: all 0.3s ease;
            }

            .play-button:hover {
                background: white;
                transform: scale(1.1);
            }

            .play-icon {
                width: 0;
                height: 0;
                border-left: 25px solid #333;
                border-top: 15px solid transparent;
                border-bottom: 15px solid transparent;
                margin-left: 5px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .nav-menu {
                    display: none;
                }

                .movie-layout {
                    grid-template-columns: 1fr;
                    gap: 30px;
                }

                .poster-container {
                    position: static;
                    max-width: 300px;
                    margin: 0 auto;
                }

                .movie-title {
                    font-size: 2em;
                    text-align: center;
                }

                .movie-description {
                    text-align: left;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header Navigation -->
        <%@ include file="../navigator/header.jsp" %>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Movie Detail Section -->
            <section class="movie-detail-section">
                <div class="container">
                    <div class="movie-layout">
                        <!-- Movie Poster -->
                        <div class="poster-container">
                            <div class="movie-poster">
                                <img src="${pageContext.request.contextPath}${movieDetails.poster_url}" 
                                     alt="${movieDetails.title}" 
                                     class="poster-image" 
                                     id="moviePoster">
                            </div>
                            <!-- Button Đặt vé -->
                            <form action="ListMovieDetailController" method="get" style="display: inline;">
                                        <input type="hidden" name="movieId" value="${movieDetails.movie_id}">
                                        <button type="submit" class="book-ticket-btn">🎫 ĐẶT VÉ NGAY</button>
                            </form>
                        </div>

                        <!-- Movie Information -->
                        <div class="movie-info">
                            <h1 class="movie-title" id="movieTitle">${movieDetails.title}</h1>

                            <p class="movie-description" id="movieDescription">
                            ${movieDetails.description}
                            </p>

                            <div class="movie-details">
                                <div class="detail-row">
                                    <span class="detail-label">Phân loại:</span>
                                    <div class="detail-value">
                                        <span class="rating-badge">${movieDetails.age_restriction}</span>
                                        <span>Phim phổ biến với mọi độ tuổi</span>
                                    </div>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Đạo diễn:</span>
                                    <div class="detail-value directors-list">Madeline Sharafian, Adrian Molina, Domee Shi</div>
                                </div>


                                <div class="detail-row">
                                    <span class="detail-label">Thể loại:</span>
                                    <div class="detail-value">
                                        <span class="genre-tag">${movieDetails.genere_name}</span>
                                    </div>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Khởi chiếu:</span>
                                    <div class="detail-value">${movieDetails.start_time_movie}</div>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Thời lượng:</span>
                                    <div class="detail-value">${movieDetails.duration}</div>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Ngôn ngữ:</span>
                                    <div class="detail-value">Phụ đề/Lồng tiếng</div>
                                </div>
                            </div>

                            <div class="social-buttons">
                                <a href="#" class="social-btn facebook" title="Chia sẻ trên Facebook">f</a>
                                <a href="#" class="social-btn twitter" title="Chia sẻ trên Twitter">𝕏</a>
                                <a href="#" class="social-btn pinterest" title="Chia sẻ trên Pinterest">P</a>
                                <a href="#" class="social-btn linkedin" title="Chia sẻ trên LinkedIn">in</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Trailer Section -->
            <section class="trailer-section">
                <div class="container">
                    <h2 class="section-title">Trailer chính thức</h2>
                    <div class="video-container">
                        <div class="video-placeholder" onclick="playTrailer()">
                            <div class="play-button">
                                <div class="play-icon"></div>
                            </div>
                            <p style="font-size: 1.2em; margin-bottom: 10px; color: white;" id="trailerTitle">${movieDetails.title}</p>
                            <p style="opacity: 0.7; color: white;" id="trailerSubtitle">Nhấn để xem</p>
                        </div>
                    </div>
                </div>
            </section>
    </main>
        <%@ include file="../navigator/footer.jsp" %>


    <script>
        // Movie data structure
        let movieData = {
            title: "ELIO: CẬU BÉ ĐẾN TỪ TRÁI ĐẤT",
            description: "Elio, một cậu bé đam mê vũ trụ với trí tưởng tượng phong phú, thấy mình đang ở trong một cuộc phiêu lưu ngoài vũ trụ, nơi cậu phải xây dựng mối quan hệ mới với các sự sống ngoài hành tinh và khám phá ra con người thật của mình.",
            rating: "P",
            ratingDescription: "Phim phổ biến với mọi độ tuổi",
            duration: "97 phút",
            releaseDate: "27/06/2025",
            language: "Phụ đề/Lồng tiếng",
            genres: ["Family"],
            directors: ["Madeline Sharafian", "Adrian Molina", "Domee Shi"],
            cast: ["Yonas Kibreab"],
            format: "2D",
            trailerUrl: ""
        };
        
        var movieData1 = {
        trailerUrl: '${pageContext.request.contextPath}${movieDetails.trailer_url}',
        movieId: '${movieDetails.movie_id}'
    };

        // Interactive functions
        function playTrailer() {
            if (movieData1.trailerUrl) {
                window.open(movieData1.trailerUrl, '_blank');
            } else {
                alert('Trailer sẽ được cập nhật sớm!');
            }
        }

        // Social sharing functions
        document.querySelector('.facebook').addEventListener('click', function(e) {
            e.preventDefault();
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent(movieData.title);
            window.open(`https://www.facebook.com/sharer/sharer.php?u=${url}&quote=${title}`, '_blank', 'width=600,height=400');
        });

        document.querySelector('.twitter').addEventListener('click', function(e) {
            e.preventDefault();
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent(movieData.title);
            window.open(`https://twitter.com/intent/tweet?text=${title}&url=${url}`, '_blank', 'width=600,height=400');
        });

        document.querySelector('.pinterest').addEventListener('click', function(e) {
            e.preventDefault();
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent(movieData.title);
            const image = encodeURIComponent(document.getElementById('moviePoster').src);
            window.open(`https://pinterest.com/pin/create/button/?url=${url}&media=${image}&description=${title}`, '_blank', 'width=600,height=400');
        });

        document.querySelector('.linkedin').addEventListener('click', function(e) {
            e.preventDefault();
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent(movieData.title);
            window.open(`https://www.linkedin.com/sharing/share-offsite/?url=${url}&title=${title}`, '_blank', 'width=600,height=400');
        });

        // Smooth scrolling for navigation
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
    </script>
</body>
</html>
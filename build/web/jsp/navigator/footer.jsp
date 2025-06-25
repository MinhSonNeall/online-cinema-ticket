<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* Footer */
    .footer {
        background: rgba(0, 0, 0, 0.95);
        color: #fff;
        padding: 3rem 2rem 1rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        margin-bottom: 2rem;
    }

    .footer-section h3 {
        color: #ff6b6b;
        margin-bottom: 1rem;
    }

    .footer-section ul {
        list-style: none;
    }

    .footer-section ul li {
        margin-bottom: 0.5rem;
    }

    .footer-section ul li a {
        color: #aaa;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-section ul li a:hover {
        color: #ff6b6b;
    }

    .footer-bottom {
        text-align: center;
        padding-top: 2rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        color: #aaa;
    }
</style>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-grid">
            <div class="footer-section">
                <h3>🎬 CinePlex</h3>
                <p style="color: #aaa; line-height: 1.6;">
                    Hệ thống rạp chiếu phim hàng đầu Việt Nam với trải nghiệm điện ảnh tuyệt vời nhất.
                </p>
            </div>

            <div class="footer-section">
                <h3>Dịch vụ</h3>
                <ul>
                    <li><a href="#">Đặt vé online</a></li>
                    <li><a href="#">Thành viên VIP</a></li>
                    <li><a href="#">Gift voucher</a></li>
                    <li><a href="#">Thuê phòng chiếu</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Hỗ trợ</h3>
                <ul>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                    <li><a href="#">Chính sách đổi trả</a></li>
                    <li><a href="#">Hotline: 1900-1234</a></li>
                    <li><a href="#">Email: support@cineplex.vn</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Kết nối</h3>
                <ul>
                    <li><a href="#">📘 Facebook</a></li>
                    <li><a href="#">📷 Instagram</a></li>
                    <li><a href="#">🐦 Twitter</a></li>
                    <li><a href="#">📺 YouTube</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p>© 2024 CinePlex. Tất cả quyền được bảo lưu.</p>
        </div>
    </div>
</footer>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán - CinePlex</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
                color: #333;
                min-height: 100vh;
            }

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
                content: "?";
                margin-right: 0.5rem;
            }

            .container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
                display: grid;
                grid-template-columns: 1fr 400px;
                gap: 2rem;
            }

            .checkout-form {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 20px;
                padding: 2rem;
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .order-summary {
                background: rgba(255, 255, 255, 0.08);
                border-radius: 20px;
                padding: 2rem;
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                height: fit-content;
            }

            .section-title {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                color: #ff6b4a;
                display: flex;
                align-items: center;
            }

            .section-title::before {
                content: "";
                width: 4px;
                height: 24px;
                background: linear-gradient(45deg, #ff6b4a, #ffa500);
                border-radius: 2px;
                margin-right: 0.75rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: #e0e0e0;
            }

            input, select {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 10px;
                background: rgba(255, 255, 255, 0.1);
                color: #ffffff;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            input:focus, select:focus {
                outline: none;
                border-color: #ff6b4a;
                box-shadow: 0 0 20px rgba(255, 107, 74, 0.3);
                transform: translateY(-2px);
            }

            input::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .payment-methods {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .payment-method {
                padding: 1rem;
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 10px;
                text-align: center;
                cursor: pointer;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.05);
            }

            .payment-method:hover {
                border-color: #ff6b4a;
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(255, 107, 74, 0.2);
            }

            .payment-method.active {
                border-color: #ff6b4a;
                background: rgba(255, 107, 74, 0.1);
            }

            .payment-method span {
                font-size: 1.5rem;
                display: block;
                margin-bottom: 0.5rem;
            }

            .movie-item {
                display: flex;
                gap: 1rem;
                margin-bottom: 1.5rem;
                padding: 1rem;
                background: rgba(255, 255, 255, 0.05);
                border-radius: 10px;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .movie-poster {
                width: 60px;
                height: 80px;
                border-radius: 8px;
                background: linear-gradient(45deg, #ff6b4a, #ffa500);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            .movie-details h4 {
                color: #ff6b4a;
                margin-bottom: 0.5rem;
            }

            .movie-details p {
                color: #b0b0b0;
                font-size: 0.9rem;
                margin-bottom: 0.25rem;
            }

            .price-breakdown {
                border-top: 1px solid rgba(255, 255, 255, 0.2);
                padding-top: 1rem;
                margin-top: 1rem;
            }

            .price-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.5rem;
            }

            .total-row {
                display: flex;
                justify-content: space-between;
                font-size: 1.2rem;
                font-weight: bold;
                color: #ff6b4a;
                border-top: 1px solid rgba(255, 255, 255, 0.2);
                padding-top: 1rem;
                margin-top: 1rem;
            }

            .btn {
                width: 100%;
                padding: 1rem 2rem;
                border: none;
                border-radius: 12px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                background: linear-gradient(45deg, #ff6b4a, #ffa500);
                color: white;
                margin-top: 1rem;
            }

            .btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 40px rgba(255, 107, 74, 0.4);
            }

            .btn:active {
                transform: translateY(-1px);
            }

            .security-info {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                margin-top: 1rem;
                font-size: 0.9rem;
                color: #b0b0b0;
            }

            .security-info::before {
                content: "?";
            }

            @media (max-width: 768px) {
                .container {
                    grid-template-columns: 1fr;
                    padding: 0 1rem;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }

                .payment-methods {
                    grid-template-columns: repeat(2, 1fr);
                }

                .header {
                    padding: 1rem;
                }
            }

            .success-animation {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.8);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            .success-content {
                background: rgba(255, 255, 255, 0.1);
                padding: 3rem;
                border-radius: 20px;
                text-align: center;
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .success-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
                animation: bounce 1s infinite;
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
        </style>
    </head>
    <body>
        <%@ include file="../navigator/header.jsp" %>

        <div class="container">
            <div class="checkout-form">
                <h2 class="section-title">Thông tin thanh toán</h2>

                <div class="form-group">
                    <h3 style="margin-bottom: 1rem; color: #ffa500;">Thanh toán qua VietQR</h3>
                    <div style="text-align: center; margin: 1rem 0;">
                        <img src="${qrUrl}" alt="Mã QR VietQR" style="width: 250px; height: 250px; border: 2px solid #ff6b4a; border-radius: 10px;">
                        <p style="color: #e0e0e0; margin-top: 1rem;">Quét mã QR bằng app ngân hàng để thanh toán ${totalPrice} VNĐ.</p>
                        <p style="color: #b0b0b0; font-size: 0.9rem;">Nội dung: ${addInfo}| Sau chuyển khoản, vé gửi qua email.</p>
                    </div>
                </div>

                <!-- Button xác nhận (optional, nếu cần POST confirm) -->
                <form id="checkoutForm"
                      action="CheckPaymentController"
                      method="post">

                    <input type="hidden" name="confirm" value="true">
                    <input type="hidden" name="selectedSeats" value="${selectedSeats}">
                    <input type="hidden" name="showtimeid" value="${showtimeid}">
                    <input type="hidden" name="addInfo" value="${addInfo}">
                    <input type="hidden" name="totalPrice" value="${totalPrice}">
                    <input type="hidden" name="ticketId" value="${ticketId}">
                    <input type="hidden" name="email" value="${user.email}">

                    <!-- ảnh QR, mô tả... -->

                    <button type="submit" class="btn">
                        Xác nhận đã thanh toán
                    </button>
                </form>

            </div>

            <div class="order-summary">
                <h2 class="section-title">Đơn hàng của bạn</h2>

                <div class="movie-item">
                    <div class="movie-poster">?</div>
                    <div class="movie-details">
                        <h4>${movieTitle}</h4>
                        <p>Rạp: ${cinemaName}</p>
                        <p>Suất: ${showtime}</p>
                        <p>Ghế: ${selectedSeats}</p>
                    </div>
                </div>

                <div class="price-breakdown">
                    <div class="price-row">
                        <span>Vé xem phim</span>
                        <span>${totalPrice} VND</span>
                    </div>
                    <div class="total-row">
                        <span>Tổng cộng</span>
                        <span>${totalPrice} VND</span>
                    </div>
                </div>

                <div style="margin-top: 2rem; padding: 1rem; background: rgba(255, 107, 74, 0.1); border-radius: 10px; border-left: 4px solid #ff6b4a;">
                    <h4 style="color: #ff6b4a; margin-bottom: 0.5rem;">Ưu đãi đặc biệt</h4>
                    <p style="font-size: 0.9rem; color: #e0e0e0;">Mua 2 vé tặng một combo bỏng ngô!</p>
                </div>
            </div>
        </div>

        <div class="success-animation" id="successAnimation">
            <div class="success-content">
                <div class="success-icon">?</div>
                <h2 style="color: #4ade80; margin-bottom: 1rem;">Thanh toán thành công!</h2>
                <p>Vé c?a b?n ?ã ???c g?i qua email</p>
                <p style="margin-top: 0.5rem; font-size: 0.9rem; color: #b0b0b0;">Mã ??t ch?: CP2025062801</p>
            </div>
        </div>

        <%@ include file="../navigator/footer.jsp" %>

        <script>
            // Payment method selection
            const paymentMethods = document.querySelectorAll('.payment-method');
            const cardInfo = document.getElementById('cardInfo');

            paymentMethods.forEach(method => {
                method.addEventListener('click', () => {
                    paymentMethods.forEach(m => m.classList.remove('active'));
                    method.classList.add('active');

                    const methodType = method.dataset.method;
                    if (methodType === 'card') {
                        cardInfo.style.display = 'block';
                    } else {
                        cardInfo.style.display = 'none';
                    }
                });
            });

            // Card number formatting
            const cardNumberInput = document.getElementById('cardNumber');
            cardNumberInput.addEventListener('input', (e) => {
                let value = e.target.value.replace(/\s/g, '').replace(/[^0-9]/gi, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = formattedValue;
            });

            // Expiry date formatting
            const expiryInput = document.getElementById('expiry');
            expiryInput.addEventListener('input', (e) => {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                e.target.value = value;
            });

            // Form submission
            const checkoutForm = document.getElementById('checkoutForm');
            const successAnimation = document.getElementById('successAnimation');

     


            // Input focus animations
            const inputs = document.querySelectorAll('input, select');
            inputs.forEach(input => {
                input.addEventListener('focus', () => {
                    input.parentElement.style.transform = 'scale(1.02)';
                });

                input.addEventListener('blur', () => {
                    input.parentElement.style.transform = 'scale(1)';
                });
            });
            
            const form = document.getElementById("checkoutForm");
    let isSubmitting = false;

    form.addEventListener("submit", function (e) {
        if (isSubmitting) {
            e.preventDefault(); // Chặn gửi lại
            return;
        }
        isSubmitting = true;
        const btn = form.querySelector("button[type='submit']");
        btn.disabled = true;
        btn.innerText = "Đang xử lý...";
    });
        </script>
    </body>
</html>
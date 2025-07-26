<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TickMe - Thông tin cá nhân</title>
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
                padding: 40px 20px;
            }
            
            /* User Profile Section */
            .profile-container {
                max-width: 800px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }
            
            .profile-header {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                padding: 30px;
                text-align: center;
                color: white;
                position: relative;
            }
            
            .profile-header h1 {
                font-size: 2rem;
                margin-bottom: 10px;
            }
            
            .profile-header p {
                font-size: 1rem;
                opacity: 0.9;
            }
            
            .profile-avatar {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
                margin: 0 auto 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                border: 3px solid white;
                color: #ff6b6b;
            }
            
            .profile-content {
                padding: 30px;
            }
            
            .form-group {
                margin-bottom: 25px;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #fff;
            }
            
            .form-group input {
                width: 100%;
                padding: 12px 15px;
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 8px;
                color: #fff;
                font-size: 1rem;
                transition: all 0.3s ease;
            }
            
            .form-group input:focus {
                outline: none;
                border-color: #ff6b6b;
                background: rgba(255, 255, 255, 0.15);
                box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.3);
            }
            
            .form-group input::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }
            
            .form-row {
                display: flex;
                gap: 20px;
            }
            
            .form-row .form-group {
                flex: 1;
            }
            
            .btn-container {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }
            
            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 50px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 1rem;
            }
            
            .btn-primary {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
                color: white;
                box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
            }
            
            .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
            }
            
            .btn-secondary {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border: 1px solid rgba(255, 255, 255, 0.3);
            }
            
            .btn-secondary:hover {
                background: rgba(255, 255, 255, 0.2);
            }
            
            .readonly {
                background: rgba(255, 255, 255, 0.05);
                cursor: not-allowed;
            }
            
            /* Alert Messages */
            .alert {
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
                animation: fadeIn 0.5s ease;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-10px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            .alert-success {
                background: rgba(40, 167, 69, 0.2);
                border: 1px solid rgba(40, 167, 69, 0.3);
                color: #28a745;
            }
            
            .alert-danger {
                background: rgba(220, 53, 69, 0.2);
                border: 1px solid rgba(220, 53, 69, 0.3);
                color: #dc3545;
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .form-row {
                    flex-direction: column;
                    gap: 0;
                }
                
                .btn-container {
                    flex-direction: column;
                    gap: 15px;
                }
                
                .btn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="navigator/header.jsp" />
        
        <div class="main-content">
            <div class="profile-container">
                <div class="profile-header">
                    <div class="profile-avatar">👤</div>
                    <h1>Thông tin cá nhân</h1>
                    <p>Quản lý thông tin cá nhân của bạn</p>
                </div>
                
                <div class="profile-content">
                    <!-- Alert Messages -->
                    <c:if test="${not empty requestScope.success}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ${success}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <!-- User Information Form -->
                    <form action="${pageContext.request.contextPath}/UserDetail" method="post">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="${userDetail.email}" readonly class="readonly">
                        </div>
                        
                        <div class="form-group">
                            <label for="fullName">Họ và tên</label>
                            <input type="text" id="fullName" name="fullName" value="${userDetail.full_name}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phoneNumber">Số điện thoại</label>
                            <input type="text" id="phoneNumber" name="phoneNumber" value="${userDetail.phone_number}" required>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="password">Mật khẩu mới (để trống nếu không đổi)</label>
                                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới">
                            </div>
                            
                            <div class="form-group">
                                <label for="confirmPassword">Xác nhận mật khẩu</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu mới">
                            </div>
                        </div>
                        
                        <div class="btn-container">
                            <a href="${pageContext.request.contextPath}/ListMovieController" class="btn btn-secondary">Quay lại</a>
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Include Footer -->
        <jsp:include page="navigator/footer.jsp" />
        
        <script>
            // Form validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (password !== '' && password !== confirmPassword) {
                    e.preventDefault();
                    alert('Mật khẩu xác nhận không khớp!');
                }
            });
        </script>
    </body>
</html> 
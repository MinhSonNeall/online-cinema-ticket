xx`<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách suất chiếu theo ngày</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            padding: 30px;
            display: flex;
            justify-content: center;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
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
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .header h1 {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 600;
        }
        
        .info-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-left: 5px solid #3498db;
            animation: slideIn 0.5s ease;
        }
        
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        .info-card h4 {
            color: #2c3e50;
            font-size: 20px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .info-card h4 i {
            margin-right: 10px;
            color: #3498db;
        }
        
        .info-card p {
            margin: 10px 0;
            color: #2c3e50;
            font-size: 16px;
        }
        
        .info-card p strong {
            display: inline-block;
            width: 150px;
            color: #7f8c8d;
        }
        
        .table-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 30px;
            animation: fadeUp 0.7s ease;
        }
        
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .table-header {
            background: #f8f9fa;
            padding: 20px 25px;
            border-bottom: 1px solid #e1e8ed;
        }
        
        .table-header h3 {
            color: #2c3e50;
            font-size: 18px;
            display: flex;
            align-items: center;
        }
        
        .table-header h3 i {
            margin-right: 10px;
            color: #3498db;
        }
        
        .table-container {
            overflow-x: auto;
            padding: 0;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #f8f9fa;
        }
        
        th {
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #e1e8ed;
        }
        
        td {
            padding: 15px 20px;
            border-bottom: 1px solid #e1e8ed;
            color: #2c3e50;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
            transition: all 0.3s ease;
        }
        
        .empty-message {
            text-align: center;
            padding: 30px;
            color: #7f8c8d;
            font-style: italic;
        }
        
        .back-btn {
            display: inline-block;
            padding: 12px 25px;
            background: #3498db;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-top: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border: none;
            cursor: pointer;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(52, 152, 219, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(52, 152, 219, 0); }
            100% { box-shadow: 0 0 0 0 rgba(52, 152, 219, 0); }
        }
        
        .back-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .back-btn i {
            margin-right: 8px;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .header {
                flex-direction: column;
                text-align: center;
                padding: 20px 15px;
            }
            
            .info-card p strong {
                width: 120px;
            }
            
            th, td {
                padding: 12px 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-calendar-day"></i> Danh sách suất chiếu theo ngày</h1>
    </div>
    
    <div class="info-card">
        <h4><i class="fas fa-info-circle"></i> Thông tin đợt chiếu</h4>
        <p><strong>Phim:</strong> ${showtime.movie_title}</p>
        <p><strong>Rạp:</strong> ${showtime.cinema_name}</p>
        <p><strong>Phòng:</strong> ${showtime.room_name}</p>
        <p><strong>Thời gian áp dụng:</strong> <fmt:formatDate value="${showtime.start_time}" pattern="dd/MM/yyyy" /> đến <fmt:formatDate value="${showtime.end_time}" pattern="dd/MM/yyyy" /></p>
        <p><strong>Tổng số suất chiếu:</strong> ${slotCount}</p>
    </div>
    
    <div class="table-section">
        <div class="table-header">
            <h3><i class="fas fa-list"></i> Chi tiết các suất chiếu</h3>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Slot ID</th>
                        <th>Ngày chiếu</th>
                        <th>Giờ bắt đầu</th>
                        <th>Giờ kết thúc</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty slots}">
                        <tr>
                            <td colspan="4" class="empty-message">Không có suất chiếu nào cho đợt chiếu này.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="slot" items="${slots}">
                            <tr>
                                <td>${slot.slot_id}</td>
                                <td>${slot.date}</td>
                                <td>${slot.start_time}</td>
                                <td>${slot.end_time}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    <a href="${pageContext.request.contextPath}/ManageShowtime" class="back-btn">
        <i class="fas fa-arrow-left"></i> Trở về trang manageShowTime
    </a>
</div>
</body>
</html> 
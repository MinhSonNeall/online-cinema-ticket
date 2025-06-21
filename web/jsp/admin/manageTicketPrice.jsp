<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.role != 'admin'}">
    <c:redirect url="/jsp/authenticationFailed.jsp"/>
</c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Ticket Prices</title>
</head>
<body>
<h1>Manage Ticket Prices</h1>
<%-- TODO: Implement ticket price management functionality here --%>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
</head>
<body>
    <h1>Order Confirmation</h1>

    <!-- Display success or error messages -->
    <p th:if="${successMessage != null}">${successMessage}</p>
    <p th:if="${errorMessage != null}">${errorMessage}</p>
</body>
</html>
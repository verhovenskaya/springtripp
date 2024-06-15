<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Регистрация</title>
  <style>
    body {
      background-image: url("resources/static/fon6.jpg"); /* Replace with your actual image */
          background-size: cover;
           background-position: center;
           display: flex;
           justify-content: center;
           align-items: center;
           min-height: 100vh;
           margin: 0;
           font-family: sans-serif;
    }

    .registration-container {
      background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent white */
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      text-align: center;
    }

    .registration-container h2 {
      margin-bottom: 20px;
      color: #333;
    }


    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
    }
 button[type="submit"] {
      background-color: #ffd800;
      color: white;
      padding: 12px 20px;
      margin: 8px 0;
      border: none;
      cursor: pointer;
      width: 100%;
    }

    button[type="submit"]:hover {
      background-color: #fad201;
    }

    form:form .error {
      color: red;
    }
h4 {
      margin-top: 20px;
      color: #333;
    }

    a {
      color: #333;
      text-decoration: none;
    }

  </style>
</head>

<body>
<div class="registration-container">
  <form:form method="POST" modelAttribute="userForm">
    <h2>Регистрация</h2>
    <div class="form-group">
      <form:input type="text" path="username" placeholder="Username" autofocus="true"/>
      <form:errors path="username" class="error"></form:errors>
      <c:if test="${usernameError != null}">
        <span class="error">${usernameError}</span>
      </c:if>
    </div>
    <div class="form-group">
      <form:input type="password" path="password" placeholder="Password"/>
    </div>
    <div class="form-group">
      <form:input type="password" path="passwordConfirm" placeholder="Confirm your password"/>
      <form:errors path="password" class="error"></form:errors>
      <c:if test="${passwordError != null}">
        <span class="error">${passwordError}</span>
      </c:if>
    </div>
    <button type="submit">Зарегистрироваться</button>
  </form:form>
  <a href="/">Главная</a>
</div>
</body>
</html>
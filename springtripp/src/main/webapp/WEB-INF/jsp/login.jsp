<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Log in with your account</title>
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

    .login-container {
      background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent white */
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      text-align: center;
    }

    .login-container h2 {
      margin-bottom: 20px;
      color: #333;
    }

    input[type="text"], input[type="password"] {
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
  <div class="login-container">
    <form method="POST" action="/login">
      <h2>Вход в систему</h2>
      <div>
        <input name="username" type="text" placeholder="Username" autofocus="true"/>
        <input name="password" type="password" placeholder="Password"/>
        <button type="submit">Log In</button>
        <h4><a href="/registration">Зарегистрироваться</a></h4>
      </div>
    </form>
  </div>
  <script>
    // Redirect if already authenticated
    if (document.readyState === 'complete') {
      fetch('/api/auth/user', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        }
      })
      .then(response => {
        if (response.ok) {
          window.location.href = '/';
        }
      })
      .catch(error => {
        console.error("Error checking authentication:", error);
      });
    }
  </script>
</body>
</html>


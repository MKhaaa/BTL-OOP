<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .login-container {
            width: 300px;
            margin: 100px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px #ccc;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type=text], input[type=password] {
            width: 100%;
            padding: 8px 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type=submit] {
            width: 100%;
            padding: 10px 0;
            background-color: #4CAF50;
            border: none;
            color: #fff;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type=submit]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
        .login-links {
            text-align: center;
            margin-top: 15px;
        }
        .login-links a {
            text-decoration: none;
            color: #4CAF50;
            margin: 0 10px;
            font-size: 0.9em;
        }
        .login-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <%-- Form đăng nhập --%>
    <form action="login" method="post">
        <input type="text" name="username" placeholder="Username" required/>
        <input type="password" name="password" placeholder="Password" required/>
        <input type="submit" value="Login"/>
    </form>

    <%-- Các liên kết bổ sung --%>
    <div class="login-links">
        <a href="forgot-password.jsp">Forgot Password?</a>
        <a href="register.jsp">Register</a>
    </div>
</div>
</body>
</html>
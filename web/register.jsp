<%-- 
    Document   : resetpassword
    Created on : Oct 12, 2025, 10:37:44 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .form-container {
            width: 350px;
            margin: 80px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px #ccc;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type=text], input[type=password], input[type=email] {
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
        .message {
            text-align: center;
            margin-bottom: 10px;
            color: red;
        }
        .links {
            text-align: center;
            margin-top: 15px;
        }
        .links a {
            text-decoration: none;
            color: #4CAF50;
            margin: 0 10px;
            font-size: 0.9em;
        }
        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Register</h2>

    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>

    <form action="register" method="post">
        <input type="text" name="username" placeholder="Username" required/>
        <input type="email" name="email" placeholder="Email" required/>
        <input type="password" name="password" placeholder="Password" required/>
        <input type="submit" value="Register"/>
    </form>

    <div class="links">
        <a href="login.jsp">Back to Login</a>
    </div>
</div>
</body>
</html>
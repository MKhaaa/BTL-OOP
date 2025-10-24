<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            width: 400px;
            margin: 80px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #aaa;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #0077cc;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #005fa3;
        }
        .message {
            margin-top: 15px;
            text-align: center;
            color: red;
        }
        .success {
            color: green;
        }
        .link-login {
            text-align: center;
            margin-top: 15px;
        }
        .link-login a {
            color: #0077cc;
            text-decoration: none;
        }
        .link-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Reset Password</h2>

    <% String token = request.getParameter("token"); %>

    <% if(token == null) { %>
        <p class="message">Invalid reset link!</p>
    <% } else { %>
        <form action="reset-password" method="post">
            <input type="hidden" name="token" value="<%=token%>">
            <label>New Password:</label>
            <input type="password" name="password" required>
            <button type="submit">Reset Password</button>
        </form>
    <% } %>

    <% 
        if(request.getAttribute("message") != null) { 
            String msg = (String) request.getAttribute("message");
            boolean success = msg.toLowerCase().contains("successful");
    %>
        <p class="message <%= success ? "success" : "" %>"><%= msg %></p>
    <% } %>

    <div class="link-login">
        <a href="login.jsp">Back to Login</a>
    </div>
</div>
</body>
</html>
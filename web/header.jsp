<!-- header.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* Thanh taskbar chính */
    .navbar {
        background-color: #3b3b3b;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 30px;
        color: #fff;
        font-family: 'Segoe UI', sans-serif;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }

    .navbar-left,
    .navbar-right {
        display: flex;
        align-items: center;
        gap: 25px;
    }

    .navbar a {
        text-decoration: none;
        color: #fff;
        font-weight: 500;
        transition: color 0.2s ease-in-out;
    }

    .navbar a:hover {
        color: #ffcc00;
    }

    .navbar .cart-btn {
        background-color: #ffcc00;
        color: #000;
        padding: 6px 12px;
        border-radius: 6px;
        font-weight: bold;
        transition: background-color 0.2s;
    }

    .navbar .cart-btn:hover {
        background-color: #e6b800;
    }

    .navbar .user-info {
        font-weight: 500;
        margin-left: 10px;
    }

    .navbar .logout-btn {
        background-color: #ff4d4d;
        color: white;
        padding: 6px 12px;
        border-radius: 6px;
        transition: background-color 0.2s;
    }

    .navbar .logout-btn:hover {
        background-color: #e60000;
    }
</style>

<div class="navbar">
    <div class="navbar-left">
        <a href="home">Home</a>
        <a href="about">About</a>
        <a href="services">Services</a>
        <a href="contact">Contact</a>
    </div>

    <div class="navbar-right">
        <a href="cart.jsp" class="cart-btn">🛒 Giỏ hàng</a>
        <c:set var="user" value="${sessionScope.user}"/>
        <span class="user-info">Xin chào: 
            <strong>${empty user ? 'Khách' : String.format("%s %s", user.firstName, user.lastName)}</strong>
        </span>
        <a href="logout" class="logout-btn">Đăng xuất</a>
    </div>
</div>

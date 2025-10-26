<!-- header.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .navbar {
	background: #3b3b3b;
	color: #fff;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 30px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, .2);
	position: sticky;
	top: 0;
	left: 0;
	z-index: 10;
	font-size: 22px;
	font-family: system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
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
	transition: color .2s;
    }

    /*      .navbar a:hover {
	    color: #ffcc00;
	  }*/

    .navbar .cart-btn {
	background: #ffcc00;
	color: #000;
	padding: 6px 12px;
	border-radius: 6px;
	font-weight: 700;
	text-decoration: none;
    }
    .logout-btn {
	background: #ff4d4d;
	color: #fff;
	padding: 6px 12px;
	border-radius: 6px;
	text-decoration: none;
    }

    .logout-btn:hover {
	background: #e60000;
    }
</style>

<div class="navbar">
    <div class="navbar-left">
	<a href="./home">Home</a>
	<a href="#">About</a>
	<a href="#">Services</a>
	<a href="#">Contact</a>
    </div>

    <div class="navbar-right">
	<a href="./cart" class="cart-btn">🛒 Giỏ hàng</a>
	<c:set var="user" value="${sessionScope.user}"/>
	<span class="user-info">
	    Xin chào: <strong>${empty user ? 'Khách' : String.format("%s %s", user.firstName, user.lastName)}</strong>
	</span>
	<a href="${empty user ? "./login" : "./logout"}" class="logout-btn">
	    ${empty user ? 'Đăng nhập' : 'Đăng xuất'}
	</a>
    </div>
</div>

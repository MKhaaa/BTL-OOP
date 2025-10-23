<%-- 
    Document   : home
    Created on : Oct 12, 2025, 10:31:19 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="utils.PriceUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>Trang chủ</title>

	<style>
	    :root {
		--bg: #f3f4f6;
		--panel: #fff;
		--ink: #111827;
		--muted: #6b7280;
		--line: #e5e7eb;
		--shadow: 0 10px 24px rgba(0, 0, 0, .06);
		--radius: 14px;
	    }

	    * {
		box-sizing: border-box;
	    }

	    html,
	    body {
		height: 100%;
	    }

	    body {
		margin: 0;
		font-family: system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
		color: var(--ink);
		background: var(--bg);
		font-size: 20px;
	    }

	    /* ===== Navbar ===== */
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

	    /*  Layout  */
	    .layout {
		display: grid;
		grid-template-columns: 250px 1fr;
		gap: 14px;
		/*width: 100%;*/
		/*max-width: 1400px;*/
		margin: 20px;
		padding: 0 16px;
	    }

	    /* Sidebar */
	    .sidebar {
		position: sticky;
		top: 100px;
		align-self: start;
		padding-right: 25px;
	    }

	    .sidebar h2 {
		font-size: 28px;
		font-family: "Times New Roman", serif;
		margin: 6px 0 16px;
		margin-top: 0;
		text-align: center;
	    }

	    .brand {
		display: block;
		background: var(--panel);
		border: 1px solid var(--line);
		border-radius: 8px;
		padding: 12px 14px;
		color: #333;
		text-decoration: none;
		margin-bottom: 10px;
		box-shadow: var(--shadow);
		transition: 0.2s;
		text-transform: uppercase;
		font-weight: 500;
	    }

	    .brand:hover {
		background: #f3f3f3;
	    }
	    
	    .sidebar .selected {
		background-color: #333333;
		color: #fff;
	    }

	    /*  Sortbar */
	    .sortbar {
		display: flex;
		align-items: center;
		gap: 10px;
		margin-top: 6px;
		margin-bottom: 16px;
		margin-left: -6px;
	    }

	    .sortbar .label {
		font-weight: 700;
		color: #333;
	    }

	    .chip {
		display: inline-flex;
		align-items: center;
		background: #f7f7f7;
		border: 3px solid var(--line);
		border-radius: 999px;
		padding: .45rem .8rem;
		font-weight: 700;
		color: #222;
		text-decoration: none;
		white-space: nowrap;
	    }
	    .sortbar .selected {
		color: #3b82f6;
		border: 3px solid #3b82f6;
	    }

	    /* Product grid */
	    .product-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
		gap: 16px;
	    }

	    /*  Card  */
	    .card {
		background: var(--panel);
		border: 1px solid var(--line);
		border-radius: 16px;
		box-shadow: var(--shadow);
		padding: 12px;
		text-align: center;
	    }

	    .card img {
		width: 70%;
		border-radius: 10px;
		margin-bottom: 8px;
	    }

	    .card h2 {
		font-family: "Times New Roman", serif;
		font-size: 20px;
		margin: 6px 0;
	    }

	    .price-old {
		margin: 4px 0;
		color: #999;
		font-size: 18px;
	    }

	    .price-old .old-value {
		text-decoration: line-through;
	    }

	    .price-old .discount {
		color: #c70000;
		font-weight: 700;
		margin-left: 6px;
		text-decoration: none;
	    }

	    .price-new {
		color: #c70000;
		font-weight: 700;
		font-size: 20px;
		margin: 6px 0;
	    }

	    .pill.light {
		display: inline-flex;
		justify-content: center;
		align-items: center;
		background: #f1ecea;
		border: 1px solid #e3d9d7;
		color: #3a302f;
		border-radius: 8px;
		padding: 6px 10px;
		font-size: 16px;
		font-weight: 600;
		width: auto;
		margin: 6px auto 2px;
		text-decoration: none;
		transition: .2s;
	    }

	    .pill.light:hover {
		background: #e9e3e0;
		transform: translateY(-1px);
	    }
/*	    pagination*/
	    .pagination {
		display: flex;
		justify-content: center;
		text-align: center;
		padding-left: 200px;
	    }
	    .pagination li{
		list-style: none;
	    }
	    .pagination li a {
		display: inline-block;
		margin: 20px 5px;
		padding: 10px 15px;
		color: #000;
		border: 1px solid #e0e0e0;
		border-radius: 5px;
		box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.3);
		text-decoration: none;
	    }
	    .pagination li a:hover {
		color: #fff;
		background-color: #000;
	    }
	    .pagination .disabled {
		pointer-events: none;
		opacity: 0.5;
	    }
	    .pagination .selected {
		color: #fff;
		background-color: #000;
	    }
	</style>
    </head>

    <body>

	<!-- Navbar -->
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

	<!-- Layout -->
	<div class="layout">

	    <!-- Sidebar -->
	    <c:set var="url" value=""/>
	    <c:forEach var="entry" items="${paramValues}">
		<c:if test="${entry.key ne 'brand' and entry.key ne 'page'}" >
		    <c:set var="url" value="${url}${entry.key}=${entry.value[0]}&"/>
		</c:if>
	    </c:forEach>
	    <nav class="sidebar">
		<h2>Nhà sản xuất</h2>
		<c:forEach var="b" items="${brands}">
		    <c:choose>
			<c:when test="${param.brand eq b.id}">
			    <a href="./home?${url}" class="brand selected">${b.name}</a>
			</c:when>
			<c:otherwise>
			    <a href="./home?${url}brand=${b.id}" class="brand">${b.name}</a>
			</c:otherwise>
		    </c:choose>
		    
		</c:forEach>
	    </nav>

	    <!-- Main -->
	    <main>
		<div class="sortbar">
		    <c:set var="sortField" value="${param.sortField}"/>
		    <c:set var="sortOrder" value="${param.sortOrder}"/>
		    <c:set var="brand" value="${empty param.brand ? '' : String.format('&brand=%s', param.brand)}"/>
		    
		    <span class="label">Sắp xếp theo:</span>
		    <a href="./home?sortField=sale-rate${brand}" class="chip ${sortField eq "sale-rate" ? "selected" : ""}">% Khuyến mãi HOT</a>
		    <a href="./home?sortField=price&sortOrder=asc${brand}" class="chip ${sortOrder eq "asc" ? "selected" : ""}">↧ Giá Thấp - Cao</a>
		    <a href="./home?sortField=price&sortOrder=desc${brand}" class="chip ${sortOrder eq "desc" ? "selected" : ""}">↥ Giá Cao - Thấp</a>
		</div>

		<section class="product-grid">
		    <c:forEach var="p" items="${products}">
			<article class="card">
			    <img
				src="${p.images[0]}"
				alt="iPhone 15 Pro Max" />
			    <h2>${p.name}</h2>
			    <p class="price-old">
				<span class="old-value">${PriceUtil.handlePrice(p.price_original)}đ</span>
				<span class="discount">-${p.sale_rate}%</span>
			    </p>
			    <p class="price-new">${PriceUtil.handlePrice(p.price_promo)}đ</p>
			    <a href="./product-detail?id=${p.id}" class="pill light">Chi tiết sản phẩm</a>
			</article>
		    </c:forEach>

		</section>
	    </main>

	</div>
	<div>
	    <ul class="pagination">
		<c:set var="totalPages" value="${totalPages}"/>
		<c:set var="pageCur" value="${page + 0}"/>
		<c:set var="url" value=""/>
		<c:forEach var="entry" items="${paramValues}">
		    <c:if test="${entry.key ne 'page'}">
			<c:set var="url" value="${url}${entry.key}=${entry.value[0]}&"/>
		    </c:if>
		</c:forEach>
		<li>
		    <a href="./home?${url}page=${pageCur - 1}" class="${pageCur eq 1 ? "disabled" : ""}"><< Back</a>
		</li>

		<c:forEach var="i" begin="1" end="${totalPages}">
		    <li>
			<a href="./home?${url}page=${i}" class="${i eq pageCur ? "selected" : ""}">${i}</a>
		    </li>
		</c:forEach>

		<li>
		    <a href="./home?${url}page=${pageCur + 1}" class="${pageCur eq totalPages ? "disabled" : ""}">Next >></a>
		</li>
	    </ul>
	</div>
    </body>

</html>
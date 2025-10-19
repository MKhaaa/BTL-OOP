<%-- 
    Document   : home
    Created on : Oct 12, 2025, 10:31:19 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Demo</title>

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

      .cart-btn {
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
      }

      .brand:hover {
        background: #f3f3f3;
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
        font-size: 16px;
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
        <a href="${pageContext.request.contextPath}/cart" class="cart-btn">🛒 Giỏ hàng</a>
        <span class="user-info">
          Xin chào: <strong>${empty sessionScope.username ? 'Khách' : sessionScope.username}</strong>
        </span>
        <a href="${pageContext.request.contextPath}/login" class="logout-btn">
          ${empty sessionScope.username ? 'Đăng nhập' : 'Đăng xuất'}
        </a>
      </div>
    </div>

    <!-- Layout -->
    <div class="layout">

      <!-- Sidebar -->
      <nav class="sidebar">
        <h2>Nhà sản xuất</h2>
        <a href="#" class="brand">iPhone</a>
        <a href="#" class="brand">SAMSUNG</a>
        <a href="#" class="brand">OPPO</a>
        <a href="#" class="brand">XIAOMI</a>
      </nav>

      <!-- Main -->
      <main>
        <div class="sortbar">
          <span class="label">Sắp xếp theo:</span>
          <a class="chip">% Khuyến mãi HOT</a>
          <a class="chip">↧ Giá Thấp - Cao</a>
          <a class="chip">↥ Giá Cao - Thấp</a>
        </div>

        <section class="product-grid">
          <article class="card">
            <img
              src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png"
              alt="iPhone 15 Pro Max" />
            <h2>iPhone 15 Pro Max 256GB</h2>
            <p class="price-old">
              <span class="old-value">35.000.000đ</span>
              <span class="discount">-20%</span>
            </p>
            <p class="price-new">27.700.000đ</p>
            <a href="#" class="pill light">Chi tiết sản phẩm</a>
          </article>
	    <article class="card">
            <img
              src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png"
              alt="iPhone 15 Pro Max" />
            <h2>iPhone 15 Pro Max 256GB</h2>
            <p class="price-old">
              <span class="old-value">35.000.000đ</span>
              <span class="discount">-20%</span>
            </p>
            <p class="price-new">27.700.000đ</p>
            <a href="#" class="pill light">Chi tiết sản phẩm</a>
          </article>
	    <article class="card">
            <img
              src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png"
              alt="iPhone 15 Pro Max" />
            <h2>iPhone 15 Pro Max 256GB</h2>
            <p class="price-old">
              <span class="old-value">35.000.000đ</span>
              <span class="discount">-20%</span>
            </p>
            <p class="price-new">27.700.000đ</p>
            <a href="#" class="pill light">Chi tiết sản phẩm</a>
          </article>
	    <article class="card">
            <img
              src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png"
              alt="iPhone 15 Pro Max" />
            <h2>iPhone 15 Pro Max 256GB</h2>
            <p class="price-old">
              <span class="old-value">35.000.000đ</span>
              <span class="discount">-20%</span>
            </p>
            <p class="price-new">27.700.000đ</p>
            <a href="#" class="pill light">Chi tiết sản phẩm</a>
          </article>
	    <article class="card">
            <img
              src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png"
              alt="iPhone 15 Pro Max" />
            <h2>iPhone 15 Pro Max 256GB</h2>
            <p class="price-old">
              <span class="old-value">35.000.000đ</span>
              <span class="discount">-20%</span>
            </p>
            <p class="price-new">27.700.000đ</p>
            <a href="#" class="pill light">Chi tiết sản phẩm</a>
          </article>
        </section>
      </main>

    </div>

  </body>

  </html>
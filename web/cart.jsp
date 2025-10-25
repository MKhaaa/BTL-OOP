<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f6f6;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            table-layout: fixed; /* ⚡ giữ độ rộng cột cố định */
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            vertical-align: middle; /* 👈 căn giữa theo chiều dọc */
            word-wrap: break-word;
        }

        th {
            background: #888;
            color: white;
            text-transform: uppercase;
        }

        /* ⚙️ Cố định độ rộng từng cột */
        th:nth-child(1), td:nth-child(1) { width: 35%; text-align: center; }   /* Sản phẩm */
        th:nth-child(2), td:nth-child(2) { width: 15%; text-align: center; } /* Giá */
        th:nth-child(3), td:nth-child(3) { width: 20%; text-align: center; } /* Số lượng */
        th:nth-child(4), td:nth-child(4) { width: 15%; text-align: center; } /* Thành tiền */
        th:nth-child(5), td:nth-child(5) { width: 15%; text-align: center; } /* Hành động */

        td img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            margin-top: 5px;
            border-radius: 4px;
        }

        .quantity-controls {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
        }

        .quantity-controls button {
            width: 30px;
            height: 30px;
            border: none;
            border-radius: 4px;
            background: #888;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }

        .quantity-controls button:hover {
            opacity: 0.9;
        }

        .quantity-controls input[type="number"] {
            width: 50px;
            text-align: center;
            padding: 5px;
            font-size: 15px;
        }

        /* Ẩn nút tăng/giảm mặc định trong input number */
        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }

        .btn-delete {
            background-color: #f44336;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .total {
            text-align: right;
            width: 90%;
            margin: 10px auto;
            font-weight: bold;
            font-size: 18px;
        }

        .price, .total-price {
            display: inline-block;
            text-align: center;
            width: 100%;
        }
    </style>
</head>
<body>

<h1>🛒 Giỏ hàng của bạn</h1>

<c:choose>
    <c:when test="${not empty cart.items}">
        <table>
            <tr>
                <th>Sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
                <th>Hành động</th>
            </tr>

            <c:forEach var="item" items="${cart.items}">
                <tr>
                    <!-- Cột Sản phẩm -->
                    <td>
                        <div>
                            <strong>${item.name}</strong><br>
                            <img src="${item.img}" alt="${item.name}">
                        </div>
                    </td>

                    <!-- Cột Giá -->
                    <td>
                        <div class="price">
                            <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" /> VNĐ
                        </div>
                    </td>

                    <!-- Cột Số lượng -->
                    <td>
                        <div class="quantity-controls">
                            <!-- Nút giảm -->
                            <form action="cart" method="post" style="display:inline;">
                                <input type="hidden" name="product_id" value="${item.productId}">
                                <input type="hidden" name="action" value="decrease">
                                <button type="submit">−</button>
                            </form>

                            <!-- Nhập số lượng -->
                            <form action="cart" method="post" style="display:inline;">
                                <input type="hidden" name="product_id" value="${item.productId}">
                                <input type="hidden" name="action" value="update">
                                <input type="number" name="quantity" value="${item.quantity}" min="1"
                                       onkeydown="if(event.key==='Enter'){this.form.submit();}">
                            </form>

                            <!-- Nút tăng -->
                            <form action="cart" method="post" style="display:inline;">
                                <input type="hidden" name="product_id" value="${item.productId}">
                                <input type="hidden" name="action" value="increase">
                                <button type="submit">+</button>
                            </form>
                        </div>
                    </td>

                    <!-- Cột Thành tiền -->
                    <td>
                        <div class="total-price">
                            <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true" /> VNĐ
                        </div>
                    </td>

                    <!-- Cột Hành động -->
                    <td>
                        <form action="cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="product_id" value="${item.productId}">
                            <button type="submit" class="btn btn-delete">Xóa</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div class="total">
            Tổng cộng: 
            <span style="color:#e91e63;">
                <fmt:formatNumber value="${cart.totalPrice}" type="number" groupingUsed="true" /> VNĐ
            </span>
        </div>

    </c:when>

    <c:otherwise>
        <p style="text-align:center; color:#555; font-size:18px;">
            Giỏ hàng của bạn hiện đang trống 😢
        </p>
    </c:otherwise>
</c:choose>

</body>
</html>

<%@page import="utils.PriceUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductSpec" %>

<%@include file="header.jsp" %>

<%
    Product product = (Product) request.getAttribute("product");
    if(product == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %></title>
    <style>
        :root {
            --bg: #eeeeee;
            --text: #1e1e1e;
            --panel: #ffffff;
            --border: #e1e1e1;
            --shadow: 0 10px 24px rgba(0, 0, 0, .08);
            --headerTop: #4a4a4a;
            --headerBottom: #2c2c2c;
            --chip: #f7f7f7;
            --red: #c70000;
        }
        * { box-sizing: border-box; }
        body { margin:0; font-family:system-ui,-apple-system,"Segoe UI",Roboto,Helvetica,Arial,sans-serif; color:var(--text); background: var(--bg);}
        .container { width:min(1040px,90%); margin:0 auto;}
        .product-detail { display:flex; flex-direction:column; align-items:center; gap:2rem; padding:2rem 0;}
        .product-detail__gallery { display:flex; flex-direction:column; align-items:center; gap:1rem; width:100%; max-width:500px;}
        .product-detail__thumb img { width:100%; border-radius:12px;}
        .product-detail__thumbs { display:flex; gap:0.5rem; justify-content:center;}
        .product-detail__thumbs img { width:60px; height:60px; object-fit:cover; border-radius:8px; cursor:pointer; border:2px solid transparent; transition:border 0.2s;}
        .product-detail__thumbs img.active { border-color: var(--red);}
        .product-detail__info { width:100%; max-width:600px; display:flex; flex-direction:column; gap:0.5rem; text-align:center;}
        .product-detail__name { font-size:2.2rem; font-weight:bold; margin-bottom:0.2rem;}
        .product-detail__prices { display:flex; align-items:center; gap:0.8rem; font-size:1.2rem; margin-bottom:0;}
        .product-detail__prices .old { text-decoration:line-through; color:#888;}
        .product-detail__prices .discount { background-color:#ff4d4f; color:#fff; padding:0.2rem 0.5rem; border-radius:8px; font-size:1rem;}
        .product-detail__new { font-size:1.8rem; color:#ff4d4f; font-weight:bold; margin-top:0.1rem;}
        .product-detail__specs { display:flex; flex-direction:column; gap:0.4rem; background:#f9f9f9; padding:1rem; border-radius:12px; text-align:left; margin-top:0.8rem;}
        .product-detail__specs h4 { margin:0 0 0.5rem 0; font-size:1.4rem; font-weight:bold;}
        .product-detail__specs p { margin:0;}
        .product-detail__actions { display:flex; gap:1rem; justify-content:center; margin-top:1rem; flex-wrap:wrap;}
        .product-detail__actions .pill { padding:0.7rem 1.2rem; border-radius:50px; text-decoration:none; text-align:center;}
        .btn-add { background-color:#ff4d4f; color:#fff;}
        .btn-back { background-color:#eee; color:#333;}
        .alert-success {
            color: green;
            background-color: #e9f9e9;
            border: 1px solid #b2e0b2;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: center;
            font-weight: bold;
        }
        @media (min-width:768px){
            .product-detail { flex-direction:row; justify-content:center; align-items:flex-start;}
            .product-detail__gallery { flex:1;}
            .product-detail__info { flex:1; text-align:left;}
            .product-detail__prices { justify-content:flex-start;}
            .product-detail__actions { justify-content:flex-start;}
        }
    </style>
</head>
<body>

<main class="container main">

    <!-- ✅ Thông báo thêm vào giỏ hàng -->
    <%
        String added = request.getParameter("added");
        if ("true".equals(added)) {
    %>
        <div class="alert-success">✅ Sản phẩm đã được thêm vào giỏ hàng!</div>
    <%
        }
    %>

    <section class="product-detail">
        <!-- Gallery -->
        <div class="product-detail__gallery">
            <div class="product-detail__thumb">
                <img id="mainImage" src="<%= product.getImages().get(0) %>" alt="<%= product.getName() %>"/>
            </div>
            <div class="product-detail__thumbs">
                <%
                    for(String img : product.getImages()){
                %>
                    <img src="<%= img %>" class="<%= img.equals(product.getImages().get(0)) ? "active" : "" %>" />
                <%
                    }
                %>
            </div>
        </div>

        <!-- Info -->
        <div class="product-detail__info">
            <h1 class="product-detail__name"><%= product.getName() %></h1>
            
            <!-- Giá cả -->
            <div class="product-detail__prices">
                <span class="old"><%= PriceUtil.handlePrice(product.getPrice_original()) %>đ</span>
                <span class="discount">-<%= product.getSale_rate() %>%</span>
            </div>
            <div class="product-detail__new"><%= PriceUtil.handlePrice(product.getPrice_promo()) %>đ</div>

            <!-- Thông số kỹ thuật -->
            <div class="product-detail__specs">
                <h4>Thông số kỹ thuật:</h4>
                <%
                    if(product.getSpecs() != null && !product.getSpecs().isEmpty()) {
                        for(ProductSpec spec : product.getSpecs()) {
                %>
                            <p><b><%= spec.getName() %>:</b> <%= spec.getValue() %></p>
                <%
                        }
                    } else {
                %>
                        <p>Chưa có thông số kỹ thuật.</p>
                <%
                    }
                %>
            </div>

            <!-- Actions -->
            <div class="product-detail__actions">
                <form action="add-to-cart" method="post" style="display:inline;">
                    <input type="hidden" name="product_id" value="<%= product.getId() %>">
                    <button type="submit" class="pill btn-add">Thêm vào giỏ hàng</button>
                </form>
                <a href="./home" class="pill btn-back">Quay lại</a>
            </div>
        </div>
    </section>
</main>

<script>
    const mainImage = document.getElementById('mainImage');
    const thumbs = document.querySelectorAll('.product-detail__thumbs img');
    thumbs.forEach(thumb => {
        thumb.addEventListener('click', () => {
            mainImage.src = thumb.src;
            thumbs.forEach(t => t.classList.remove('active'));
            thumb.classList.add('active');
        });
    });
</script>
</body>
</html>

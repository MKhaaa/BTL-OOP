<%@page import="utils.PriceUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductSpec" %>

<%@include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<%
    Product product = (Product) request.getAttribute("product");
    if(product == null){
        // Đổi hướng về trang chủ HỢP LỆ (chọn 1 trong 2 dòng dưới)
        response.sendRedirect(request.getContextPath() + "/home");
        // response.sendRedirect(request.getContextPath() + "/index.html");
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
        :root { --bg:#eeeeee; --text:#1e1e1e; --panel:#ffffff; --border:#e1e1e1; --shadow:0 10px 24px rgba(0,0,0,.08); --headerTop:#4a4a4a; --headerBottom:#2c2c2c; --chip:#f7f7f7; --red:#c70000;}
        *{box-sizing:border-box}
        body{margin:0;font-family:system-ui,-apple-system,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;color:var(--text);background:var(--bg)}
        .container{width:min(1040px,90%);margin:0 auto}
        .product-detail{display:flex;flex-direction:column;align-items:center;gap:2rem;padding:2rem 0}
        .product-detail__gallery{display:flex;flex-direction:column;align-items:center;gap:1rem;width:100%;max-width:500px}
        .product-detail__thumb img{width:100%;border-radius:12px}
        .product-detail__thumbs{display:flex;gap:.5rem;justify-content:center}
        .product-detail__thumbs img{width:60px;height:60px;object-fit:cover;border-radius:8px;cursor:pointer;border:2px solid transparent;transition:border .2s}
        .product-detail__thumbs img.active{border-color:var(--red)}
        .product-detail__info{width:100%;max-width:600px;display:flex;flex-direction:column;gap:.5rem;text-align:center}
        .product-detail__name{font-size:2.2rem;font-weight:bold;margin-bottom:.2rem}
        .product-detail__prices{display:flex;align-items:center;gap:.8rem;font-size:1.2rem;margin-bottom:0}
        .product-detail__prices .old{text-decoration:line-through;color:#888}
        .product-detail__prices .discount{background-color:#ff4d4f;color:#fff;padding:.2rem .5rem;border-radius:8px;font-size:1rem}
        .product-detail__new{font-size:1.8rem;color:#ff4d4f;font-weight:bold;margin-top:.1rem}
        .product-detail__specs{display:flex;flex-direction:column;gap:.4rem;background:#f9f9f9;padding:1rem;border-radius:12px;text-align:left;margin-top:.8rem}
        .product-detail__specs h4{margin:0 0 .5rem 0;font-size:1.4rem;font-weight:bold}
        .product-detail__specs p{margin:0}
        .product-detail__actions{display:flex;gap:1rem;justify-content:center;margin-top:1rem;flex-wrap:wrap}
        .product-detail__actions .pill{padding:.7rem 1.2rem;border-radius:50px;text-decoration:none;text-align:center}
        .btn-add{background-color:#ff4d4f;color:#fff}
        .btn-back{background-color:#eee;color:#333}
        .alert-success{color:green;background-color:#e9f9e9;border:1px solid #b2e0b2;padding:.5rem 1rem;border-radius:8px;margin-bottom:1rem;text-align:center;font-weight:bold}
        /* ===== Comments UI ===== */
        .comments{margin-top:24px;background:var(--panel);border:1px solid var(--border);
          border-radius:16px;box-shadow:var(--shadow);overflow:hidden}
        .comments__header{padding:16px 20px;font-weight:700;font-size:1.2rem;border-bottom:1px solid var(--border)}
        .comment-form{padding:16px 20px;display:grid;grid-template-columns:1fr auto;gap:12px}
        .comment-form select{border:1px solid var(--border);border-radius:10px;padding:10px}
        .comment-form textarea{grid-column:1/-1;min-height:96px;resize:vertical;border:1px solid var(--border);
          border-radius:12px;padding:12px}
        .btn{border:0;cursor:pointer;border-radius:999px;padding:10px 16px}
        .btn--primary{background:#ff4d4f;color:#fff}
        .btn--ghost{background:#f3f3f3}
        .comments__list{padding:0 20px 16px}
        .comment-item{display:flex;gap:12px;padding:14px 0;border-top:1px solid var(--border)}
        .comment-item:first-child{border-top:none}
        .avatar{width:40px;height:40px;border-radius:50%;background:#f1f1f1;display:flex;align-items:center;justify-content:center;font-weight:700}
        .cmeta{display:flex;align-items:center;gap:8px;flex-wrap:wrap}
        .cname{font-weight:700}
        .cdate{color:#777;font-size:.92rem}
        .stars{letter-spacing:2px;font-size:.95rem;color:#ffb400}
        .ccontent{margin:6px 0 0 0}
        .cactions button{background:transparent;border:0;color:#888;cursor:pointer}
        .cactions button:hover{color:#ff4d4f}

        @media (min-width:768px){
          .product-detail{flex-direction:row;justify-content:center;align-items:flex-start}
          .product-detail__gallery{flex:1}
          .product-detail__info{flex:1;text-align:left}
          .product-detail__prices{justify-content:flex-start}
          .product-detail__actions{justify-content:flex-start}
        }
    </style>
</head>
<body>

<main class="container main">

    <!-- Thông báo thêm vào giỏ hàng -->
    <%
        String added = request.getParameter("added");
        if ("true".equals(added)) {
    %>
        <div class="alert-success"> Sản phẩm đã được thêm vào giỏ hàng!</div>
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
    <!--  BÌNH LUẬN -->
    <a id="comments"></a>
    <div class="comments">
      <div class="comments__header">Bình luận</div>

      <!-- FORM -->
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <form method="post" action="${pageContext.request.contextPath}/comment/add" class="comment-form">
            <select name="rating" aria-label="Đánh giá">
              <option value="">Chọn đánh giá</option>
              <c:forEach var="i" begin="1" end="5">
                <option value="${i}">${i} sao</option>
              </c:forEach>
            </select>
            <button type="submit" class="btn btn--primary">Gửi</button>
            <input type="hidden" name="productId" value="${param.id}"/>
            <textarea name="content" placeholder="Chia sẻ cảm nhận của bạn..." required></textarea>
          </form>
        </c:when>
        <c:otherwise>
          <div style="padding:16px 20px">
            <a class="btn btn--ghost"
               href="${pageContext.request.contextPath}/login.jsp?returnUrl=${pageContext.request.contextPath}/product-detail?id=${param.id}">
              Đăng nhập để bình luận
            </a>
          </div>
        </c:otherwise>
      </c:choose>

      <!-- LIST -->
      <div class="comments__list">
        <c:forEach var="cmt" items="${comments}">
          <div class="comment-item">
            <div class="avatar">
              ${fn:toUpperCase(fn:substring(cmt.username,0,1))}
            </div>
            <div class="cbody" style="flex:1">
              <div class="cmeta">
                <span class="cname"><c:out value="${cmt.username}"/></span>
                <span class="stars">
                  <c:forEach var="i" begin="1" end="5">
                    <c:choose>
                      <c:when test="${cmt.rating != null && i <= cmt.rating}">★</c:when>
                      <c:otherwise>☆</c:otherwise>
                    </c:choose>
                  </c:forEach>
                </span>
                <span class="cdate">
                  • <fmt:formatDate value="${cmt.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                </span>
              </div>
              <p class="ccontent"><c:out value="${cmt.content}"/></p>

              <div class="cactions">
                <c:if test="${not empty sessionScope.user && sessionScope.user.id == cmt.userId}">
                  <form method="post" action="${pageContext.request.contextPath}/comment/delete" style="display:inline">
                    <input type="hidden" name="id" value="${cmt.id}"/>
                    <input type="hidden" name="productId" value="${param.id}"/>
                    <button type="submit" onclick="return confirm('Xoá bình luận này?')">Xoá</button>
                  </form>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>

        <c:if test="${empty comments}">
          <div style="padding:12px 0;color:#666"><i>Chưa có bình luận nào. Hãy là người đầu tiên!</i></div>
        </c:if>
      </div>
    </div>
    <!-- ========================================================= -->


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

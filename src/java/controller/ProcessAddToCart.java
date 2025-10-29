package controller;

import model.Cart;
import model.Product;
import model.User;
import dao.ProductDAO;
import dao.CartDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ProcessAddToCart", urlPatterns = {"/add-to-cart"})
public class ProcessAddToCart extends HttpServlet {

    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 1️⃣ Nếu chưa đăng nhập → về login
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = currentUser.getId();
        int productId = Integer.parseInt(request.getParameter("product_id"));

        // Lấy sản phẩm từ DB
        if (productDAO.getProductById(productId) == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 2️⃣ Kiểm tra sản phẩm đã có trong giỏ hàng DB chưa
        if (cartDAO.getCartItem(userId, productId) == null) {
            // Chưa có → thêm mới với số lượng 1
            cartDAO.insertItem(userId, productId, 1);
        } else {
            // Đã có → tăng số lượng lên 1
            int currentQuantity = cartDAO.getCartItem(userId, productId).getQuantity();
            cartDAO.updateQuantity(userId, productId, currentQuantity + 1);
        }

        // 3️⃣ Cập nhật session cart ngay lập tức
        session.setAttribute("cart", cartDAO.getCartByUserId(userId));

        // 4️⃣ Redirect về trang chi tiết sản phẩm
        response.sendRedirect("product-detail?id=" + productId + "&added=true");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}

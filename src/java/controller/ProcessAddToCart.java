package controller;

import model.CartItem;
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

        // Lấy product_id ngay từ đầu
        String productIdParam = request.getParameter("product_id");
        if (productIdParam == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int productId = Integer.parseInt(productIdParam);

        // 1. Chưa đăng nhập → điều hướng login + returnUrl
        if (currentUser == null) {
            String returnUrl = "./product-detail?id=" + productId;
            response.sendRedirect("./login?returnUrl=" + returnUrl);
            return;
        }

        int userId = currentUser.getId();

        // 2. Kiểm tra sản phẩm có tồn tại không
        if (productDAO.getProductById(productId) == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 3. Lấy item trong giỏ hàng 1 lần duy nhất
        CartItem item = cartDAO.getCartItem(userId, productId);

        if (item == null) {
            // Chưa có: thêm mới
            cartDAO.insertItem(userId, productId, 1);
        } else {
            // Đã có: cập nhật quantity
            cartDAO.updateQuantity(userId, productId, item.getQuantity() + 1);
        }

        // 4. Cập nhật session giỏ hàng
        session.setAttribute("cart", cartDAO.getCartByUserId(userId));

        // 5. Quay lại trang chi tiết
        response.sendRedirect("product-detail?id=" + productId + "&added=true");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không cho GET vào route này
        response.sendRedirect("index.jsp");
    }
}

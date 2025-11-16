package controller;

import dao.CommentDAO;
import dao.ProductDAO;
import model.Product;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import model.Comment;

@WebServlet(name = "ProcessProductDetail", urlPatterns = {"/product-detail"})
public class ProcessProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy id sản phẩm từ URL
        String idParam = request.getParameter("id");
        if(idParam == null || idParam.isEmpty()){
            response.sendRedirect("index.jsp"); // nếu không có id
            return;
        }

        int productId = 0;
        try{
            productId = Integer.parseInt(idParam);
        } catch(NumberFormatException e){
            response.sendRedirect("index.jsp"); // nếu id không hợp lệ
            return;
        }

        // Lấy sản phẩm từ DAO
        Product product = ProductDAO.getProductById(productId);
        if(product == null){
            response.sendRedirect("index.jsp"); // nếu không tìm thấy sản phẩm
            return;
        }

        // Đưa product vào request
        request.setAttribute("product", product);
	
	// ==== LẤY DANH SÁCH BÌNH LUẬN (thêm mới) ====
        try {
            List<Comment> comments = new CommentDAO().findByProductId(productId);
            request.setAttribute("comments", comments);
        } catch (Exception e) {
            throw new ServletException(e);
        }
        // ============================================

        // Forward tới JSP hiển thị chi tiết
        RequestDispatcher dispatcher = request.getRequestDispatcher("/product-detail.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // nếu không cần POST, có thể redirect về GET
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý chi tiết sản phẩm";
    }
}

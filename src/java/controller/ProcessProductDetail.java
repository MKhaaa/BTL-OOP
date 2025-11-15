package controller;

import dao.ProductDAO;
import dao.CommentDAO;        // <-- thêm
import model.Product;
import model.Comment;        // <-- thêm
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;        // <-- thêm

@WebServlet(name = "ProcessProductDetail", urlPatterns = {"/product-detail"})
public class ProcessProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
            return;
        }

        Product product = ProductDAO.getProductById(productId);
        if (product == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 1) Đưa product vào request
        request.setAttribute("product", product);

        // 2) LẤY BÌNH LUẬN & ĐƯA VÀO REQUEST (thêm đoạn này)
        try {
            List<Comment> comments = new CommentDAO().findByProductId(productId);
            request.setAttribute("comments", comments);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        // 3) Forward tới JSP hiển thị chi tiết
        RequestDispatcher dispatcher = request.getRequestDispatcher("/product-detail.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý chi tiết sản phẩm";
    }
}

package controller;

import dao.CommentDAO;
import dao.ProductDAO;
import model.Product;
import model.Comment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProcessProductDetail", urlPatterns = {"/product-detail"})
public class ProcessProductDetail extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        int productId = 0;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
            return;
        }

        Product product = productDAO.getProductById(productId);
        if (product == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        request.setAttribute("product", product);

        try {
            List<Comment> comments = new CommentDAO().findByProductId(productId);
            request.setAttribute("comments", comments);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/product-detail.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
package controller;

import dao.CommentDAO;
import model.Comment;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/comment/add")
public class ProcessAddComment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        User me = (User) req.getSession().getAttribute("user");
        String productIdStr = req.getParameter("productId");
        String content = req.getParameter("content");
        String ratingStr = req.getParameter("rating");
        String parentIdStr = req.getParameter("parentId"); // optional

        int productId = Integer.parseInt(productIdStr);

        // ⚠️ Chưa đăng nhập -> đưa về login và quay lại /product-detail
        if (me == null) {
            resp.sendRedirect(req.getContextPath()
                    + "/login.jsp?returnUrl=" + req.getContextPath()
                    + "/product-detail?id=" + productId);
            return;
        }

        // validate
        if (content == null || content.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath()
                    + "/product-detail?id=" + productId + "&err=empty");
            return;
        }
        if (content.length() > 2000) content = content.substring(0, 2000);

        Comment c = new Comment();
        c.setProductId(productId);
        c.setUserId(me.getId());
        c.setContent(content.trim());
        try { if (ratingStr != null && !ratingStr.isEmpty()) c.setRating(Integer.parseInt(ratingStr)); } catch (NumberFormatException ignore) {}
        try { if (parentIdStr != null && !parentIdStr.isEmpty()) c.setParentId(Integer.parseInt(parentIdStr)); } catch (NumberFormatException ignore) {}

        try {
            new CommentDAO().insert(c);
            // Quay lại trang chi tiết (servlet) và nhảy tới #comments
            resp.sendRedirect(req.getContextPath()
                    + "/product-detail?id=" + productId + "#comments");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

package controller;


import dao.CommentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

@WebServlet("/comment/delete")
public class ProcessDeleteComment extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User me = (User) req.getSession().getAttribute("user");
        int id = Integer.parseInt(req.getParameter("id"));
        int productId = Integer.parseInt(req.getParameter("productId"));
        if (me == null) {
            resp.sendRedirect(req.getContextPath()+"/login.jsp");
            return;
        }
        try {
            new CommentDAO().deleteByIdAndUser(id, me.getId());
             resp.sendRedirect(req.getContextPath()
                    + "/product-detail?id=" + productId + "#comments");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

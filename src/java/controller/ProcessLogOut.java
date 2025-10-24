
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

@WebServlet(name = "ProcessLogOut", urlPatterns = {"/logout"})
public class ProcessLogOut extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy session hiện tại (nếu có)
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Hủy session → đăng xuất người dùng
            session.invalidate();
        }

        // Chuyển hướng về trang đăng nhập
        response.sendRedirect("./home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Gọi chung cho cả GET và POST
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng xuất người dùng và điều hướng về trang đăng nhập";
    }
}

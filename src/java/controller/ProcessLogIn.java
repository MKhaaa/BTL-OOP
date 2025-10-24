
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import dao.UserDAO;
import model.User;

@WebServlet(name = "ProcessLogIn", urlPatterns = { "/login" })
public class ProcessLogIn extends HttpServlet {

    // Khi người dùng truy cập /login lần đầu -> hiển thị form đăng nhập
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Điều hướng sang trang login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Xử lý khi người dùng gửi form đăng nhập (method POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. Gọi DAO để tìm user theo username
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByUsername(username);

        // 3. Kiểm tra tồn tại user và verify password bằng BCrypt
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            // Đăng nhập thành công -> lưu user vào session
            request.getSession().setAttribute("user", user);

            // Điều hướng sang trang chính sau khi login
            response.sendRedirect("./home");
        } else {
            // Sai username hoặc password
            request.setAttribute("error", "Wrong username hoặc password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        // Mô tả servlet
        return "Xử lý đăng nhập người dùng";
    }
}

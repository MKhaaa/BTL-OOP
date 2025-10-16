package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

// Xử lý đặt lại mật khẩu qua link token (Forgot Password workflow)
@WebServlet(name = "ProcessResetPassword", urlPatterns = { "/reset-password" })
public class ProcessResetPassword extends HttpServlet {

    /**
     * Hiển thị form reset password (reset-password.jsp) khi người dùng click link trong email.
     * Link có dạng: /reset-password?token=...
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy token từ URL
        String token = request.getParameter("token");

        // Token rỗng hoặc không có -> link không hợp lệ
        if (token == null || token.isEmpty()) {
            request.setAttribute("message", "Invalid reset link!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findUserByResetToken(token);

        // Token không tồn tại hoặc đã hết hạn -> báo lỗi
        if (user == null) {
            request.setAttribute("message", "Invalid or expired token!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Truyền token cho trang reset-password.jsp để submit lại
        request.setAttribute("token", token);
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    // Khi người dùng gửi form đặt mật khẩu mới (POST từ reset-password.jsp)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");

        // Kiểm tra thiếu token hoặc password
        if (token == null || token.isEmpty() ||
                newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("message", "Missing data!");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findUserByResetToken(token);

        // Token không tồn tại hoặc đã hết hạn
        if (user == null) {
            request.setAttribute("message", "Invalid or expired token!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Hash mật khẩu mới
        String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        userDAO.updatePassword(user.getId(), hashed);

        // Xoá token sau khi dùng xong
        userDAO.deleteResetToken(user.getId());

        // Thông báo thành công
        request.setAttribute("message", "Password reset successful! You can login now.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dao.EmailDAO;
import model.User;

@WebServlet(name = "ProcessForgotPassword", urlPatterns = { "/forgot-password" })
public class ProcessForgotPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Điều hướng đến trang nhập email
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy email từ form
        String email = request.getParameter("email");

        // 2. Khởi tạo DAO để truy vấn DB
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByEmail(email); // Kiểm tra xem email có tồn tại không

        if (user == null) {
            // Trường hợp email không tồn tại
            request.setAttribute("message", "Email does not exist!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // 3. Nếu email tồn tại → tạo token reset password
        String token = UUID.randomUUID().toString(); // Token random
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000); // Hiệu lực 30 phút

        // 4. Lưu token + thời gian hết hạn vào bảng password_resets
        userDAO.createResetRequest(user.getId(), token, expiry);

        // 5. Tạo link reset có gắn token
        String resetLink = "http://localhost:8080/web/reset-password?token=" + token;

        // 6. Gửi email chứa link reset password
        EmailDAO emailDAO = new EmailDAO();
        emailDAO.sendResetLink(user.getEmail(), resetLink);

        // 7. Báo lại cho người dùng biết
        request.setAttribute("message", "Please check your email to reset your password!");
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
}
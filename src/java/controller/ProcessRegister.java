
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

// Servlet xử lý đăng ký tài khoản người dùng.
@WebServlet(name = "ProcessRegister", urlPatterns = { "/register" })
public class ProcessRegister extends HttpServlet {

    // Hiển thị form đăng ký (register.jsp) khi truy cập bằng GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    // Xử lý form đăng ký khi người dùng nhấn nút Submit (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String rawPassword = request.getParameter("password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        // 2. Hash mật khẩu bằng BCrypt
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

        UserDAO userDAO = new UserDAO();

        // 3. Kiểm tra trùng username
        if (userDAO.findByUsername(username) != null) {
            request.setAttribute("message", "Username already exists!");
        }
        // 4. Kiểm tra trùng email
        else if (userDAO.findByEmail(email) != null) {
            request.setAttribute("message", "Email is already registered!");
        }
        // 5. Nếu không trùng -> tiến hành lưu user
        else {
            User user = new User();
            user.setUsername(username);
            user.setPassword(hashedPassword);
            user.setEmail(email);
            user.setFirstName(firstName);
            user.setLastName(lastName);

            userDAO.addUser(user);
            request.setAttribute("message", "Registration successful! You can login now.");
        }

        // Dù thành công hay lỗi vẫn quay lại trang register.jsp để hiển thị message
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng ký";
    }
}

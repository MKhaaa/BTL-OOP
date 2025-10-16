package dao;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class EmailDAO {

    private final String fromEmail = "Send_email"; // Email gửi đi link reset mật khẩu
    private final String appPassword = "Email_app_password"; // Mật khẩu ứng dụng của Email

    // toEmail: Email người nhận
    // resetLink: URL đặt lại mật khẩu có token
    public void sendResetLink(String toEmail, String resetLink) {

        // Cấu hình SMTP server của Gmail (Gần như cố định)
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // Server SMTP
        props.put("mail.smtp.port", "587"); // Cổng TLS
        props.put("mail.smtp.auth", "true"); // Bật xác thực
        props.put("mail.smtp.starttls.enable", "true"); // Bật mã hóa TLS

        // Đăng nhập vào SMTP bằng email + app password
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        };

        try {
            // Tạo phiên gửi với cấu hình và xác thực
            Session session = Session.getInstance(props, auth);

            // Tạo email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail)); // Email người gửi
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            message.setSubject("Password Reset Request");
            message.setText("Click the link below to reset your password:\n\n" + resetLink);

            // Gửi email
            Transport.send(message);

            System.out.println("Reset link sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to send email", e);
        }
    }
}
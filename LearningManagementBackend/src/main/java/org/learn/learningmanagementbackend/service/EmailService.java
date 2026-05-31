package org.learn.learningmanagementbackend.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    public void sendTenantWelcomeEmail(String to, String schoolName, String adminName, String password, String loginUrl) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setSubject("Thông tin tài khoản School Admin - " + schoolName);

            String htmlContent = "<h2>Xin chào " + adminName + ",</h2>"
                    + "<p>Trường/Trung tâm <b>" + schoolName + "</b> của bạn đã được khởi tạo thành công trên hệ thống quản lý.</p>"
                    + "<p>Dưới đây là thông tin tài khoản đăng nhập của bạn:</p>"
                    + "<ul>"
                    + "<li><b>Email (Tài khoản):</b> " + to + "</li>"
                    + "<li><b>Mật khẩu mặc định:</b> " + password + "</li>"
                    + "</ul>"
                    + "<p>Vui lòng đăng nhập vào hệ thống theo đường dẫn sau và đổi mật khẩu trong lần đăng nhập đầu tiên:</p>"
                    + "<p><a href='" + loginUrl + "'>" + loginUrl + "</a></p>"
                    + "<br><p>Trân trọng,</p><p>Đội ngũ hỗ trợ SaaS</p>";

            helper.setText(htmlContent, true);
            
            // To prevent blocking the thread or failing the request if email is not configured properly
            new Thread(() -> {
                try {
                    mailSender.send(message);
                    System.out.println("Email sent successfully to: " + to);
                } catch (Exception e) {
                    System.err.println("Failed to send email to " + to + ": " + e.getMessage());
                }
            }).start();

        } catch (MessagingException e) {
            System.err.println("Failed to build email message: " + e.getMessage());
        }
    }
}

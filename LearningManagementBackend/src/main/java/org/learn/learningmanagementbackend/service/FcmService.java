package org.learn.learningmanagementbackend.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class FcmService {

    /**
     * Gửi Push Notification đến một thiết bị cụ thể.
     *
     * @param targetToken Token của thiết bị nhận (FCM Token)
     * @param title       Tiêu đề thông báo
     * @param body        Nội dung thông báo
     * @param data        Dữ liệu kèm theo (tùy chọn)
     * @return true nếu gửi thành công, false nếu có lỗi
     */
    public boolean sendNotificationToUser(String targetToken, String title, String body, Map<String, String> data) {
        if (targetToken == null || targetToken.trim().isEmpty()) {
            System.err.println("❌ FCM Token không hợp lệ. Bỏ qua gửi thông báo.");
            return false;
        }

        try {
            Notification notification = Notification.builder()
                    .setTitle(title)
                    .setBody(body)
                    .build();

            Message.Builder messageBuilder = Message.builder()
                    .setToken(targetToken)
                    .setNotification(notification);

            if (data != null && !data.isEmpty()) {
                messageBuilder.putAllData(data);
            }

            Message message = messageBuilder.build();

            String response = FirebaseMessaging.getInstance().send(message);
            System.out.println("✅ Đã gửi FCM Notification thành công: " + response);
            return true;
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi gửi FCM Notification:");
            e.printStackTrace();
            return false;
        }
    }
}

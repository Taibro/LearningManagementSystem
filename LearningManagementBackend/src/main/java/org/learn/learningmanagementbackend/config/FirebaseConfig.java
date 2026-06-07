package org.learn.learningmanagementbackend.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Configuration;
import javax.annotation.PostConstruct;
import java.io.InputStream;

@Configuration
public class FirebaseConfig {

    @PostConstruct
    public void initialize() {
        try {
            // Đọc file chìa khóa từ thư mục resources
            InputStream serviceAccount = this.getClass().getClassLoader()
                    .getResourceAsStream("firebase-adminsdk.json");

            if (serviceAccount == null) {
                System.err.println("❌ Không tìm thấy file cấu hình Firebase (firebase-adminsdk.json) trong thư mục resources!");
                return;
            }

            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            // Khởi động Firebase Admin
            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println("✅ Firebase Admin SDK đã khởi động thành công!");
            }
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi khởi động Firebase Admin SDK:");
            e.printStackTrace();
        }
    }
}

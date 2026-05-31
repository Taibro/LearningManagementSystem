import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbCheck {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/quan_ly_lop_hoc";
        String user = "root";
        String password = "123456";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement()) {
            
            System.out.println("--- ALL TABLES ---");
            ResultSet rs = stmt.executeQuery("SHOW TABLES");
            while(rs.next()){
                System.out.println(rs.getString(1));
            }
            
            System.out.println("--- SCHOOLS ---");
            ResultSet rs3 = stmt.executeQuery("SELECT id, name FROM school");
            while(rs3.next()){
                System.out.println(rs3.getInt("id") + " | " + rs3.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

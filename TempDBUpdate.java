import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class TempDBUpdate {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobile_store", "root", "root");
            Statement stmt = conn.createStatement();
            
            try {
                stmt.execute("ALTER TABLE orders ADD COLUMN assigned_to VARCHAR(150)");
                System.out.println("assigned_to added");
            } catch (Exception e) {}
            
            try {
                stmt.execute("ALTER TABLE orders ADD COLUMN estimated_delivery VARCHAR(100)");
                System.out.println("estimated_delivery added");
            } catch (Exception e) {}
            
            conn.close();
            System.out.println("Done.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

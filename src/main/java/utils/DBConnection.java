package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Get values from Railway environment variables
            String rawUrl = System.getenv("DB_URL");   // Railway gives mysql://...
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            // Convert Railway URL → JDBC format
            String url = rawUrl.replace("mysql://", "jdbc:mysql://") 
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            connection = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Database connection failed!");
        }

        return connection;
    }
}
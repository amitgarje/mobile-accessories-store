package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import utils.DBConnection;

public class UserDAO {

    public boolean registerUser(User user) {
        boolean isSuccess = false;
        String query = "INSERT INTO users (name, email, password, role, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            // In production, encrypt password here
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getRole() != null ? user.getRole() : "customer");
            pstmt.setDouble(5, user.getLatitude());
            pstmt.setDouble(6, user.getLongitude());
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.err.println("Registration failed for: " + user.getEmail() + " Role: " + user.getRole());
            e.printStackTrace();
        }
        return isSuccess;
    }

    public User loginUser(String email, String password) {
        User user = null;
        String query = "SELECT * FROM users WHERE email=? AND password=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setLatitude(rs.getDouble("latitude"));
                    user.setLongitude(rs.getDouble("longitude"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public java.util.List<User> getUsersByRole(String role) {
        java.util.List<User> users = new java.util.ArrayList<>();
        String query = "SELECT * FROM users WHERE role=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, role);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setLatitude(rs.getDouble("latitude"));
                    user.setLongitude(rs.getDouble("longitude"));
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
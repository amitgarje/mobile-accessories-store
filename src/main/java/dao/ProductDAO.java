package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DBConnection;

public class ProductDAO {

    public List<Product> getAllProducts() {
        return getProducts(0); // 0 means no limit
    }

    public List<Product> getProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products ORDER BY created_at DESC";
        if (limit > 0) {
            query += " LIMIT " + limit;
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = mapProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE category=? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, category);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = mapProduct(rs);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setCategory(rs.getString("category"));
        product.setImage(rs.getString("image"));
        product.setStock(rs.getInt("stock"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        return product;
    }

    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT * FROM products WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setCategory(rs.getString("category"));
                    product.setImage(rs.getString("image"));
                    product.setStock(rs.getInt("stock"));
                    product.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public boolean addProduct(Product product) {
        boolean isSuccess = false;
        String query = "INSERT INTO products (name, description, price, category, image, stock) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setString(4, product.getCategory());
            pstmt.setString(5, product.getImage());
            pstmt.setInt(6, product.getStock());
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public boolean updateProduct(Product product) {
        boolean isSuccess = false;
        String query = "UPDATE products SET name=?, description=?, price=?, category=?, image=?, stock=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setString(4, product.getCategory());
            pstmt.setString(5, product.getImage());
            pstmt.setInt(6, product.getStock());
            pstmt.setInt(7, product.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public boolean deleteProduct(int id) {
        boolean isSuccess = false;
        String query = "DELETE FROM products WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public List<Product> getLowStockProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE stock < 10 ORDER BY stock ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}

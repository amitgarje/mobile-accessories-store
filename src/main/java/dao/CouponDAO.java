package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Coupon;
import utils.DBConnection;

public class CouponDAO {

    public Coupon getCouponByCode(String code) {
        Coupon coupon = null;
        String query = "SELECT * FROM coupons WHERE code = ? AND active = TRUE";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return null;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, code);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        coupon = new Coupon();
                        coupon.setId(rs.getInt("id"));
                        coupon.setCode(rs.getString("code"));
                        coupon.setType(rs.getString("type"));
                        coupon.setValue(rs.getDouble("value"));
                        coupon.setMinOrder(rs.getDouble("min_order"));
                        coupon.setActive(rs.getBoolean("active"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupon;
    }
}

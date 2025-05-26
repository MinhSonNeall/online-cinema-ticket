/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Entity.Users;
import Entity.Users.Roles;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;

/**
 *
 * @author HP
 */
public class DaoUser extends DBContext{
    
public boolean login(String email, String password) {
    String sql = "SELECT * FROM movie_ticketing.users WHERE email = ? AND password = ?";
    try (PreparedStatement pre = conn.prepareStatement(sql)) {
        pre.setString(1, email);
        pre.setString(2, password);
        try (ResultSet rs = pre.executeQuery()) {
            return rs.next();
        }
    } catch (SQLException ex) {
        Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, null, ex);
        return false;
    }
}
    public Users.Roles checkRole(String email) {
        String sql = "SELECT role FROM movie_ticketing.users WHERE email = ?";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, email);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    String roleStr = rs.getString("role");
                    try {
                        return Users.Roles.valueOf(roleStr.toUpperCase());
                    } catch (IllegalArgumentException e) {
                        Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Invalid role value: " + roleStr, e);
                        return null; // Hoặc trả về Users.Roles.GUEST làm mặc định
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null; // Trả về null nếu không tìm thấy user hoặc có lỗi
    }
    
}

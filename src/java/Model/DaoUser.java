/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Entity.Users;
import Entity.Users.Roles;
import java.sql.Timestamp;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author HP
 */
public class DaoUser extends DBContext {

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
                        return null;
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null; // Trả về null nếu không tìm thấy user hoặc có lỗi
    }

public Vector<Users> getuserData(String email) {
    Vector<Users> data = new Vector<>();
    String sql = "SELECT user_id, email, full_name, phone_number, role, created_at, updated_at " +
                "FROM movie_ticketing.users WHERE email = ?";
    
    try (PreparedStatement statement = conn.prepareStatement(sql, 
            ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE)) {
        statement.setString(1, email);
        try (ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                String user_id = rs.getString("user_id");
                String user_email = rs.getString("email");
                String full_name = rs.getString("full_name");
                String phone_number = rs.getString("phone_number");
                String roletype = rs.getString("role");
                Roles role = Roles.valueOf(roletype.toUpperCase());
                Timestamp created_at = rs.getTimestamp("created_at");
                Timestamp updated_at = rs.getTimestamp("updated_at");
                
                // Truyền null cho password vì không lấy từ database
                Users user = new Users(user_id, user_email, null, full_name, 
                                     phone_number, role, created_at, updated_at);
                data.add(user);
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, 
            "Error fetching user data for email: " + email, ex);
    } catch (IllegalArgumentException ex) {
        Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, 
            "Invalid role value for email: " + email, ex);
    }
    
    return data;
}
    

}

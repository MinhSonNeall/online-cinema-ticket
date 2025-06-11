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
import java.util.Properties;
import java.util.Random;
import java.util.Vector;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


/**
 *
 * @author HP
 */
public class DaoUser extends DBContext {
    PreparedStatement ps;
    ResultSet rs;

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
public Vector<Users> listAllUser(){
    Vector<Users> list = new Vector<>();
    String sql="select * from movie_ticketing.users";
     
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                String user_id = rs.getString("user_id");
                String user_email = rs.getString("email");
                String full_name = rs.getString("full_name");
                String phone_number = rs.getString("phone_number");
                String roletype = rs.getString("role");
                Roles role = Roles.valueOf(roletype.toUpperCase());
                Timestamp created_at = rs.getTimestamp("created_at");
                Timestamp updated_at = rs.getTimestamp("updated_at");
                 Users user = new Users(user_id, user_email, null, full_name, 
                                     phone_number, role, created_at, updated_at);
                 list.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, null, ex);
        }
           return list; 
}
    public String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Generate 6-digit OTP
        return String.valueOf(otp);
        // Apppassword xgfs dqfr pdpy icrr

    }
     public void sendVerificationEmail(String sentTo, String otp) {
        final String username = "sonvd74@gmail.com"; // Update with your email address
        final String password = "xgfs dqfr pdpy icrr"; // Update with your email password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(sentTo));
            message.setSubject("Email Verification");
            message.setContent("<h1>Email verification</h1><p>Your OTP is: " + otp + "</p>", "text/html");

            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (MessagingException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    public boolean createUser(Users user) {
        String sql = "INSERT INTO movie_ticketing.users (user_id, email, password, full_name, phone_number, role, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, user.getUser_id());
            pre.setString(2, user.getEmail());
            pre.setString(3, user.getPassword());
            pre.setString(4, user.getFull_name());
            pre.setString(5, user.getPhone_number());
            pre.setString(6, user.getRole().name()); // Assuming role is an enum and needs its name
            pre.setTimestamp(7, user.getCreated_at());
            pre.setTimestamp(8, user.getUpdated_at());
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error creating user: " + user.getEmail(), ex);
            return false;
        }
    }

}

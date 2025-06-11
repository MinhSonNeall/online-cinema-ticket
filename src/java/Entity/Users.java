/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.sql.Timestamp;
import java.util.UUID; // Import UUID

/**
 *
 * @author HP
 */

public class Users {

    public enum Roles { // Đổi tên Enum thành Role để trùng với tên cột
        GUEST,
        CUSTOMER,
        STAFF,
        ADMIN
    }

    private String user_id;     // Đổi tên biến
    private String email;
    private String password;
    private String full_name;   // Đổi tên biến
    private String phone_number; // Đổi tên biến
    private Roles role;          // Đổi tên biến và kiểu Enum
    private Timestamp created_at; // Đổi tên biến
    private Timestamp updated_at; // Đổi tên biến

    // Constructor mặc định
    public Users() {
    }

    // Constructor với tất cả các trường, bao gồm user_id
    public Users(String user_id, String email, String password,
            String full_name, String phone_number, Roles role,
            Timestamp created_at, Timestamp updated_at) {
        this.user_id = user_id;
        this.email = email;
        this.password = password;
        this.full_name = full_name;
        this.phone_number = phone_number;
        this.role = role;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    // Constructor để tạo User mới, tự động tạo user_id từ email
    public Users(String email, String password,
            String full_name, String phone_number, Roles role,
            Timestamp created_at, Timestamp updated_at) {
        this.user_id = UUID.nameUUIDFromBytes(email.getBytes()).toString(); // Generate UUID from email
        this.email = email;
        this.password = password;
        this.full_name = full_name;
        this.phone_number = phone_number;
        this.role = role;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    // Getters và Setters (cần cập nhật tên phương thức)
    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public Roles getRole() {
        return role;
    }

    public void setRole(Roles role) {
        this.role = role;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    @Override
    public String toString() {
        return "User{"
                + "user_id='" + user_id + '\''
                + ", email='" + email + '\''
                + ", full_name='" + full_name + '\''
                + ", phone_number='" + (phone_number != null ? phone_number : "null") + '\''
                + ", role=" + role
                + ", created_at=" + created_at
                + ", updated_at=" + updated_at
                + '}';
    }
}

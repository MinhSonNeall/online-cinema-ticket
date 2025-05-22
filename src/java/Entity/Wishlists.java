/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
import java.sql.Timestamp;

public class Wishlists { // Tên class vẫn là 'Wishlists'

    private String wishlist_id; // Đã đổi tên biến từ watchlist_id thành wishlist_id
    private String user_id;
    private String movie_id;
    private Timestamp added_at;

    // Constructor mặc định
    public Wishlists() {
    }

    // Constructor với tất cả các trường
    public Wishlists(String wishlist_id, String user_id, String movie_id, Timestamp added_at) { // Cập nhật tham số
        this.wishlist_id = wishlist_id;
        this.user_id = user_id;
        this.movie_id = movie_id;
        this.added_at = added_at;
    }

    // Getters và Setters

    public String getWishlist_id() { // Đã đổi tên getter
        return wishlist_id;
    }

    public void setWishlist_id(String wishlist_id) { // Đã đổi tên setter
        this.wishlist_id = wishlist_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public Timestamp getAdded_at() {
        return added_at;
    }

    public void setAdded_at(Timestamp added_at) {
        this.added_at = added_at;
    }

    @Override
    public String toString() {
        return "Wishlists{" +
               "wishlist_id='" + wishlist_id + '\'' + // Cập nhật toString
               ", user_id='" + user_id + '\'' +
               ", movie_id='" + movie_id + '\'' +
               ", added_at=" + added_at +
               '}';
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
import java.math.BigDecimal;
import java.sql.Timestamp; // Sử dụng Timestamp cho DATETIME

public class Showtimes { // Tên class giữ nguyên là 'Showtimes'

    private String showtime_id;
    private String movie_id;
    private String room_id;
    private Timestamp start_time; // Ánh xạ DATETIME
    private Timestamp end_time;   // Ánh xạ DATETIME
    private BigDecimal ticket_price;
    
    private String showtimeId;
    private String time;
    private String ticketPrice;
    private int remainingSeats;

    // Constructor mặc định
    public Showtimes() {
    }

    // Constructor với tất cả các trường
    public Showtimes(String showtime_id, String movie_id, String room_id, 
                     Timestamp start_time, Timestamp end_time, BigDecimal ticket_price) {
        this.showtime_id = showtime_id;
        this.movie_id = movie_id;
        this.room_id = room_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.ticket_price = ticket_price;
    }

    public Showtimes(String showtimeId, String time, String ticketPrice, int remainingSeats) {
        this.showtimeId = showtimeId;
        this.time = time;
        this.ticketPrice = ticketPrice;
        this.remainingSeats = remainingSeats;
    }
    
    
    public String getShowtimeId() { return showtimeId; }
    public String getTime() { return time; }
    public String getTicketPrice() { return ticketPrice; }
    public int getRemainingSeats() { return remainingSeats; }
    
    
    // Getters và Setters

    public String getShowtime_id() {
        return showtime_id;
    }

    public void setShowtime_id(String showtime_id) {
        this.showtime_id = showtime_id;
    }

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    public Timestamp getStart_time() {
        return start_time;
    }

    public void setStart_time(Timestamp start_time) {
        this.start_time = start_time;
    }

    public Timestamp getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Timestamp end_time) {
        this.end_time = end_time;
    }

    public BigDecimal getTicket_price() {
        return ticket_price;
    }

    public void setTicket_price(BigDecimal ticket_price) {
        this.ticket_price = ticket_price;
    }

    @Override
    public String toString() {
        return "Showtimes{" +
               "showtime_id='" + showtime_id + '\'' +
               ", movie_id='" + movie_id + '\'' +
               ", room_id='" + room_id + '\'' +
               ", start_time=" + start_time +
               ", end_time=" + end_time +
               ", ticket_price=" + ticket_price +
               '}';
    }
}
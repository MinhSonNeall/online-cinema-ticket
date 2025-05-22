/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.math.BigDecimal;
import java.sql.Timestamp;


/**
 *
 * @author HP
 */
public class Tickets {
    private String ticket_id,user_id,showtime_id,qr_code;
    private Timestamp booking_date;
    private BigDecimal total_ammount;
      public enum BookingStatus {
        PENDING,
        CONFIRMED,
        CANCELLED,
        COMPLETED
    }
      private BookingStatus status;

    public Tickets() {
    }

    public Tickets(String ticket_id, String user_id, String showtime_id, String qr_code, Timestamp booking_date, BigDecimal total_ammount, BookingStatus status) {
        this.ticket_id = ticket_id;
        this.user_id = user_id;
        this.showtime_id = showtime_id;
        this.qr_code = qr_code;
        this.booking_date = booking_date;
        this.total_ammount = total_ammount;
        this.status = status;
    }

    public String getBooking_id() {
        return ticket_id;
    }

    public void setBooking_id(String booking_id) {
        this.ticket_id = booking_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getShowtime_id() {
        return showtime_id;
    }

    public void setShowtime_id(String showtime_id) {
        this.showtime_id = showtime_id;
    }

    public String getQr_code() {
        return qr_code;
    }

    public void setQr_code(String qr_code) {
        this.qr_code = qr_code;
    }

    public Timestamp getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(Timestamp booking_date) {
        this.booking_date = booking_date;
    }

    public BigDecimal getTotal_ammount() {
        return total_ammount;
    }

    public void setTotal_ammount(BigDecimal total_ammount) {
        this.total_ammount = total_ammount;
    }

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }
    
      
}

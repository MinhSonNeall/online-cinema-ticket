/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Ticket_Seats {

    private String ticket_id; // Đã đổi tên biến từ booking_id thành ticket_id
    private String seat_id;

    // Constructor mặc định
    public Ticket_Seats() {
    }

    // Constructor với tất cả các trường
    public Ticket_Seats(String ticket_id, String seat_id) { // Cập nhật tham số constructor
        this.ticket_id = ticket_id;
        this.seat_id = seat_id;
    }

    // Getters và Setters

    public String getTicket_id() { // Đã đổi tên getter
        return ticket_id;
    }

    public void setTicket_id(String ticket_id) { // Đã đổi tên setter
        this.ticket_id = ticket_id;
    }

    public String getSeat_id() {
        return seat_id;
    }

    public void setSeat_id(String seat_id) {
        this.seat_id = seat_id;
    }

    @Override
    public String toString() {
        return "Ticket_Seats{" +
               "ticket_id='" + ticket_id + '\'' + // Cập nhật toString
               ", seat_id='" + seat_id + '\'' +
               '}';
    }
}

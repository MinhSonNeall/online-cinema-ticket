/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Ticket_Concessions { // Đã đổi tên class thành 'Ticket_Concessions'

    private String ticket_id;    // Đã đổi tên biến từ booking_id thành ticket_id
    private String concession_id;
    private int quantity;

    // Constructor mặc định
    public Ticket_Concessions() {
    }

    // Constructor với tất cả các trường
    public Ticket_Concessions(String ticket_id, String concession_id, int quantity) { // Cập nhật tham số
        this.ticket_id = ticket_id;
        this.concession_id = concession_id;
        this.quantity = quantity;
    }

    // Getters và Setters

    public String getTicket_id() { // Đã đổi tên getter
        return ticket_id;
    }

    public void setTicket_id(String ticket_id) { // Đã đổi tên setter
        this.ticket_id = ticket_id;
    }

    public String getConcession_id() {
        return concession_id;
    }

    public void setConcession_id(String concession_id) {
        this.concession_id = concession_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Ticket_Concessions{" +
               "ticket_id='" + ticket_id + '\'' + // Cập nhật toString
               ", concession_id='" + concession_id + '\'' +
               ", quantity=" + quantity +
               '}';
    }
}
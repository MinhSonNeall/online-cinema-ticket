/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Rooms { // Giữ nguyên tên class là 'Rooms'

    private String room_id;
    private String cinema_id;
    private String name;
    private int total_seats;

    // Constructor mặc định
    public Rooms() {
    }

    // Constructor với tất cả các trường
    public Rooms(String room_id, String cinema_id, String name, int total_seats) {
        this.room_id = room_id;
        this.cinema_id = cinema_id;
        this.name = name;
        this.total_seats = total_seats;
    }

    // Getters và Setters

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    public String getCinema_id() {
        return cinema_id;
    }

    public void setCinema_id(String cinema_id) {
        this.cinema_id = cinema_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTotal_seats() {
        return total_seats;
    }

    public void setTotal_seats(int total_seats) {
        this.total_seats = total_seats;
    }

    @Override
    public String toString() {
        return "Rooms{" +
               "room_id='" + room_id + '\'' +
               ", cinema_id='" + cinema_id + '\'' +
               ", name='" + name + '\'' +
               ", total_seats=" + total_seats +
               '}';
    }
}

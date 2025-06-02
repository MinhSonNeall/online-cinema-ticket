/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Seats { // Tên class giữ nguyên là 'Seats'

    public enum Type { // Enum cho trường 'type'
        STANDARD, // Ánh xạ 'standard'
        VIP       // Ánh xạ 'vip'
    }

    private String seat_id;
    private String room_id;
    private String seat_number;
    private Type type; // Sử dụng Enum Type
    
    
    private String seatId;
    private String name;
    private String types;
    private double price;
    private boolean booked;
    private boolean selected;

    // Constructor mặc định
    public Seats() {
    }

    // Constructor với tất cả các trường
    public Seats(String seat_id, String room_id, String seat_number, Type type) {
        this.seat_id = seat_id;
        this.room_id = room_id;
        this.seat_number = seat_number;
        this.type = type;
    }

    
    
    public Seats(String seatId, String name, String types, double price, boolean booked, boolean selected) {
        this.seatId = seatId;
        this.name = name;
        this.types = types;
        this.price = price;
        this.booked = booked;
        this.selected = selected;
    }

    public String getSeatId() { return seatId; }
    public String getName() { return name; }
    public String getTypes() { return types; }
    public double getPrice() { return price; }
    public boolean isBooked() { return booked; }
    public boolean isSelected() { return selected; }
    // Getters và Setters

    public String getSeat_id() {
        return seat_id;
    }

    public void setSeat_id(String seat_id) {
        this.seat_id = seat_id;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    public String getSeat_number() {
        return seat_number;
    }

    public void setSeat_number(String seat_number) {
        this.seat_number = seat_number;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Seats{" +
               "seat_id='" + seat_id + '\'' +
               ", room_id='" + room_id + '\'' +
               ", seat_number='" + seat_number + '\'' +
               ", type=" + type +
               '}';
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.security.Timestamp;

/**
 *
 * @author Cuong
 */
public class ShowtimeSlot {
    private String slot_id;
    private String showtime_id;
    private DateItem date; // Ánh xạ DATETIME
    private String start_time;   // Ánh xạ DATETIME
    private String end_time;   // Ánh xạ DATETIME
    private String seat_avaiable;
    private String price;
    private String city;
    private String room_id;

    public ShowtimeSlot() {
    }

    public ShowtimeSlot(String slot_id, String showtime_id, DateItem date, String start_time, String end_time) {
        this.slot_id = slot_id;
        this.showtime_id = showtime_id;
        this.date = date;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    
    public ShowtimeSlot(String start_time, String end_time) {
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public ShowtimeSlot(String slot_id, String showtime_id, DateItem date, String start_time, String end_time, String seat_avaiable, String price) {
        this.slot_id = slot_id;
        this.showtime_id = showtime_id;
        this.date = date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.seat_avaiable = seat_avaiable;
        this.price = price;
    }

    public ShowtimeSlot(String start_time, String end_time, String seat_avaiable, String price,String slot_id,String city,String room_id) {
        this.start_time = start_time;
        this.end_time = end_time;
        this.seat_avaiable = seat_avaiable;
        this.price = price;
        this.slot_id = slot_id;
        this.city = city;
        this.room_id = room_id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    
    public String getSeat_avaiable() {
        return seat_avaiable;
    }

    public void setSeat_avaiable(String seat_avaiable) {
        this.seat_avaiable = seat_avaiable;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
    
    

    public String getSlot_id() {
        return slot_id;
    }

    public void setSlot_id(String slot_id) {
        this.slot_id = slot_id;
    }

    public String getShowtime_id() {
        return showtime_id;
    }

    public void setShowtime_id(String showtime_id) {
        this.showtime_id = showtime_id;
    }

    public DateItem getDate() {
        return date;
    }

    public void setDate(DateItem date) {
        this.date = date;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }
    
    
    
    
}

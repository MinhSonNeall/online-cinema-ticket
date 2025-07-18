/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author Cuong
 */
public class InfomationMovie {
    private String name;
    private String start_time;   // Ánh xạ DATETIME
    private String end_time;
    private String avaiable_seat;
    private String price;
    private String showtime_id;

    public InfomationMovie() {
    }

    public InfomationMovie(String name, String start_time, String end_time) {
        this.name = name;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public InfomationMovie(String name, String start_time, String end_time, String avaiable_seat,String showtime_id) {
        this.name = name;
        this.start_time = start_time;
        this.end_time = end_time;
        this.avaiable_seat = avaiable_seat;
        this.showtime_id = showtime_id;
    }

    public InfomationMovie(String name, String start_time, String end_time, String avaiable_seat, String price, String showtime_id) {
        this.name = name;
        this.start_time = start_time;
        this.end_time = end_time;
        this.avaiable_seat = avaiable_seat;
        this.price = price;
        this.showtime_id = showtime_id;
    }

    public String getShowtime_id() {
        return showtime_id;
    }

    public void setShowtime_id(String showtime_id) {
        this.showtime_id = showtime_id;
    }
    

    

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
    

    public String getAvaiable_seat() {
        return avaiable_seat;
    }

    public void setAvaiable_seat(String avaiable_seat) {
        this.avaiable_seat = avaiable_seat;
    }

    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

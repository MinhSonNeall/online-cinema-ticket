/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author Cuong
 */
public class ShowSeat {
    private String seat_number;
    private String check_seat;
    private String price;
    private String seat_id;

    public String getSeat_id() {
        return seat_id;
    }

    public void setSeat_id(String seat_id) {
        this.seat_id = seat_id;
    }
    
    
    public ShowSeat() {
    }
    public ShowSeat(String seat_number,String check_seat,String price, String seat_id){
        this.seat_number = seat_number;
        this.check_seat = check_seat;
        this.price = price;
        this.seat_id=seat_id;
    }
    public ShowSeat(String seat_number, String check_seat) {
        this.seat_number = seat_number;
        this.check_seat = check_seat;
    }

    public ShowSeat(String seat_number, String check_seat, String price) {
        this.seat_number = seat_number;
        this.check_seat = check_seat;
        this.price = price;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
    

    public String getSeat_number() {
        return seat_number;
    }

    public void setSeat_number(String seat_number) {
        this.seat_number = seat_number;
    }

    public String getCheck_seat() {
        return check_seat;
    }

    public void setCheck_seat(String check_seat) {
        this.check_seat = check_seat;
    }
    
    
}

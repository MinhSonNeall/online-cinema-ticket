/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.util.List;
import java.sql.Timestamp;


/**
 *
 * @author Cuong
 */
public class TicketPayment {
    private String ticket_id;
    private String user_id;
    private String showtime_id;
    private String total_amount;
    private Timestamp book_date;
    private String showDate;
    private String movieTitle;
    private String startTime;
    private String endTime;
    private String roomName;
    private String cinemaName;
    
    private List<String> seat_ids;

    public TicketPayment() {
    }

    public TicketPayment(String ticket_id, String user_id, String showtime_id, String total_amount, List<String> seat_ids) {
        this.ticket_id = ticket_id;
        this.user_id = user_id;
        this.showtime_id = showtime_id;
        this.total_amount = total_amount;
        this.seat_ids = seat_ids;
    }

    public TicketPayment(String ticket_id, String user_id, String showtime_id, String total_amount, Timestamp book_date, String movieTitle, String startTime, String endTime, String roomName, String cinemaName, List<String> seat_ids) {
        this.ticket_id = ticket_id;
        this.user_id = user_id;
        this.showtime_id = showtime_id;
        this.total_amount = total_amount;
        this.book_date = book_date;
        this.movieTitle = movieTitle;
        this.startTime = startTime;
        this.endTime = endTime;
        this.roomName = roomName;
        this.cinemaName = cinemaName;
        this.seat_ids = seat_ids;
    }

    public TicketPayment(String ticket_id, String user_id, String showtime_id, String total_amount, Timestamp book_date, String showDate, String movieTitle, String startTime, String endTime, String roomName, String cinemaName, List<String> seat_ids) {
        this.ticket_id = ticket_id;
        this.user_id = user_id;
        this.showtime_id = showtime_id;
        this.total_amount = total_amount;
        this.book_date = book_date;
        this.showDate = showDate;
        this.movieTitle = movieTitle;
        this.startTime = startTime;
        this.endTime = endTime;
        this.roomName = roomName;
        this.cinemaName = cinemaName;
        this.seat_ids = seat_ids;
    }

    public String getShowDate() {
        return showDate;
    }

    public void setShowDate(String showDate) {
        this.showDate = showDate;
    }
    
    

    public Timestamp getBook_date() {
        return book_date;
    }

    public void setBook_date(Timestamp book_date) {
        this.book_date = book_date;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }
    
    

    public String getTicket_id() {
        return ticket_id;
    }

    public void setTicket_id(String ticket_id) {
        this.ticket_id = ticket_id;
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

    public String getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(String total_amount) {
        this.total_amount = total_amount;
    }

    public List<String> getSeat_ids() {
        return seat_ids;
    }

    public void setSeat_ids(List<String> seat_ids) {
        this.seat_ids = seat_ids;
    }

    
    
    
    
    
}

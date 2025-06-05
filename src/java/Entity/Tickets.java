package Entity;

import java.sql.Timestamp;

public class Tickets {
    private String ticket_id;
    private String user_id;
    private String showtime_id;
    private Timestamp booking_date;
    private double total_amount;
    private String status;
    private String qr_code;
    private String movieTitle;
    private Timestamp showtimeStartTime;
    private String seatNumber;

    // Getters and Setters
    public String getTicket_id() { return ticket_id; }
    public void setTicket_id(String ticket_id) { this.ticket_id = ticket_id; }
    public String getUser_id() { return user_id; }
    public void setUser_id(String user_id) { this.user_id = user_id; }
    public String getShowtime_id() { return showtime_id; }
    public void setShowtime_id(String showtime_id) { this.showtime_id = showtime_id; }
    public Timestamp getBooking_date() { return booking_date; }
    public void setBooking_date(Timestamp booking_date) { this.booking_date = booking_date; }
    public double getTotal_amount() { return total_amount; }
    public void setTotal_amount(double total_amount) { this.total_amount = total_amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getQr_code() { return qr_code; }
    public void setQr_code(String qr_code) { this.qr_code = qr_code; }
    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
    public Timestamp getShowtimeStartTime() { return showtimeStartTime; }
    public void setShowtimeStartTime(Timestamp showtimeStartTime) { this.showtimeStartTime = showtimeStartTime; }
    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }
}

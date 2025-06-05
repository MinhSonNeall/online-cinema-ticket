package Model;

import Entity.Movies;
import Entity.Showtimes;
import Entity.Seats;
import Entity.Tickets;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DaoTicket extends DBContext {

    public ArrayList<Tickets> getBookingHistory(String userId) {
        ArrayList<Tickets> history = new ArrayList<>();
        String sql = "SELECT t.ticket_id, t.booking_date, t.total_amount, t.status, " +
                     "m.title, s.start_time, st.seat_number " +
                     "FROM movie_ticketing.tickets t " +
                     "JOIN movie_ticketing.showtimes s ON t.showtime_id = s.showtime_id " +
                     "JOIN movie_ticketing.movies m ON s.movie_id = m.movie_id " +
                     "JOIN movie_ticketing.ticket_seats ts ON t.ticket_id = ts.ticket_id " +
                     "JOIN movie_ticketing.seats st ON ts.seat_id = st.seat_id " +
                     "WHERE t.user_id = ? ORDER BY t.booking_date DESC";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Tickets ticket = new Tickets();
                ticket.setTicket_id(rs.getString("ticket_id"));
                ticket.setBooking_date(rs.getTimestamp("booking_date"));
                ticket.setTotal_amount(rs.getDouble("total_amount"));
                ticket.setStatus(rs.getString("status"));
                ticket.setMovieTitle(rs.getString("title"));
                ticket.setShowtimeStartTime(rs.getTimestamp("start_time"));
                ticket.setSeatNumber(rs.getString("seat_number"));
                history.add(ticket);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return history;
    }
}

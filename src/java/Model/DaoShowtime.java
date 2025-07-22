package Model;

import Entity.Showtimes;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;

public class DaoShowtime extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    public List<Showtimes> getAllShowtimes() {
        List<Showtimes> showtimes = new Vector<>();
        String sql = "SELECT s.*, m.title as movie_title, r.name as room_name " +
                     "FROM Showtimes s " +
                     "JOIN Movies m ON s.movie_id = m.movie_id " +
                     "JOIN Rooms r ON s.room_id = r.room_id";
        try {
            ps = getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Showtimes showtime = new Showtimes();
                showtime.setShowtime_id(rs.getString("showtime_id"));
                showtime.setMovie_id(rs.getString("movie_id"));
                showtime.setRoom_id(rs.getString("room_id"));
                showtime.setStart_time(rs.getTimestamp("start_time"));
                showtime.setEnd_time(rs.getTimestamp("end_time"));
                showtime.setTicket_price(rs.getBigDecimal("ticket_price"));
                showtime.setMovie_title(rs.getString("movie_title"));
                showtime.setRoom_name(rs.getString("room_name"));
                showtimes.add(showtime);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    public void addShowtime(Showtimes showtime) {
        // Implementation for adding a showtime
    }

    public void updateShowtime(Showtimes showtime) {
        // Implementation for updating a showtime
    }

    public void deleteShowtime(String showtimeId) {
        // Implementation for deleting a showtime
    }
} 
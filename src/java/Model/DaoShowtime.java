package Model;

import Entity.Showtimes;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoShowtime extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection;

    public List<Showtimes> getAllShowtimes() {
        List<Showtimes> showtimes = new Vector<>();
        String sql = "SELECT s.showtime_id, m.title as movie_title, r.name as room_name, " +
                     "c.name as cinema_name, s.start_time, s.end_time " +
                     "FROM Showtimes s " +
                     "JOIN Movies m ON s.movie_id = m.movie_id " +
                     "JOIN Rooms r ON s.room_id = r.room_id " +
                     "JOIN Cinemas c ON r.cinema_id = c.cinema_id";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Showtimes showtime = new Showtimes();
                showtime.setShowtime_id(rs.getString("showtime_id"));
                showtime.setMovie_title(rs.getString("movie_title"));
                showtime.setRoom_name(rs.getString("room_name"));
                showtime.setCinema_name(rs.getString("cinema_name"));
                showtime.setStart_time(rs.getTimestamp("start_time"));
                showtime.setEnd_time(rs.getTimestamp("end_time"));
                showtimes.add(showtime);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error getting all showtimes: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return showtimes;
    }
    
    public int getMaxShowtimeId() {
        int maxId = 0;
        String sql = "SELECT MAX(CAST(showtime_id AS UNSIGNED)) as max_id FROM Showtimes";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                maxId = rs.getInt("max_id");
            }
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error getting max showtime ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return maxId;
    }

    public Showtimes getShowtimeById(String showtimeId) {
        String sql = "SELECT s.*, m.title as movie_title, r.name as room_name, " +
                     "c.name as cinema_name,r.room_id " +
                     "FROM Showtimes s " +
                     "JOIN Movies m ON s.movie_id = m.movie_id " +
                     "JOIN Rooms r ON s.room_id = r.room_id " +
                     "JOIN Cinemas c ON r.cinema_id = c.cinema_id " +
                     "WHERE s.showtime_id = ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtimeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Showtimes showtime = new Showtimes();
                showtime.setShowtime_id(rs.getString("showtime_id"));
                showtime.setMovie_id(rs.getString("movie_id"));
                showtime.setRoom_id(rs.getString("room_id"));
                showtime.setStart_time(rs.getTimestamp("start_time"));
                showtime.setEnd_time(rs.getTimestamp("end_time"));
                showtime.setMovie_title(rs.getString("movie_title"));
                showtime.setRoom_name(rs.getString("room_name"));
                showtime.setCinema_name(rs.getString("cinema_name"));
                
                return showtime;
            }
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error getting showtime by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }

    public void addShowtime(Showtimes showtime) {
        String sql = "INSERT INTO Showtimes (showtime_id, movie_id, room_id, start_time, end_time, ticket_price) VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtime.getShowtime_id());
            ps.setString(2, showtime.getMovie_id());
            ps.setString(3, showtime.getRoom_id());
            ps.setTimestamp(4, showtime.getStart_time());
            ps.setTimestamp(5, showtime.getEnd_time());
            
            // Đảm bảo ticket_price không null, nếu null thì gán giá trị mặc định 5000.00
            BigDecimal ticketPrice = showtime.getTicket_price();
            if (ticketPrice == null) {
                ticketPrice = new BigDecimal("5000.00");
            }
            ps.setBigDecimal(6, ticketPrice);
            
            System.out.println("Debug - Adding showtime: ID=" + showtime.getShowtime_id() + 
                              ", MovieID=" + showtime.getMovie_id() + 
                              ", RoomID=" + showtime.getRoom_id() + 
                              ", TicketPrice=" + ticketPrice);
            
            ps.executeUpdate();
            System.out.println("Debug - Showtime added successfully");
        } catch (Exception e) {
            System.out.println("Error adding showtime: " + e.getMessage());
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error adding showtime: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public void updateShowtime(Showtimes showtime) {
        String sql = "UPDATE Showtimes SET start_time = ?, end_time = ? WHERE showtime_id = ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setTimestamp(1, showtime.getStart_time());
            ps.setTimestamp(2, showtime.getEnd_time());
            ps.setString(3, showtime.getShowtime_id());
            ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error updating showtime: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public void deleteShowtime(String showtimeId) {
        String sql = "DELETE FROM Showtimes WHERE showtime_id = ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtimeId);
            ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error deleting showtime: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public String generateNextSlotId() {
        int maxId = 0;
        String sql = "SELECT MAX(CAST(slot_id AS UNSIGNED)) as max_id FROM showtime_slots";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next() && rs.getString("max_id") != null) {
                maxId = rs.getInt("max_id");
            }
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error generating next slot ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return String.valueOf(maxId + 1);
    }

    public void insertSlot(String slotId, String showtimeId, String date, String startTime, String endTime) {
        String sql = "INSERT INTO showtime_slots (slot_id, showtime_id, date, start_time, end_time) VALUES (?, ?, ?, ?, ?)";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, slotId);
            ps.setString(2, showtimeId);
            ps.setString(3, date);
            ps.setString(4, startTime);
            ps.setString(5, endTime);
            ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error inserting slot: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, null);
        }
    }
} 
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
    
    // Search showtimes by movie title
    public List<Showtimes> searchShowtimesByMovieTitle(String movieTitle) {
        List<Showtimes> showtimes = new Vector<>();
        String sql = "SELECT s.showtime_id, m.title as movie_title, r.name as room_name, " +
                     "c.name as cinema_name, s.start_time, s.end_time " +
                     "FROM Showtimes s " +
                     "JOIN Movies m ON s.movie_id = m.movie_id " +
                     "JOIN Rooms r ON s.room_id = r.room_id " +
                     "JOIN Cinemas c ON r.cinema_id = c.cinema_id " +
                     "WHERE m.title LIKE ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + movieTitle.replaceAll("\\s+", " ") + "%");
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
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error searching showtimes by title: " + e.getMessage(), e);
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
    
    public List<Map<String, Object>> getShowtimeSlotsByShowtimeId(String showtimeId) {
        List<Map<String, Object>> slots = new ArrayList<>();
        String sql = "SELECT slot_id, date, start_time, end_time FROM showtime_slots WHERE showtime_id = ? ORDER BY date, start_time";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtimeId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> slot = new HashMap<>();
                slot.put("slot_id", rs.getString("slot_id"));
                slot.put("date", rs.getString("date"));
                slot.put("start_time", rs.getString("start_time"));
                slot.put("end_time", rs.getString("end_time"));
                slots.add(slot);
            }
            
            System.out.println("Debug - Found " + slots.size() + " slots for showtime ID: " + showtimeId);
        } catch (Exception e) {
            System.out.println("Error getting showtime slots: " + e.getMessage());
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error getting showtime slots: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        
        return slots;
    }
    
    public int countShowtimeSlotsByShowtimeId(String showtimeId) {
        int count = 0;
        String sql = "SELECT COUNT(*) as slot_count FROM showtime_slots WHERE showtime_id = ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtimeId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt("slot_count");
            }
            
            System.out.println("Debug - Counted " + count + " slots for showtime ID: " + showtimeId);
        } catch (Exception e) {
            System.out.println("Error counting showtime slots: " + e.getMessage());
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error counting showtime slots: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        
        return count;
    }
    
    /**
     * Kiểm tra xem khung giờ mới có bị trùng với khung giờ khác trong cùng ngày và phòng hay không
     * @param roomId ID của phòng chiếu
     * @param date Ngày chiếu định dạng 'YYYY-MM-DD'
     * @param startTime Thời gian bắt đầu định dạng 'HH:MM:SS'
     * @param endTime Thời gian kết thúc định dạng 'HH:MM:SS'
     * @return true nếu có trùng lặp, false nếu không
     */
    public boolean isTimeSlotOverlapping(String roomId, String date, String startTime, String endTime) {
        boolean overlap = false;
        
        // SQL query để kiểm tra xem có slot nào trong cùng phòng và ngày có thời gian chồng lấn không
        String sql = "SELECT ss.slot_id, ss.start_time, ss.end_time, m.title " +
                    "FROM showtime_slots ss " +
                    "JOIN showtimes s ON ss.showtime_id = s.showtime_id " +
                    "JOIN movies m ON s.movie_id = m.movie_id " +
                    "WHERE s.room_id = ? AND ss.date = ? " +
                    "AND ((? BETWEEN ss.start_time AND ss.end_time) OR " + // Kiểm tra thời gian bắt đầu mới nằm trong khoảng slot hiện có
                    "(? BETWEEN ss.start_time AND ss.end_time) OR " +     // Kiểm tra thời gian kết thúc mới nằm trong khoảng slot hiện có 
                    "(? <= ss.start_time AND ? >= ss.end_time))";         // Kiểm tra slot mới bao trùm slot hiện có
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            ps.setString(2, date);
            ps.setString(3, startTime);
            ps.setString(4, endTime);
            ps.setString(5, startTime);
            ps.setString(6, endTime);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Tìm thấy ít nhất một khung giờ bị chồng chéo
                overlap = true;
                System.out.println("Debug - Found overlapping time slot with movie: " + rs.getString("title") + 
                                  ", time: " + rs.getString("start_time") + " - " + rs.getString("end_time"));
            }
            
        } catch (Exception e) {
            System.out.println("Error checking overlapping time slots: " + e.getMessage());
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error checking overlapping time slots: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        
        return overlap;
    }
    
    /**
     * Kiểm tra xem đã tồn tại showtime nào có cùng phim, rạp và phòng với khoảng thời gian trùng lặp không
     * @param movieId ID của phim
     * @param roomId ID của phòng chiếu
     * @param startTime Thời gian bắt đầu định dạng 'YYYY-MM-DD'
     * @param endTime Thời gian kết thúc định dạng 'YYYY-MM-DD'
     * @return true nếu có trùng lặp, false nếu không
     */
    public boolean isShowtimeOverlapping(String movieId, String roomId, Timestamp startTime, Timestamp endTime) {
        boolean overlap = false;
        
        // SQL query để kiểm tra xem có showtime nào cùng phim, phòng và trùng thời gian không
        String sql = "SELECT s.showtime_id, m.title, r.name as room_name, c.name as cinema_name, s.start_time, s.end_time " +
                     "FROM Showtimes s " +
                     "JOIN Movies m ON s.movie_id = m.movie_id " +
                     "JOIN Rooms r ON s.room_id = r.room_id " +
                     "JOIN Cinemas c ON r.cinema_id = c.cinema_id " +
                     "WHERE s.movie_id = ? AND s.room_id = ? " +
                     "AND NOT (s.end_time < ? OR s.start_time > ?)"; 
                     // Kết quả sẽ là các showtime có thời gian giao với thời gian mới
                     // NOT (end_old < start_new OR start_old > end_new)
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            ps.setString(2, roomId);
            ps.setTimestamp(3, startTime);
            ps.setTimestamp(4, endTime);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Tìm thấy ít nhất một showtime bị trùng
                overlap = true;
                System.out.println("Debug - Found overlapping showtime: " + rs.getString("title") + 
                                   " in " + rs.getString("cinema_name") + ", " + rs.getString("room_name") +
                                   ", time: " + rs.getTimestamp("start_time") + " - " + rs.getTimestamp("end_time"));
            }
            
        } catch (Exception e) {
            System.out.println("Error checking overlapping showtimes: " + e.getMessage());
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error checking overlapping showtimes: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        
        return overlap;
    }
    
    /**
     * Lấy tất cả showtime slot của một phòng
     * @param roomId ID của phòng chiếu
     * @return Danh sách các showtime slot với thông tin phim, ngày, giờ bắt đầu và kết thúc
     */
    public List<Map<String, Object>> getShowtimeSlotsByRoomId(String roomId) {
        List<Map<String, Object>> slots = new ArrayList<>();
        String sql = "SELECT ss.slot_id, ss.date, ss.start_time, ss.end_time, " +
                     "s.showtime_id, m.title as movie_title, m.movie_id " +
                     "FROM showtime_slots ss " +
                     "JOIN showtimes s ON ss.showtime_id = s.showtime_id " +
                     "JOIN movies m ON s.movie_id = m.movie_id " +
                     "WHERE s.room_id = ? " +
                     "ORDER BY ss.date, ss.start_time";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> slot = new HashMap<>();
                slot.put("slot_id", rs.getString("slot_id"));
                slot.put("date", rs.getString("date"));
                slot.put("start_time", rs.getString("start_time"));
                slot.put("end_time", rs.getString("end_time"));
                slot.put("showtime_id", rs.getString("showtime_id"));
                slot.put("movie_title", rs.getString("movie_title"));
                slot.put("movie_id", rs.getString("movie_id"));
                slots.add(slot);
            }
            
            System.out.println("Debug - Found " + slots.size() + " slots for room ID: " + roomId);
        } catch (Exception e) {
            System.out.println("Error getting showtime slots by room: " + e.getMessage());
            Logger.getLogger(DaoShowtime.class.getName()).log(Level.SEVERE, "Error getting showtime slots by room: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        
        return slots;
    }
} 
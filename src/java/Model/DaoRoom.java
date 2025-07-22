package Model;

import Entity.Rooms;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoRoom extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection;
    
    public List<Rooms> getAllRooms() {
        List<Rooms> rooms = new Vector<>();
        String sql = "SELECT * FROM Rooms";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                rooms.add(room);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting all rooms: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return rooms;
    }

    public Rooms getRoomById(String roomId) {
        String sql = "SELECT * FROM Rooms WHERE room_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                return room;
            }
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting room by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }

    public List<Rooms> getRoomsByCinemaId(String cinemaId) {
        List<Rooms> rooms = new Vector<>();
        String sql = "SELECT * FROM Rooms WHERE cinema_id = ?";
        System.out.println("Debug - Executing SQL: " + sql + " with cinemaId = " + cinemaId);
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinemaId);
            rs = ps.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                rooms.add(room);
                System.out.println("Debug - Found room: ID=" + room.getRoom_id() + ", Name=" + room.getName() + 
                                  ", CinemaID=" + room.getCinema_id() + ", TotalSeats=" + room.getTotal_seats());
            }
            System.out.println("Debug - Found " + count + " rooms for cinema ID " + cinemaId);
        } catch (Exception e) {
            System.out.println("Error getting rooms by cinema ID: " + e.getMessage());
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting rooms by cinema ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return rooms;
    }
    
    public int getMaxRoomId() {
        int maxId = 0;
        String sql = "SELECT MAX(CAST(room_id AS UNSIGNED)) as max_id FROM Rooms";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next() && rs.getString("max_id") != null) {
                maxId = rs.getInt("max_id");
                System.out.println("Debug - Found max room ID: " + maxId);
            } else {
                System.out.println("Debug - No rooms found, starting with ID 1");
            }
        } catch (Exception e) {
            System.out.println("Error getting max room ID: " + e.getMessage());
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting max room ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return maxId;
    }
    
    public boolean addRoom(Rooms room) {
        String sql = "INSERT INTO Rooms (room_id, cinema_id, name, total_seats) VALUES (?, ?, ?, ?)";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, room.getRoom_id());
            ps.setString(2, room.getCinema_id());
            ps.setString(3, room.getName());
            ps.setInt(4, room.getTotal_seats());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error adding room: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
    
    public boolean updateRoom(Rooms room) {
        String sql = "UPDATE Rooms SET cinema_id = ?, name = ?, total_seats = ? WHERE room_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, room.getCinema_id());
            ps.setString(2, room.getName());
            ps.setInt(3, room.getTotal_seats());
            ps.setString(4, room.getRoom_id());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error updating room: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
    
    public boolean deleteRoom(String roomId) {
        // Kiểm tra xem phòng có đang được sử dụng trong showtimes không
        String checkSql = "SELECT COUNT(*) as count FROM Showtimes WHERE room_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(checkSql);
            ps.setString(1, roomId);
            rs = ps.executeQuery();
            
            if (rs.next() && rs.getInt("count") > 0) {
                // Nếu phòng đang được sử dụng, không cho phép xóa
                Logger.getLogger(DaoRoom.class.getName()).log(Level.WARNING, 
                    "Cannot delete room ID " + roomId + " because it is being used in showtimes");
                return false;
            }
            
            // Nếu không có showtime nào sử dụng phòng, tiến hành xóa
            String sql = "DELETE FROM Rooms WHERE room_id = ?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error deleting room: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, rs);
        }
    }
}
package Model;

import Entity.Cinemas;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoCinema extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection;
    
    public List<Cinemas> getAllCinemas() {
        List<Cinemas> cinemas = new Vector<>();
        String sql = "SELECT * FROM Cinemas";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Cinemas cinema = new Cinemas();
                cinema.setCinema_id(rs.getString("cinema_id"));
                cinema.setName(rs.getString("name"));
                cinema.setAddress(rs.getString("address"));
                cinema.setCity(rs.getString("city"));
                cinemas.add(cinema);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error getting all cinemas: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return cinemas;
    }
    
    public Cinemas getCinemaById(String cinemaId) {
        String sql = "SELECT * FROM Cinemas WHERE cinema_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinemaId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Cinemas cinema = new Cinemas();
                cinema.setCinema_id(rs.getString("cinema_id"));
                cinema.setName(rs.getString("name"));
                cinema.setAddress(rs.getString("address"));
                cinema.setCity(rs.getString("city"));
                return cinema;
            }
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error getting cinema by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }
    
    public int getMaxCinemaId() {
        int maxId = 0;
        String sql = "SELECT MAX(CAST(cinema_id AS UNSIGNED)) as max_id FROM Cinemas";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next() && rs.getString("max_id") != null) {
                maxId = rs.getInt("max_id");
            }
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error getting max cinema ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return maxId;
    }
    
    public boolean addCinema(Cinemas cinema) {
        String sql = "INSERT INTO Cinemas (cinema_id, name, address, city) VALUES (?, ?, ?, ?)";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinema.getCinema_id());
            ps.setString(2, cinema.getName());
            ps.setString(3, cinema.getAddress());
            ps.setString(4, cinema.getCity());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error adding cinema: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
    
    public boolean updateCinema(Cinemas cinema) {
        String sql = "UPDATE Cinemas SET name = ?, address = ?, city = ? WHERE cinema_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinema.getName());
            ps.setString(2, cinema.getAddress());
            ps.setString(3, cinema.getCity());
            ps.setString(4, cinema.getCinema_id());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error updating cinema: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
    
    public boolean deleteCinema(String cinemaId) {
        // Kiểm tra xem có phòng nào thuộc rạp này không
        DaoRoom daoRoom = new DaoRoom();
        List<Entity.Rooms> rooms = daoRoom.getRoomsByCinemaId(cinemaId);
        if (!rooms.isEmpty()) {
            // Nếu có phòng thuộc rạp này, không cho phép xóa
            Logger.getLogger(DaoCinema.class.getName()).log(Level.WARNING, 
                "Cannot delete cinema ID " + cinemaId + " because it has " + rooms.size() + " rooms associated with it");
            return false;
        }
        
        // Nếu không có phòng nào, tiến hành xóa rạp
        String sql = "DELETE FROM Cinemas WHERE cinema_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinemaId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error deleting cinema: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
} 
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import Entity.DateItem;
import Entity.Location;
import Entity.Movies;
import Entity.Seats;
import Entity.Showtimes;
import java.security.Timestamp;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import jdk.jfr.Timespan;
/**
 *
 * @author Cuong
 */
public class DaoMovie extends DBContext{
    PreparedStatement ps;
    ResultSet rs;
    
    public ArrayList<Movies> getAllMovies() {
        ArrayList<Movies> list = new ArrayList<>();
        String sql = "SELECT \n" +
"    m.*, \n" +
"    GROUP_CONCAT(g.name SEPARATOR ', ') AS genres\n" +
"FROM \n" +
"    movie_ticketing.movies m\n" +
"JOIN \n" +
"    movie_ticketing.movie_genres mg ON m.movie_id = mg.movie_id\n" +
"JOIN \n" +
"    movie_ticketing.genres g ON mg.genre_id = g.genre_id\n" +
"WHERE \n" +
"    m.status = 'now_showing'\n" +
"GROUP BY \n" +
"    m.movie_id;";
        try {
            Movies movie = null;
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                movie = new Movies(
                    rs.getString("movie_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("duration"),
                    rs.getInt("age_restriction"),
                    rs.getString("poster_url"),
                        rs.getString("trailer_url"),
                        rs.getString("genres")
                );
                list.add(movie);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return list;
    }
    
    
    public static void main(String[] args) {
        DaoMovie dao = new DaoMovie();
        ArrayList<Movies> movies = dao.getAllMovies();
        if (movies.isEmpty()) {
            System.out.println("No movies found or an error occurred.");
        } else {
            for (Movies movie : movies) {
                System.out.println(movie);
            }
        }
    }
    
    public Movies getMovieById(String movieId) {
        Movies movie = null;
        String sql = "SELECT * FROM movie_ticketing.movies WHERE movie_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            rs = ps.executeQuery();
            if (rs.next()) {
                movie = new Movies(
                    rs.getString("movie_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("duration"),
                    rs.getInt("age_restriction"),
                        rs.getString("poster_url"),
                        rs.getString("trailer_url")
                );
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return movie;
    }
    
    
    public Movies getMovieByIdMovieDetails(String movieId) {
        Movies movie = null;
        String sql = "SELECT \n"
                + "    m.movie_id,\n"
                + "    m.title,\n"
                + "    m.description,\n"
                + "    m.trailer_url,\n"
                + "    m.poster_url,\n"
                + "    m.duration,\n"
                + "    m.age_restriction,\n"
                + "    s.start_time,\n"
                + "    GROUP_CONCAT(g.name SEPARATOR ', ') AS genres\n"
                + "FROM \n"
                + "    movies m\n"
                + "    JOIN showtimes s ON m.movie_id = s.movie_id\n"
                + "    JOIN movie_genres ms ON m.movie_id = ms.movie_id\n"
                + "    JOIN genres g ON ms.genre_id = g.genre_id\n"
                + "WHERE \n"
                + "    m.movie_id = ?\n"
                + "GROUP BY \n"
                + "    m.movie_id, m.title, m.description, m.trailer_url, m.poster_url, m.duration, m.age_restriction, s.start_time";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            rs = ps.executeQuery();
            if (rs.next()) {
                movie = new Movies(
                        rs.getString("movie_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("trailer_url"),
                        rs.getString("poster_url"),
                        rs.getInt("duration"),
                        rs.getInt("age_restriction"),
                        rs.getString("start_time"),
                        rs.getString("genres")
                );
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return movie;
    }
    
    public List<DateItem> getDayOfMoview(String movieId) {
        List<DateItem> dateList = new ArrayList<>();
        String sql = "SELECT MIN(start_time) as start_time, MAX(end_time) as end_time FROM movie_ticketing.showtimes WHERE movie_id = ?";
        LocalDate getDateNoew = LocalDate.now();
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            rs = ps.executeQuery();
            if (rs.next()) {
                  String start =  rs.getString("start_time");
                  String end =   rs.getString("end_time");
                  
                  if(start == null || end == null) {
                      return dateList;
                  }
                  
                  LocalDate startDate = LocalDate.parse(start.split(" ")[0]);
                  LocalDate endate = LocalDate.parse(end.split(" ")[0]);
                  
                  LocalDate beginDay = getDateNoew.isBefore(startDate) ? startDate : getDateNoew;
                  if(getDateNoew.isAfter(endate)) {
                      return  dateList;
                  }
                  
                  long dayBeetwent = ChronoUnit.DAYS.between(beginDay, endate) + 1;

                  
                  for (int i = 0; i < dayBeetwent; i++) {
                    LocalDate date = beginDay.plusDays(i);
                    DateItem item = new DateItem();
                    item.setDay(String.format("%02d", date.getDayOfMonth()));
                    item.setDayName(getVietnameseDayName(date.getDayOfWeek().getValue()));
                    item.setActive(date.equals(getDateNoew)); // Đặt ngày đầu tiên là active
                    item.setFullDate(date.toString());
                    dateList.add(item);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return dateList;
    }
    
    
    private String getVietnameseDayName(int dayOfWeek) {
        String[] days = {"T2", "T3", "T4", "T5", "T6", "T7", "CN"};
        return days[dayOfWeek - 1]; // Điều chỉnh cho chỉ số bắt đầu từ 1
    }
    
    
    
    
    public ArrayList<Showtimes> getShowtimes(String movieId) {
        ArrayList<Showtimes> showtimes = new ArrayList<>();
        String sqlSetTimeZone = "SET SESSION time_zone = '+07:00'";
        String sql = "SELECT s.showtime_id, s.start_time, s.ticket_price " +
                    "FROM movie_ticketing.showtimes s " +
                    "JOIN movie_ticketing.rooms r ON s.room_id = r.room_id " +
                    "JOIN movie_ticketing.cinemas c ON r.cinema_id = c.cinema_id " +
                    "WHERE s.movie_id = ? " +
                    "AND NOW() BETWEEN s.start_time AND s.end_time";
        connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();

            // Đặt múi giờ session
            ps = connection.prepareStatement(sqlSetTimeZone);
            ps.execute();

            // Truy vấn chính
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            rs = ps.executeQuery();

            // Debug: Kiểm tra số lượng suất chiếu
            int count = 0;
            while (rs.next()) {
                count++;
                String showtimeId = rs.getString("showtime_id");
                java.sql.Timestamp startTime = rs.getTimestamp("start_time");
                double ticketPrice = rs.getDouble("ticket_price");

                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                String time = timeFormat.format(startTime);
                // Tính số ghế còn lại cho suất chiếu
                int remainingSeats = getRemainingSeats(showtimeId);
                String formattedPrice = String.format("%,.0f", ticketPrice).replace(",", ".");

                showtimes.add(new Showtimes(showtimeId, time, formattedPrice, remainingSeats));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return showtimes;
    }
    
    
    public List<Location> getCinemasByMovieAndDate(String movieId, LocalDate selectedDate) {
    List<Location> locationList = new ArrayList<>();
    String sql = "SELECT DISTINCT c.name " +
                 "FROM showtimes s " +
                 "JOIN rooms r ON s.room_id = r.room_id " +
                 "JOIN cinemas c ON r.cinema_id = c.cinema_id " +
                 "WHERE s.movie_id = ? AND DATE(s.start_time) <= ? AND DATE(s.end_time) >= ?";

    try {
        connection = getConnection();
        ps = connection.prepareStatement(sql);
        ps.setString(1, movieId);
        ps.setString(2, selectedDate.toString()); 
        ps.setString(3, selectedDate.toString());
        rs = ps.executeQuery();

        boolean isFirst = true;
        while (rs.next()) {
            Location location = new Location();
            location.setName(rs.getString("name"));
            location.setActive(isFirst); // Đặt rạp đầu tiên là active
            locationList.add(location);
            isFirst = false;
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        closeConnection(connection, ps, rs);
    }
    return locationList;
}
    
    
    
    public int getRemainingSeats(String showtimeId) {
        int remainingSeats = 0;
        String sql = "SELECT COUNT(*) " +
                    "FROM movie_ticketing.seats s " +
                    "JOIN movie_ticketing.showtimes st ON s.room_id = st.room_id " +
                    "WHERE st.showtime_id = ? AND NOT EXISTS (" +
                    "SELECT 1 FROM movie_ticketing.ticket_seats ts " +
                    "JOIN movie_ticketing.tickets t ON ts.ticket_id = t.ticket_id " +
                    "WHERE ts.seat_id = s.seat_id AND t.showtime_id = ? AND t.status = 'confirmed')";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtimeId);
            ps.setString(2, showtimeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                remainingSeats = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return remainingSeats;
    }
    
    public ArrayList<Seats> getSeats(String showtimeId) {
        ArrayList<Seats> seats = new ArrayList<>();
        String sql = "SELECT s.seat_id, s.seat_number, s.type, s.price, " +
                    "EXISTS (SELECT 1 FROM movie_ticketing.ticket_seats ts " +
                    "JOIN movie_ticketing.tickets t ON ts.ticket_id = t.ticket_id " +
                    "WHERE ts.seat_id = s.seat_id AND t.showtime_id = ? AND t.status = 'confirmed') as is_booked " +
                    "FROM movie_ticketing.seats s " +
                    "JOIN movie_ticketing.showtimes st ON s.room_id = st.room_id " +
                    "WHERE st.showtime_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, showtimeId);
            ps.setString(2, showtimeId);
            rs = ps.executeQuery();
            while (rs.next()) {
                String seatId = rs.getString("seat_id");
                String seatNumber = rs.getString("seat_number");
                String type = rs.getString("type");
                double price = rs.getDouble("price");
                boolean isBooked = rs.getBoolean("is_booked");
                seats.add(new Seats(seatId, seatNumber, type, price, isBooked, false));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return seats;
    }
    
//    public ArrayList<Movies> getMoviesByGenre(String genre) {
//        ArrayList<Movies> list = new ArrayList<>();
//        String sql = "SELECT * FROM movie_ticketing.movies WHERE genre LIKE ? AND status = 'active'";
//        try {
//            connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setString(1, "%" + genre + "%");
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                Movies movie = new Movies(
//                    rs.getInt("movie_id"),
//                    rs.getString("title"),
//                    rs.getString("description"),
//                    rs.getInt("duration"),
//                    rs.getString("poster_url"),
//                    rs.getString("genre"),
//                    rs.getDouble("rating"),
//                    rs.getString("age_restriction"),
//                    rs.getDate("release_date"),
//                    rs.getString("director"),
//                    rs.getString("cast"),
//                    rs.getString("trailer_url"),
//                    rs.getString("status")
//                );
//                list.add(movie);
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, rs);
//        }
//        return list;
//    }
//
//    // Tìm kiếm phim theo tên
//    public ArrayList<Movie> searchMoviesByTitle(String title) {
//        ArrayList<Movie> list = new ArrayList<>();
//        String sql = "SELECT * FROM movie_ticketing.movies WHERE title LIKE ? AND status = 'active'";
//        try {
//            Connection connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setString(1, "%" + title + "%");
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                Movie movie = new Movie(
//                    rs.getInt("movie_id"),
//                    rs.getString("title"),
//                    rs.getString("description"),
//                    rs.getInt("duration"),
//                    rs.getString("poster_url"),
//                    rs.getString("genre"),
//                    rs.getDouble("rating"),
//                    rs.getString("age_restriction"),
//                    rs.getDate("release_date"),
//                    rs.getString("director"),
//                    rs.getString("cast"),
//                    rs.getString("trailer_url"),
//                    rs.getString("status")
//                );
//                list.add(movie);
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, rs);
//        }
//        return list;
//    }
//
//    // Thêm phim mới
//    public boolean addMovie(Movie movie) {
//        String sql = "INSERT INTO movie_ticketing.movies (title, description, duration, poster_url, genre, rating, age_restriction, release_date, director, cast, trailer_url, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        try {
//            Connection connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setString(1, movie.getTitle());
//            ps.setString(2, movie.getDescription());
//            ps.setInt(3, movie.getDuration());
//            ps.setString(4, movie.getPosterUrl());
//            ps.setString(5, movie.getGenre());
//            ps.setDouble(6, movie.getRating());
//            ps.setString(7, movie.getAgeRestriction());
//            ps.setDate(8, movie.getReleaseDate());
//            ps.setString(9, movie.getDirector());
//            ps.setString(10, movie.getCast());
//            ps.setString(11, movie.getTrailerUrl());
//            ps.setString(12, movie.getStatus());
//            
//            int result = ps.executeUpdate();
//            return result > 0;
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, null);
//        }
//        return false;
//    }
//
//    // Cập nhật thông tin phim
//    public boolean updateMovie(Movie movie) {
//        String sql = "UPDATE movie_ticketing.movies SET title = ?, description = ?, duration = ?, poster_url = ?, genre = ?, rating = ?, age_restriction = ?, release_date = ?, director = ?, cast = ?, trailer_url = ?, status = ? WHERE movie_id = ?";
//        try {
//            Connection connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setString(1, movie.getTitle());
//            ps.setString(2, movie.getDescription());
//            ps.setInt(3, movie.getDuration());
//            ps.setString(4, movie.getPosterUrl());
//            ps.setString(5, movie.getGenre());
//            ps.setDouble(6, movie.getRating());
//            ps.setString(7, movie.getAgeRestriction());
//            ps.setDate(8, movie.getReleaseDate());
//            ps.setString(9, movie.getDirector());
//            ps.setString(10, movie.getCast());
//            ps.setString(11, movie.getTrailerUrl());
//            ps.setString(12, movie.getStatus());
//            ps.setInt(13, movie.getMovieId());
//            
//            int result = ps.executeUpdate();
//            return result > 0;
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, null);
//        }
//        return false;
//    }
//
//    // Xóa phim (soft delete)
//    public boolean deleteMovie(int movieId) {
//        String sql = "UPDATE movie_ticketing.movies SET status = 'inactive' WHERE movie_id = ?";
//        try {
//            Connection connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setInt(1, movieId);
//            
//            int result = ps.executeUpdate();
//            return result > 0;
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, null);
//        }
//        return false;
//    }
//
//    // Lấy phim đang chiếu
//    public ArrayList<Movie> getNowShowingMovies() {
//        ArrayList<Movie> list = new ArrayList<>();
//        String sql = "SELECT * FROM movie_ticketing.movies WHERE status = 'now_showing' ORDER BY release_date DESC";
//        try {
//            Connection connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                Movie movie = new Movie(
//                    rs.getInt("movie_id"),
//                    rs.getString("title"),
//                    rs.getString("description"),
//                    rs.getInt("duration"),
//                    rs.getString("poster_url"),
//                    rs.getString("genre"),
//                    rs.getDouble("rating"),
//                    rs.getString("age_restriction"),
//                    rs.getDate("release_date"),
//                    rs.getString("director"),
//                    rs.getString("cast"),
//                    rs.getString("trailer_url"),
//                    rs.getString("status")
//                );
//                list.add(movie);
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, rs);
//        }
//        return list;
//    }
//
//    // Lấy phim sắp chiếu
//    public ArrayList<Movie> getUpcomingMovies() {
//        ArrayList<Movie> list = new ArrayList<>();
//        String sql = "SELECT * FROM movie_ticketing.movies WHERE status = 'upcoming' ORDER BY release_date ASC";
//        try {
//            Connection connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                Movie movie = new Movie(
//                    rs.getInt("movie_id"),
//                    rs.getString("title"),
//                    rs.getString("description"),
//                    rs.getInt("duration"),
//                    rs.getString("poster_url"),
//                    rs.getString("genre"),
//                    rs.getDouble("rating"),
//                    rs.getString("age_restriction"),
//                    rs.getDate("release_date"),
//                    rs.getString("director"),
//                    rs.getString("cast"),
//                    rs.getString("trailer_url"),
//                    rs.getString("status")
//                );
//                list.add(movie);
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            closeConnection(connection, ps, rs);
//        }
//        return list;
//    }
    
    
    
}

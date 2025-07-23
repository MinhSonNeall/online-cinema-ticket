/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Entity.Cinemas;
import Entity.DateItem;
import Entity.InfomationMovie;
import Entity.Location;
import Entity.Movies;
import Entity.Seats;
import Entity.ShowSeat;
import Entity.ShowtimeSlot;
import Entity.Showtimes;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date; // Import java.sql.Date
import java.sql.Statement; // Import java.sql.Statement

/**
 *
 * @author Cuong
 */
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.time.LocalDateTime;

public class DaoMovie extends DBContext {

    PreparedStatement ps;
    ResultSet rs;

    public String getLastMovieId() {
        String sql = "SELECT movie_id FROM movies ORDER BY movie_id DESC LIMIT 1";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("movie_id");
            }
        } catch (Exception e) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error getting last movie ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }

    public ArrayList<Movies> getAllMovies() {
        ArrayList<Movies> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    m.movie_id,\n"
                + "    m.title,\n"
                + "    m.description,\n"
                + "    m.trailer_url,\n"
                + "    m.poster_url,\n"
                + "    m.duration,\n"
                + "    m.age_restriction,\n"
                + "    \n"
                + "    GROUP_CONCAT(DISTINCT g.name SEPARATOR ', ') AS genres,\n"
                + "    GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS producers\n"
                + "FROM \n"
                + "    movies m\n"
                + "\n"
                + "JOIN \n"
                + "    movie_genres ms ON m.movie_id = ms.movie_id\n"
                + "JOIN \n"
                + "    genres g ON ms.genre_id = g.genre_id\n"
                + "LEFT JOIN \n"
                + "    movie_producers mp ON m.movie_id = mp.movie_id\n"
                + "LEFT JOIN \n"
                + "    producers p ON mp.producer_id = p.producer_id\n"
                + "WHERE \n"
                + "    m.status = 'now_showing'\n"
                + "GROUP BY \n"
                + "    m.movie_id, m.title, m.description, m.trailer_url, m.poster_url, m.duration, m.age_restriction;";
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
                        rs.getString("age_restriction"),
                        rs.getString("poster_url"),
                        rs.getString("trailer_url"),
                        rs.getString("genres"),
                        rs.getString("producers")
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

    public ArrayList<Movies> getAllMoviesForAdmin() {
        ArrayList<Movies> list = new ArrayList<>();
        String sql = "	SELECT\n"
                + "		m.movie_id,\n"
                + "		m.title,\n"
                + "		m.description,\n"
                + "		m.trailer_url,\n"
                + "		m.poster_url,\n"
                + "		m.duration,\n"
                + "		m.age_restriction,m.release_date,\n"
                + "               m.status,\n" // Added status column
                + "		\n"
                + "		GROUP_CONCAT(DISTINCT g.name SEPARATOR ', ') AS genres,\n"
                + "		GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS producers\n"
                + "	FROM \n"
                + "		movies m\n"
                + "	\n"
                + "	JOIN \n"
                + "		movie_genres ms ON m.movie_id = ms.movie_id\n"
                + "	JOIN \n"
                + "		genres g ON ms.genre_id = g.genre_id\n"
                + "	LEFT JOIN \n"
                + "		movie_producers mp ON m.movie_id = mp.movie_id\n"
                + "	LEFT JOIN \n"
                + "		producers p ON mp.producer_id = p.producer_id\n"
                + "	GROUP BY \n"
                + "		m.movie_id, m.title, m.description, m.trailer_url, m.poster_url, m.duration, m.age_restriction,m.release_date, m.status;"; // Added status to GROUP BY
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
                        rs.getString("age_restriction"),
                        rs.getString("poster_url"),
                        rs.getString("trailer_url"),
                        rs.getString("genres"),
                        rs.getString("producers"),
                        rs.getDate("release_date")
                );
                try {
                    movie.setStatus(Movies.Status.valueOf(rs.getString("status").toUpperCase()));
                } catch (IllegalArgumentException e) {
                    movie.setStatus(Movies.Status.COMING_SOON); // Default status if invalid
                }
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
                        rs.getString("age_restriction"),
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

    public Movies detailMovieForAdmin(String movieId) {
        Movies movie = null;
        String sql = "SELECT\n"
                + "    m.movie_id,\n"
                + "    m.title,\n"
                + "    m.description,\n"
                + "    m.trailer_url,\n"
                + "    m.poster_url,\n"
                + "    m.duration,\n"
                + "    m.age_restriction,\n"
                + "    m.release_date,\n"
                + "    m.status,\n"
                + "    m.created_at,\n"
                + "    m.updated_at,\n"
                + "    GROUP_CONCAT(DISTINCT g.name SEPARATOR ', ') AS genres,\n"
                + "    GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS producers\n"
                + "FROM \n"
                + "    movies m\n"
                + "JOIN \n"
                + "    movie_genres ms ON m.movie_id = ms.movie_id\n"
                + "JOIN \n"
                + "    genres g ON ms.genre_id = g.genre_id\n"
                + "LEFT JOIN \n"
                + "    movie_producers mp ON m.movie_id = mp.movie_id\n"
                + "LEFT JOIN \n"
                + "    producers p ON mp.producer_id = p.producer_id\n"
                + "WHERE \n"
                + "    m.movie_id LIKE ?\n"
                + "GROUP BY \n"
                + "    m.movie_id, m.title, m.description, m.trailer_url, m.poster_url, m.duration, m.age_restriction, m.release_date, m.status, m.created_at, m.updated_at;";
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
                        rs.getString("age_restriction"),
                        rs.getString("poster_url"),
                        rs.getString("trailer_url"),
                        rs.getString("genres"), // genres
                        rs.getString("producers"), // producers
                        rs.getDate("release_date")
                );
                movie.setCreated_at(rs.getTimestamp("created_at"));
                movie.setUpdated_at(rs.getTimestamp("updated_at"));
                try {
                    movie.setStatus(Movies.Status.valueOf(rs.getString("status").toUpperCase()));
                } catch (IllegalArgumentException e) {
                    movie.setStatus(Movies.Status.COMING_SOON); // Default status if invalid
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error getting movie details for admin: " + ex.getMessage(), ex);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return movie;
    }

    public Movies getMovieByIdMovieDetails(String movieId) {
        Movies movie = null;
        String sql = "SELECT\n"
                + "    m.movie_id,\n"
                + "    m.title,\n"
                + "    m.description,\n"
                + "    m.trailer_url,\n"
                + "    m.poster_url,\n"
                + "    m.duration,\n"
                + "    m.age_restriction,\n"
                + "    s.start_time,\n"
                + "    GROUP_CONCAT(DISTINCT g.name SEPARATOR ', ') AS genres,\n"
                + "    GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS producers\n"
                + "FROM \n"
                + "    movies m\n"
                + "JOIN \n"
                + "    showtimes s ON m.movie_id = s.movie_id\n"
                + "JOIN \n"
                + "    movie_genres ms ON m.movie_id = ms.movie_id\n"
                + "JOIN \n"
                + "    genres g ON ms.genre_id = g.genre_id\n"
                + "LEFT JOIN \n"
                + "    movie_producers mp ON m.movie_id = mp.movie_id\n"
                + "LEFT JOIN \n"
                + "    producers p ON mp.producer_id = p.producer_id\n"
                + "WHERE \n"
                + "    m.movie_id like ?\n"
                + "GROUP BY \n"
                + "    m.movie_id, m.title, m.description, m.trailer_url, m.poster_url, m.duration, m.age_restriction, s.start_time;";
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
                        rs.getString("age_restriction"),
                        rs.getString("start_time"),
                        rs.getString("genres"),
                        rs.getString("producers")
                );
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return movie;
    }

    public List<ShowtimeSlot> getTimeSlot(String movie_id, String cityname, String date, String room_id) {
        List<ShowtimeSlot> showtimeslotList = new ArrayList();
        String sql = "select sl.start_time,sl.end_time,se.price,sl.slot_id,c.city,r.room_id, count(se.seat_id) as seat_avaiable from showtimes s\n"
                + "join rooms r on s.room_id = r.room_id\n"
                + "join cinemas c on r.cinema_id = c.cinema_id\n"
                + "join showtime_slots sl on s.showtime_id = sl.showtime_id\n"
                + "join seats se on sl.slot_id = se.slot_id\n"
                + "where s.movie_id = ? and c.city = ? and sl.date = ? and r.room_id = ? and se.check_seat != 1\n"
                + "group by sl.start_time,sl.end_time,se.price,sl.slot_id,c.city,r.room_id";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movie_id);
            ps.setString(2, cityname);
            ps.setString(3, date);
            ps.setString(4, room_id);

            rs = ps.executeQuery();
            while (rs.next()) {
                String starttime = rs.getString("start_time");
                String endtime = rs.getString("end_time");
                String seat_avaiable = rs.getString("seat_avaiable");
                String price = rs.getString("price");
                String slot_id = rs.getString("slot_id");
                String city = rs.getString("city");
                String room_id_input = rs.getString("room_id");
                showtimeslotList.add(new ShowtimeSlot(starttime, endtime, seat_avaiable, price, slot_id, city, room_id_input));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return showtimeslotList;
    }

    public InfomationMovie getInfomation(String movie_id, String cityname, String date, String room_id, String slot_id) {
        InfomationMovie infomationMovie = null;
        String sql = "select distinct s.showtime_id,c.name,sl.start_time,sl.end_time,se.price, count(se.seat_id) as avaiable_seat from showtimes s\n"
                + "join rooms r on s.room_id = r.room_id\n"
                + "join cinemas c on r.cinema_id = c.cinema_id\n"
                + "join showtime_slots sl on s.showtime_id = sl.showtime_id\n"
                + "join seats se on sl.slot_id = se.slot_id\n"
                + "where s.movie_id = ? and c.city = ? and sl.date = ? and r.room_id = ? and sl.slot_id = ? and se.check_seat != 1\n"
                + "group by c.name,sl.start_time,sl.end_time,se.price";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movie_id);
            ps.setString(2, cityname);
            ps.setString(3, date);
            ps.setString(4, room_id);
            ps.setString(5, slot_id);

            rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String starttime = rs.getString("start_time");
                String endtime = rs.getString("end_time");
                String avaiable = rs.getString("avaiable_seat");
                String price = rs.getString("price");
                String showtime = rs.getString("showtime_id");
                infomationMovie = new InfomationMovie(name, starttime, endtime, avaiable, showtime);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return infomationMovie;
    }

    public List<ShowSeat> getShowSeat(String movie_id, String cityname, String date, String room_id, String slot_id) {
        List<ShowSeat> showSeatList = new ArrayList();
        String sql = "select se.seat_number,se.check_seat,se.price from showtimes s\n"
                + "join rooms r on s.room_id = r.room_id\n"
                + "join cinemas c on r.cinema_id = c.cinema_id\n"
                + "join showtime_slots sl on s.showtime_id = sl.showtime_id\n"
                + "join seats se on sl.slot_id = se.slot_id\n"
                + "where s.movie_id = ? and c.city = ? and sl.date = ? and r.room_id = ? and sl.slot_id = ?;";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movie_id);
            ps.setString(2, cityname);
            ps.setString(3, date);
            ps.setString(4, room_id);
            ps.setString(5, slot_id);

            rs = ps.executeQuery();
            while (rs.next()) {
                String seat_number = rs.getString("seat_number");
                String check_seat = rs.getString("check_seat");
                String price = rs.getString("price");
                showSeatList.add(new ShowSeat(seat_number, check_seat, price));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return showSeatList;
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
                String start = rs.getString("start_time");
                String end = rs.getString("end_time");

                if (start == null || end == null) {
                    return dateList;
                }

                LocalDate startDate = LocalDate.parse(start.split(" ")[0]);
                LocalDate endate = LocalDate.parse(end.split(" ")[0]);

                LocalDate beginDay = getDateNoew.isBefore(startDate) ? startDate : getDateNoew;
                if (getDateNoew.isAfter(endate)) {
                    return dateList;
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
        String sql = "SELECT s.showtime_id, s.start_time, s.ticket_price "
                + "FROM movie_ticketing.showtimes s "
                + "JOIN movie_ticketing.rooms r ON s.room_id = r.room_id "
                + "JOIN movie_ticketing.cinemas c ON r.cinema_id = c.cinema_id "
                + "WHERE s.movie_id = ? "
                + "AND NOW() BETWEEN s.start_time AND s.end_time";
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
        String sql = "SELECT DISTINCT c.city "
                + "FROM showtimes s "
                + "JOIN rooms r ON s.room_id = r.room_id "
                + "JOIN cinemas c ON r.cinema_id = c.cinema_id "
                + "WHERE s.movie_id = ? AND DATE(s.start_time) <= ? AND DATE(s.end_time) >= ?";

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            ps.setString(2, selectedDate.toString());
            ps.setString(3, selectedDate.toString());
            rs = ps.executeQuery();

//        boolean isFirst = true;
            while (rs.next()) {
                Location location = new Location();
                location.setName(rs.getString("city"));
//            location.setActive(isFirst); // Đặt rạp đầu tiên là active
                locationList.add(location);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return locationList;
    }

    public List<Cinemas> GetCinemaByCity(String movieId, String selectedCityName) {
        List<Cinemas> listCinema = new ArrayList<>();
        String sql = "select c.name,r.room_id,c.city from showtimes s\n"
                + "join rooms r on s.room_id = r.room_id\n"
                + "join cinemas c on r.cinema_id = c.cinema_id\n"
                + "where s.movie_id = ? and c.city = ?";

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            ps.setString(2, selectedCityName);
            rs = ps.executeQuery();

            while (rs.next()) {
                Cinemas cinemas = new Cinemas();
                cinemas.setName(rs.getString("name"));
                cinemas.setCinema_id(rs.getString("room_id"));
                cinemas.setCity(rs.getString("city"));
                listCinema.add(cinemas);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return listCinema;
    }

    public int getRemainingSeats(String showtimeId) {
        int remainingSeats = 0;
        String sql = "SELECT COUNT(*) "
                + "FROM movie_ticketing.seats s "
                + "JOIN movie_ticketing.showtimes st ON s.room_id = st.room_id "
                + "WHERE st.showtime_id = ? AND NOT EXISTS ("
                + "SELECT 1 FROM movie_ticketing.ticket_seats ts "
                + "JOIN movie_ticketing.tickets t ON ts.ticket_id = t.ticket_id "
                + "WHERE ts.seat_id = s.seat_id AND t.showtime_id = ? AND t.status = 'confirmed')";
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
        String sql = "SELECT s.seat_id, s.seat_number, s.type, s.price, "
                + "EXISTS (SELECT 1 FROM movie_ticketing.ticket_seats ts "
                + "JOIN movie_ticketing.tickets t ON ts.ticket_id = t.ticket_id "
                + "WHERE ts.seat_id = s.seat_id AND t.showtime_id = ? AND t.status = 'confirmed') as is_booked "
                + "FROM movie_ticketing.seats s "
                + "JOIN movie_ticketing.showtimes st ON s.room_id = st.room_id "
                + "WHERE st.showtime_id = ?";
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

    // Add new movie method
    public boolean addMovie(Movies movie) {
        String sql = "INSERT INTO movie_ticketing.movies (movie_id, title, description, trailer_url, poster_url, duration, age_restriction, release_date, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movie.getMovie_id());
            ps.setString(2, movie.getTitle());
            ps.setString(3, movie.getDescription());
            ps.setString(4, movie.getTrailer_url());
            ps.setString(5, movie.getPoster_url());
            ps.setInt(6, movie.getDuration());
            ps.setString(7, movie.getAge_restriction());
            ps.setDate(8, movie.getRelease_date());
            ps.setString(9, movie.getStatus().name().toLowerCase()); // Convert enum to string
            ps.setTimestamp(10, movie.getCreated_at());
            ps.setTimestamp(11, movie.getUpdated_at());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception ex) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error adding movie: " + ex.getMessage(), ex);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }


    public boolean deleteMovie(String movieId) {
        String sql = "delete from movies where movie_id =?";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception ex) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error deleting movie: " + ex.getMessage(), ex);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public boolean updateMovie(Movies movie) {
        String sql = "UPDATE movies SET title = ?, description = ?, trailer_url = ?, poster_url = ?, duration = ?, age_restriction = ?, release_date = ?, updated_at = ? WHERE movie_id = ?";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getDescription());
            ps.setString(3, movie.getTrailer_url());
            ps.setString(4, movie.getPoster_url());
            ps.setInt(5, movie.getDuration());
            ps.setString(6, movie.getAge_restriction());
            ps.setDate(7, movie.getRelease_date());
            ps.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now())); // Update updated_at
            ps.setString(9, movie.getMovie_id());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception ex) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error updating movie: " + ex.getMessage(), ex);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public boolean updateMovieStatus(String movieId, String newStatus) {
        String sql = "UPDATE movie_ticketing.movies SET status = ?, updated_at = ? WHERE movie_id = ?";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus.toLowerCase());
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, movieId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error updating movie status: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    // Search movies by title
    public List<Movies> searchMoviesByTitle(String title) {
    List<Movies> movies = new ArrayList<>();
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    String sql = "SELECT\n"
            + "    m.movie_id,\n"
            + "    m.title,\n"
            + "    m.description,\n"
            + "    m.trailer_url,\n"
            + "    m.poster_url,\n"
            + "    m.duration,\n"
            + "    m.age_restriction,\n"
            + "    m.release_date,\n"
            + "    m.status,\n"
            + "    m.created_at,\n"
            + "    m.updated_at,\n"
            + "    GROUP_CONCAT(DISTINCT g.name SEPARATOR ', ') AS genres,\n"
            + "    GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS producers\n"
            + "FROM \n"
            + "    movies m\n"
            + "JOIN \n"
            + "    movie_genres ms ON m.movie_id = ms.movie_id\n"
            + "JOIN \n"
            + "    genres g ON ms.genre_id = g.genre_id\n"
            + "LEFT JOIN \n"
            + "    movie_producers mp ON m.movie_id = mp.movie_id\n"
            + "LEFT JOIN \n"
            + "    producers p ON mp.producer_id = p.producer_id\n"
            + "WHERE \n"
            + "    m.title LIKE ?\n"
            + "GROUP BY \n"
            + "    m.movie_id, m.title, m.description, m.trailer_url, m.poster_url, m.duration, m.age_restriction, m.release_date, m.status, m.created_at, m.updated_at;";
    
    try {
        connection = getConnection();
        ps = connection.prepareStatement(sql);
        ps.setString(1, "%" + title + "%");
        rs = ps.executeQuery();
        
        while (rs.next()) {
            Movies movie = new Movies(
                    rs.getString("movie_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("duration"),
                    rs.getString("age_restriction"),
                    rs.getString("poster_url"),
                    rs.getString("trailer_url"),
                    rs.getString("genres"),
                    rs.getString("producers"),
                    rs.getDate("release_date")
            );
            movie.setCreated_at(rs.getTimestamp("created_at"));
            movie.setUpdated_at(rs.getTimestamp("updated_at"));
            try {
                movie.setStatus(Movies.Status.valueOf(rs.getString("status").toUpperCase()));
            } catch (IllegalArgumentException e) {
                movie.setStatus(Movies.Status.COMING_SOON); // Default status if invalid
            }
            movies.add(movie);
        }
    } catch (Exception ex) {
        Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error searching movies by title: " + ex.getMessage(), ex);
    } finally {
        closeConnection(connection, ps, rs);
    }
    
    return movies;
}
}

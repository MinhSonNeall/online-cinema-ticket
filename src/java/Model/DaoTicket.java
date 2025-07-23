/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Entity.TicketPayment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 *
 * @author Cuong
 */
public class DaoTicket extends DBContext{
    PreparedStatement ps;
    ResultSet rs;
    
    
    public String insertMovie(TicketPayment payment) {
    PreparedStatement psInsertTicket = null;
    PreparedStatement psInsertTicketSeat = null;
    PreparedStatement psUpdateSeat = null;
    boolean isInserted = false;
    
    String ticketId = UUID.randomUUID().toString();


    String insertTicketSQL = "INSERT INTO movie_ticketing.tickets " +
            "(ticket_id, user_id, showtime_id, booking_date, total_amount, status) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

    String insertTicketSeatSQL = "INSERT INTO movie_ticketing.ticket_seats (ticket_id, seat_id) VALUES (?, ?)";

    String updateSeatSQL = "UPDATE movie_ticketing.seats SET check_seat = ? WHERE seat_id = ?";

    try {
        connection = getConnection();
        connection.setAutoCommit(false); // Bắt đầu transaction

        // 1. Thêm ticket
        psInsertTicket = connection.prepareStatement(insertTicketSQL);
        psInsertTicket.setString(1, ticketId);
        psInsertTicket.setString(2, payment.getUser_id());
        psInsertTicket.setString(3, payment.getShowtime_id());
        psInsertTicket.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis())); // booking_date
        psInsertTicket.setString(5, payment.getTotal_amount());
        psInsertTicket.setString(6, "confirmed");

        psInsertTicket.executeUpdate();

        // 2. Thêm ghế đã đặt
        psInsertTicketSeat = connection.prepareStatement(insertTicketSeatSQL);
        psUpdateSeat = connection.prepareStatement(updateSeatSQL);

        for (String seatId : payment.getSeat_ids()) {
            // insert vào ticket_seats
            psInsertTicketSeat.setString(1, ticketId);
            psInsertTicketSeat.setString(2, seatId);
            psInsertTicketSeat.executeUpdate();

            // cập nhật trạng thái ghế
            psUpdateSeat.setBoolean(1, true); // check_seat = true (ghế đã đặt)
            psUpdateSeat.setString(2, seatId);
            psUpdateSeat.executeUpdate();
        }

        // 3. Commit giao dịch
        connection.commit();
    } catch (Exception ex) {
        ex.printStackTrace();
        if (connection != null) {
            try {
                connection.rollback();
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
                return null;
            }
        }
    } finally {
        closeConnection(connection, psInsertTicket, null);
        closeConnection(null, psInsertTicketSeat, null);
        closeConnection(null, psUpdateSeat, null);
    }
    return ticketId;
}

public List<TicketPayment> getTicketsByUserId(String userId) {
    List<TicketPayment> tickets = new ArrayList<>();

    String sql = "SELECT t.ticket_id,t.user_id,t.showtime_id,t.booking_date,t.total_amount,s.seat_id,st.room_id"
            + ",m.title,stl.date,stl.start_time,stl.end_time"
            + ",r.name as room_name,c.name as cinema_name " +
                 "FROM movie_ticketing.tickets t " +
                 "JOIN movie_ticketing.ticket_seats s ON t.ticket_id = s.ticket_id " +
                 "JOIN movie_ticketing.seats seat ON s.seat_id = seat.seat_id " +
                 "JOIN movie_ticketing.showtimes st ON t.showtime_id = st.showtime_id " +
                 "JOIN movie_ticketing.movies m ON st.movie_id = m.movie_id " +
                 "JOIN movie_ticketing.rooms r ON st.room_id = r.room_id " +
                 "JOIN movie_ticketing.cinemas c ON r.cinema_id = c.cinema_id " +
                 "JOIN movie_ticketing.showtime_slots stl ON seat.slot_id = stl.slot_id " +
                 "WHERE t.user_id = ? " +
                 "ORDER BY t.booking_date DESC";

    try {
        connection = getConnection();
        ps = connection.prepareStatement(sql);
        ps.setString(1, userId);
        rs = ps.executeQuery();

        // Dùng map để gom ghế theo ticket_id
        Map<String, TicketPayment> ticketMap = new LinkedHashMap<>();

        while (rs.next()) {
            String ticketId = rs.getString("ticket_id");

            TicketPayment ticket = ticketMap.get(ticketId);
            if (ticket == null) {
                ticket = new TicketPayment();
                ticket.setTicket_id(ticketId);
                ticket.setUser_id(rs.getString("user_id"));
                ticket.setShowtime_id(rs.getString("showtime_id"));
                ticket.setBook_date(rs.getTimestamp("booking_date"));
                ticket.setTotal_amount(rs.getString("total_amount"));
                ticket.setMovieTitle(rs.getString("title"));
                ticket.setShowDate(rs.getString("date"));
                ticket.setStartTime(rs.getString("start_time"));
                ticket.setEndTime(rs.getString("end_time"));
                ticket.setRoomName(rs.getString("room_name"));
                ticket.setCinemaName(rs.getString("cinema_name"));
                ticket.setSeat_ids(new ArrayList<>());
                ticketMap.put(ticketId, ticket);
            }

            ticket.getSeat_ids().add(rs.getString("seat_id"));
        }

        tickets.addAll(ticketMap.values());

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        closeConnection(connection, ps, rs);
    }

    return tickets;
}

}

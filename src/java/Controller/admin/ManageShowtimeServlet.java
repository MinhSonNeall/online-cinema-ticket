package Controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;
import Model.DaoShowtime;
import Model.DaoMovie;
import Model.DaoRoom;
import Model.DaoSeat;
import Model.DaoCinema;
import Entity.Showtimes;
import Entity.Seats;
import Entity.Rooms;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.math.BigDecimal;
import java.util.Map;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "ManageShowtimeServlet", urlPatterns = {"/ManageShowtime"})
public class ManageShowtimeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        System.out.println("Debug - doGet called with action: " + action);
        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteShowtime(request, response);
                break;
            case "add-slot":
                showAddSlotForm(request, response);
                break;
            case "view-slots":
                viewShowtimeSlots(request, response);
                break;
            case "get-rooms":
                getRoomsByCinema(request, response);
                break;
            case "search":
                searchShowtimes(request, response);
                break;
            default:
                listShowtimes(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action==null){
            action="list";
        }
        switch (action) {
            case "add":
                addShowtime(request, response);
                break;
            case "edit":
                updateShowtime(request, response);
                break;
            case "add-slot":
                addShowtimeSlot(request, response);
                break;
            case "search":
                searchShowtimes(request, response);
                break;
            case "list":
                    listShowtimes(request, response);
                    break;
        }
    }

    private void searchShowtimes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieTitle = request.getParameter("movieTitle");
        DaoShowtime daoShowtime = new DaoShowtime();
        
        List<Showtimes> showtimeList;
        if (movieTitle != null && !movieTitle.trim().isEmpty()) {
            showtimeList = daoShowtime.searchShowtimesByMovieTitle(movieTitle);
            request.setAttribute("searchTerm", movieTitle); // Store search term to display in the form
        } else {
            showtimeList = daoShowtime.getAllShowtimes();
        }
        
        request.setAttribute("showtimeList", showtimeList);
        request.getRequestDispatcher("/jsp/admin/manageShowtime.jsp").forward(request, response);
    }

    private void listShowtimes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DaoShowtime daoShowtime = new DaoShowtime();
        List<Showtimes> showtimeList = daoShowtime.getAllShowtimes();
        request.setAttribute("showtimeList", showtimeList);
        request.getRequestDispatcher("/jsp/admin/manageShowtime.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DaoMovie daoMovie = new DaoMovie();
        DaoCinema daoCinema = new DaoCinema();
        request.setAttribute("movieList", daoMovie.getAllMovies());
        request.setAttribute("cinemaList", daoCinema.getAllCinemas());
        request.getRequestDispatcher("/jsp/admin/addShowtime.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String showtimeId = request.getParameter("id");
        DaoShowtime daoShowtime = new DaoShowtime();
        Showtimes showtime = daoShowtime.getShowtimeById(showtimeId);
        request.setAttribute("showtime", showtime);
        request.getRequestDispatcher("/jsp/admin/editShowtime.jsp").forward(request, response);
    }

    private void deleteShowtime(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String showtimeId = request.getParameter("id");
        DaoShowtime daoShowtime = new DaoShowtime();
        daoShowtime.deleteShowtime(showtimeId);
        response.sendRedirect(request.getContextPath() + "/ManageShowtime");
    }

    private void addShowtime(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String movieId = request.getParameter("movieId");
            String cinemaId = request.getParameter("cinemaId"); // Thêm tham số cinemaId
            String roomId = request.getParameter("roomId");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            
            System.out.println("Debug - Add Showtime Input:");
            System.out.println("movieId: " + movieId);
            System.out.println("cinemaId: " + cinemaId);
            System.out.println("roomId: " + roomId);
            System.out.println("startTimeStr: " + startTimeStr);
            System.out.println("endTimeStr: " + endTimeStr);
            
            // Kiểm tra xem phòng có thuộc rạp đã chọn không
            DaoRoom daoRoom = new DaoRoom();
            Rooms room = daoRoom.getRoomById(roomId);
            
            if (room == null || !room.getCinema_id().equals(cinemaId)) {
                request.setAttribute("error", "Phòng không hợp lệ hoặc không thuộc rạp đã chọn!");
                showAddForm(request, response);
                return;
            }
            
            Timestamp startTime = Timestamp.valueOf(startTimeStr + " 00:00:00");
            Timestamp endTime = Timestamp.valueOf(endTimeStr + " 00:00:00");
            
            // Kiểm tra thời gian hợp lệ
            if (startTime.after(endTime)) {
                request.setAttribute("error", "Ngày bắt đầu không thể sau ngày kết thúc!");
                showAddForm(request, response);
                return;
            }
            
            // Kiểm tra trùng lặp showtime
            DaoShowtime daoShowtime = new DaoShowtime();
            boolean isOverlapping = daoShowtime.isShowtimeOverlapping(movieId, roomId, startTime, endTime);
            
            if (isOverlapping) {
                request.setAttribute("error", "Không thể thêm đợt chiếu mới! Đã có đợt chiếu khác của phim này trong cùng phòng và thời gian trùng lặp.");
                showAddForm(request, response);
                return;
            }
            
            // Tiếp tục thêm showtime mới nếu không có trùng lặp
            int maxId = daoShowtime.getMaxShowtimeId();
            String newShowtimeId = String.valueOf(maxId + 1);
            
            Showtimes showtime = new Showtimes();
            showtime.setShowtime_id(newShowtimeId);
            showtime.setMovie_id(movieId);
            showtime.setRoom_id(roomId);
            showtime.setStart_time(startTime);
            showtime.setEnd_time(endTime);
            
            // Thiết lập giá vé mặc định
            BigDecimal ticketPrice = new BigDecimal("5000.00");
            showtime.setTicket_price(ticketPrice);
            System.out.println("Debug - Setting default ticket price: " + ticketPrice);
            
            daoShowtime.addShowtime(showtime);
            
            request.getSession().setAttribute("success", "Thêm đợt chiếu mới thành công!");
            response.sendRedirect(request.getContextPath() + "/ManageShowtime");
        } catch (Exception e) {
            System.out.println("Error in addShowtime: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            showAddForm(request, response);
        }
    }

    private void updateShowtime(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String showtimeId = request.getParameter("showtimeId");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            
            DaoShowtime daoShowtime = new DaoShowtime();
            Showtimes showtime = daoShowtime.getShowtimeById(showtimeId);
            
            if (showtime == null) {
                request.getSession().setAttribute("error", "Không tìm thấy đợt chiếu cần cập nhật!");
                response.sendRedirect(request.getContextPath() + "/ManageShowtime");
                return;
            }
            
            Timestamp startTime = Timestamp.valueOf(startTimeStr + " 00:00:00");
            Timestamp endTime = Timestamp.valueOf(endTimeStr + " 00:00:00");
            
            // Kiểm tra thời gian hợp lệ
            if (startTime.after(endTime)) {
                request.getSession().setAttribute("error", "Ngày bắt đầu không thể sau ngày kết thúc!");
                response.sendRedirect(request.getContextPath() + "/ManageShowtime?action=edit&id=" + showtimeId);
                return;
            }
            
            // Kiểm tra trùng lặp với các showtime khác (ngoại trừ chính nó)
            String sql = "SELECT s.showtime_id, m.title, r.name as room_name, c.name as cinema_name, s.start_time, s.end_time " +
                         "FROM Showtimes s " +
                         "JOIN Movies m ON s.movie_id = m.movie_id " +
                         "JOIN Rooms r ON s.room_id = r.room_id " +
                         "JOIN Cinemas c ON r.cinema_id = c.cinema_id " +
                         "WHERE s.movie_id = ? AND s.room_id = ? " +
                         "AND s.showtime_id != ? " +
                         "AND NOT (s.end_time < ? OR s.start_time > ?)";
            
            try (Connection connection = daoShowtime.getConnection();
                 PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, showtime.getMovie_id());
                ps.setString(2, showtime.getRoom_id());
                ps.setString(3, showtimeId);
                ps.setTimestamp(4, startTime);
                ps.setTimestamp(5, endTime);
                
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    // Tìm thấy showtime khác bị trùng
                    request.getSession().setAttribute("error", "Không thể cập nhật đợt chiếu! Đã có đợt chiếu khác của phim này trong cùng phòng và thời gian trùng lặp.");
                    response.sendRedirect(request.getContextPath() + "/ManageShowtime?action=edit&id=" + showtimeId);
                    return;
                }
            } catch (Exception e) {
                System.out.println("Error checking overlapping showtimes in update: " + e.getMessage());
                e.printStackTrace();
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi kiểm tra trùng lặp: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/ManageShowtime?action=edit&id=" + showtimeId);
                return;
            }
            
            // Cập nhật showtime nếu không có trùng lặp
            showtime.setStart_time(startTime);
            showtime.setEnd_time(endTime);
            daoShowtime.updateShowtime(showtime);
            
            request.getSession().setAttribute("success", "Cập nhật đợt chiếu thành công!");
            response.sendRedirect(request.getContextPath() + "/ManageShowtime");
        } catch (Exception e) {
            System.out.println("Error in updateShowtime: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ManageShowtime");
        }
    }

    private void showAddSlotForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String showtimeId = request.getParameter("id");
        DaoShowtime daoShowtime = new DaoShowtime();
        Showtimes showtime = daoShowtime.getShowtimeById(showtimeId);
        request.setAttribute("showtime", showtime);
        request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
    }

    private void addShowtimeSlot(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String showtimeId = request.getParameter("showtimeId");
            String dateStr = request.getParameter("date");
            String slotStartTime = request.getParameter("slotStartTime");
            String slotEndTime = request.getParameter("slotEndTime");
            
            System.out.println("Debug - Input values:");
            System.out.println("showtimeId: " + showtimeId);
            System.out.println("dateStr: " + dateStr);
            System.out.println("slotStartTime: " + slotStartTime);
            System.out.println("slotEndTime: " + slotEndTime);

            DaoShowtime daoShowtime = new DaoShowtime();
            Showtimes showtime = daoShowtime.getShowtimeById(showtimeId);
            
            if (showtime == null) {
                System.out.println("Error: Showtime not found with ID: " + showtimeId);
                request.setAttribute("error", "Không tìm thấy đợt chiếu với ID: " + showtimeId);
                request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
                return;
            }

            // Kiểm tra ngày có nằm trong khoảng của đợt chiếu không
            LocalDate slotDate = LocalDate.parse(dateStr);
            LocalDate showStart = showtime.getStart_time().toLocalDateTime().toLocalDate();
            LocalDate showEnd = showtime.getEnd_time().toLocalDateTime().toLocalDate();
            
            System.out.println("Debug - Date comparison:");
            System.out.println("slotDate: " + slotDate);
            System.out.println("showStart: " + showStart);
            System.out.println("showEnd: " + showEnd);
            System.out.println("Room ID:" + showtime.getRoom_id());

            if (slotDate.isBefore(showStart) || slotDate.isAfter(showEnd)) {
                request.setAttribute("error", "Ngày suất chiếu phải nằm trong khoảng thời gian của đợt chiếu!");
                request.setAttribute("showtime", showtime);
                request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
                return;
            }

            // Chuẩn hóa định dạng thời gian
            slotStartTime = standardizeTimeFormat(slotStartTime);
            slotEndTime = standardizeTimeFormat(slotEndTime);
            
            System.out.println("Debug - Standardized times:");
            System.out.println("slotStartTime: " + slotStartTime);
            System.out.println("slotEndTime: " + slotEndTime);
            
            // Kiểm tra xem khung giờ mới có bị trùng với khung giờ nào khác trong cùng phòng và ngày không
            if (daoShowtime.isTimeSlotOverlapping(showtime.getRoom_id(), dateStr, slotStartTime, slotEndTime)) {
                System.out.println("Debug - Time slot overlapping detected!");
                request.setAttribute("error", "Không thể thêm suất chiếu do đã có phim khác chiếu trong khung giờ này!");
                request.setAttribute("showtime", showtime);
                request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
                return;
            }

            // Insert slot
            String newSlotId = daoShowtime.generateNextSlotId();
            System.out.println("Debug - Generated slotId: " + newSlotId);
            
            try {
                daoShowtime.insertSlot(newSlotId, showtimeId, dateStr, slotStartTime, slotEndTime);
                System.out.println("Debug - Slot inserted successfully with ID: " + newSlotId);
            } catch (Exception e) {
                System.out.println("Error inserting slot: " + e.getMessage());
                request.setAttribute("error", "Lỗi khi thêm suất chiếu: " + e.getMessage());
                request.setAttribute("showtime", showtime);
                request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
                return;
            }
            
            // Sinh seat cho slot
            DaoRoom daoRoom = new DaoRoom();
            Rooms room = daoRoom.getRoomById(showtime.getRoom_id());
            
            if (room == null) {
                System.out.println("Error: Room not found with ID: " + showtime.getRoom_id());
                request.setAttribute("error", "Không tìm thấy phòng với ID: " + showtime.getRoom_id());
                request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
                return;
            }
            
            int totalSeats = room.getTotal_seats();
            System.out.println("Debug - Room ID: " + room.getRoom_id() + ", Total seats to generate: " + totalSeats);

            DaoSeat daoSeat = new DaoSeat();
            int successCount = 0;
            
            try {
                for (int i = 1; i <= totalSeats; i++) {
                    String seatNumber = "A" + i;
                    System.out.println("Debug - Generating seat ID for seat " + seatNumber);
                    String seatId = daoSeat.generateNextSeatId();
                    System.out.println("Debug - Generated seat ID: " + seatId + " for seat " + seatNumber);
                    
                    Seats seat = new Seats();
                    seat.setSeat_id(seatId);
                    seat.setRoom_id(room.getRoom_id());
                    seat.setSeat_number(seatNumber);
                    seat.setType(Seats.Type.STANDARD);
                    seat.setPrice(new BigDecimal(5000));
                    
                    System.out.println("Debug - Creating seat: ID=" + seatId + ", Room=" + room.getRoom_id() + 
                                      ", Number=" + seatNumber + ", SlotID=" + newSlotId);
                    
                    daoSeat.insertSeatForSlot(seat, newSlotId);
                    successCount++;
                    System.out.println("Debug - Seat created successfully: " + seatNumber + " with ID=" + seatId);
                }
                
                System.out.println("Debug - Successfully created " + successCount + " seats for slot " + newSlotId);
            } catch (Exception e) {
                System.out.println("Error creating seats: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi tạo ghế: " + e.getMessage() + 
                                    ". Đã tạo được " + successCount + "/" + totalSeats + " ghế.");
                request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
                return;
            }
            
            // Thiết lập thông báo thành công và chuyển hướng
            request.getSession().setAttribute("success", "Thêm suất chiếu và tạo " + successCount + " ghế thành công!");
            response.sendRedirect(request.getContextPath() + "/ManageShowtime");
        } catch (Exception e) {
            System.out.println("Error in addShowtimeSlot: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/jsp/admin/addShowtimeSlot.jsp").forward(request, response);
        }
    }
    
    /**
     * Chuẩn hóa định dạng thời gian từ AM/PM sang định dạng 24h
     * Ví dụ: 7:23:23PM -> 19:23:23, 8:32:23AM -> 08:32:23
     */
    private String standardizeTimeFormat(String timeStr) {
        try {
            // Xử lý trường hợp thiếu giây
            if (timeStr.split(":").length == 2) {
                timeStr += ":00";
            }
            
            // Kiểm tra có chứa AM/PM không
            boolean hasPM = timeStr.toUpperCase().contains("PM");
            boolean hasAM = timeStr.toUpperCase().contains("AM");
            
            if (hasPM || hasAM) {
                // Loại bỏ AM/PM để xử lý
                timeStr = timeStr.toUpperCase().replace("AM", "").replace("PM", "").trim();
                
                // Tách giờ, phút, giây
                String[] parts = timeStr.split(":");
                int hour = Integer.parseInt(parts[0]);
                
                // Nếu là PM và giờ < 12, cộng thêm 12
                if (hasPM && hour < 12) {
                    hour += 12;
                }
                
                // Nếu là AM và giờ = 12, đổi thành 0
                if (hasAM && hour == 12) {
                    hour = 0;
                }
                
                // Định dạng lại chuỗi giờ
                return String.format("%02d:%s:%s", hour, parts[1], parts[2]);
            } else {
                // Nếu không có AM/PM, đảm bảo định dạng HH:MM:SS
                String[] parts = timeStr.split(":");
                int hour = Integer.parseInt(parts[0]);
                return String.format("%02d:%s:%s", hour, parts[1], parts[2]);
            }
        } catch (Exception e) {
            System.out.println("Error standardizing time format: " + e.getMessage());
            return timeStr; // Trả về chuỗi gốc nếu có lỗi
        }
    }

    // API để lấy danh sách phòng theo rạp
    private void getRoomsByCinema(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cinemaId = request.getParameter("cinemaId");
        System.out.println("Debug - getRoomsByCinema called with cinemaId: " + cinemaId);
        
        DaoRoom daoRoom = new DaoRoom();
        List<Rooms> rooms = daoRoom.getRoomsByCinemaId(cinemaId);
        System.out.println("Debug - Received " + rooms.size() + " rooms from database");
        
        // Chuyển danh sách phòng thành JSON
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");
        for (int i = 0; i < rooms.size(); i++) {
            Rooms room = rooms.get(i);
            jsonBuilder.append("{\"room_id\":\"").append(room.getRoom_id()).append("\",");
            jsonBuilder.append("\"name\":\"").append(room.getName()).append("\"}");
            if (i < rooms.size() - 1) {
                jsonBuilder.append(",");
            }
            System.out.println("Debug - Added room to JSON: ID=" + room.getRoom_id() + ", Name=" + room.getName());
        }
        jsonBuilder.append("]");
        
        String jsonResponse = jsonBuilder.toString();
        System.out.println("Debug - JSON response: " + jsonResponse);
        
        // Gửi JSON về client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
        System.out.println("Debug - JSON response sent to client");
    }

    // Phương thức để hiển thị danh sách showtime_slots theo showtime_id
    private void viewShowtimeSlots(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String showtimeId = request.getParameter("id");
        System.out.println("Debug - viewShowtimeSlots called with showtimeId: " + showtimeId);
        
        DaoShowtime daoShowtime = new DaoShowtime();
        Showtimes showtime = daoShowtime.getShowtimeById(showtimeId);
        List<Map<String, Object>> slots = daoShowtime.getShowtimeSlotsByShowtimeId(showtimeId);
        
        request.setAttribute("showtime", showtime);
        request.setAttribute("slots", slots);
        request.setAttribute("slotCount", slots.size());
        
        request.getRequestDispatcher("/jsp/admin/viewShowtimeSlots.jsp").forward(request, response);
    }
}

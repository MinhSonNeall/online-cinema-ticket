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
            case "get-rooms":
                getRoomsByCinema(request, response);
                break;
            default:
                listShowtimes(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
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
        }
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
            
            DaoShowtime daoShowtime = new DaoShowtime();
            int maxId = daoShowtime.getMaxShowtimeId();
            String newShowtimeId = String.valueOf(maxId + 1);
            Timestamp startTime = Timestamp.valueOf(startTimeStr + " 00:00:00");
            Timestamp endTime = Timestamp.valueOf(endTimeStr + " 00:00:00");
            
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
        String showtimeId = request.getParameter("showtimeId");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        DaoShowtime daoShowtime = new DaoShowtime();
        Showtimes showtime = daoShowtime.getShowtimeById(showtimeId);
        showtime.setStart_time(Timestamp.valueOf(startTimeStr + " 00:00:00"));
        showtime.setEnd_time(Timestamp.valueOf(endTimeStr + " 00:00:00"));
        daoShowtime.updateShowtime(showtime);
        response.sendRedirect(request.getContextPath() + "/ManageShowtime");
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
            System.out.println("Room ID:"+showtime.getRoom_id());

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
}

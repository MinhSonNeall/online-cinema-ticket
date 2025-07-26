/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Entity.Users;
import Model.DaoSeat;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Random;
import org.json.JSONObject;
import org.json.JSONArray;

/**
 *
 * @author Cuong
 */
@WebServlet(name = "InformationTicketController", urlPatterns = {"/InformationTicketController"})
public class InformationTicketController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InformationTicketController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InformationTicketController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String BANK_SHORT_NAME = "mbbank";  // Lowercase
    private static final String ACCOUNT_NO = "0393438114";  // Số TK
    private static final String ACCOUNT_NAME = "NGUYEN CANH CUONG";  // Tên TK
    private static final String TEMPLATE = "compact2";

    // API constants
    private static final String API_KEY = "AK_CS.ebf5bbe0621911f0b2ed09df87a53c97.Yjqk0TBQIcxfl4dFU7tDEONrlqXEcewx2NLPeo7KWLgdWiLwCTWMTFLFizUzzmflaCkGrdgG";  // Thay bằng API key thật
    private static final String API_GET_PAID = "https://oauth.casso.vn/v2/transactions?fromDate=%s&toDate=%s&page=1&pageSize=100&sort=DESC";

    // Mail constants
    private static final String MAIL_FROM = "cuongnche163892@fpt.edu.vn";
    private static final String MAIL_PASSWORD = "vidt nksg uggt vszk";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users user = (session != null) ? (Users) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginController");
        } else {
            // Optional: Nếu cần handle GET, nhưng recommend use POST from booking
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Use POST");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users user = (session != null) ? (Users) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginController");
            return;
        }

        String confirm = request.getParameter("confirm");
            // Generate QR phase (from booking form)
            String movieId = request.getParameter("movieId");
            String movieTitle = request.getParameter("movieTitle");
            String cinemaName = request.getParameter("cinemaName");
            String showtime = request.getParameter("showtime");
            String showtimeid = request.getParameter("showtimeid");
            String selectedSeats = request.getParameter("selectedSeats");
            String selectedDate = request.getParameter("selectedDate");
            String roomId = request.getParameter("room_id");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
            Random random = new Random();
            int randomCode = 100000 + random.nextInt(900000);

            String normalizedSeats = selectedSeats.replace(",", " ");

            String addInfo = " " + normalizedSeats + " code " + randomCode;
            String qrUrl = "https://img.vietqr.io/image/" + BANK_SHORT_NAME.toLowerCase() + "-" + ACCOUNT_NO + "-" + TEMPLATE + ".png"
                    + "?amount=" + (int) totalPrice
                    + "&addInfo=" + addInfo
                    + "&accountName=" + URLEncoder.encode(ACCOUNT_NAME, "UTF-8");

            DaoSeat daoseat= new DaoSeat();
            String seat_number=daoseat.getSeatNumberbySeatId(selectedSeats);
            // Set attributes
            request.setAttribute("movieTitle", movieTitle);
            request.setAttribute("cinemaName", cinemaName);
            request.setAttribute("showtime", showtime);
            request.setAttribute("showtimeid", showtimeid);
            request.setAttribute("selectedSeats", selectedSeats);
            request.setAttribute("selectedDate", selectedDate);
            request.setAttribute("roomId", roomId);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("qrUrl", qrUrl);
            request.setAttribute("seat_number", seat_number);
            request.setAttribute("addInfo", addInfo);  // For display and hidden

            // TODO: Insert pending ticket to DB here, get ticketId from DAO
            // int ticketId = yourTicketDAO.insertPendingTicket(...);
            // request.setAttribute("ticketId", ticketId);
            request.getRequestDispatcher("/jsp/Movie/infomationticket.jsp").forward(request, response);
    }

    public static boolean checkPayment(String description, int amount) {
        // Get dates: from yesterday to today, format YYYY-MM-DD
        LocalDate today = LocalDate.now();
        String fromDate = today.minusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String toDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        String apiUrl = String.format(API_GET_PAID, fromDate, toDate);

        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest req = HttpRequest.newBuilder()
                    .uri(java.net.URI.create(apiUrl))
                    .header("Authorization", "Apikey " + API_KEY)
                    .header("Accept", "application/json")
                    .GET()
                    .build();

            HttpResponse<String> res = client.send(req, HttpResponse.BodyHandlers.ofString());

            if (res.statusCode() != 200) {
                System.out.println("HTTP error: " + res.statusCode());
                return false;
            }

            JSONObject json = new JSONObject(res.body());
            if (json.getInt("error") != 0) {
                System.out.println("API error: " + json.getString("message"));
                return false;
            }

            JSONArray records = json.getJSONObject("data").getJSONArray("records");

            for (int i = 0; i < records.length(); i++) {
                JSONObject record = records.getJSONObject(i);
                String recordDesc = record.getString("description").trim().toLowerCase();
                int recordAmount = record.getInt("amount");
                String recordWhen = record.getString("when");  // Lưu nếu cần
                System.out.println("chi tiết : " + recordDesc);
                System.out.println("chi tiết : " + recordAmount);

                if (recordDesc.contains(description.trim().toLowerCase()) && recordAmount == amount) {
                    System.out.println("Thanh toán thành công!");
                    // Có thể lưu recordWhen vào session hoặc attribute nếu cần
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void sendMail(String toEmail, String body, String subject) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MAIL_FROM, MAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(MAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("Mail sent successfully");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Entity.Users;
import Model.DaoUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.concurrent.TimeUnit; // Import TimeUnit for cooldown calculation

/**
 *
 * @author HP
 */
@WebServlet(name="VerifyEmailController", urlPatterns={"/verifyEmailOTP", "/resendOtp"})
public class VerifyEmailOTPController extends HttpServlet {
   
    private static final long OTP_COOLDOWN_MINUTES = 5; // 5 minutes cooldown

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet VerifyEmailController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyEmailController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        DaoUser daoUser = new DaoUser(); // Instantiate DaoUser

        if ("/resendOtp".equals(path)) {
            String email = (String) session.getAttribute("email");
            if (email == null) {
                // Email not in session, redirect to registration or login
                response.sendRedirect(request.getContextPath() + "/RegisterController"); // Or registerCustomer.jsp
                return;
            }

            Long resendCooldown = (Long) session.getAttribute("resendCooldown");
            long currentTime = System.currentTimeMillis();

            if (resendCooldown != null && currentTime < resendCooldown) {
                long remainingTime = TimeUnit.MILLISECONDS.toSeconds(resendCooldown - currentTime);
                request.setAttribute("er", "Vui lòng chờ " + (remainingTime / 60) + " phút " + (remainingTime % 60) + " giây trước khi gửi lại OTP.");
            } else {
                // Generate new OTP using DaoUser
                String newOtp = daoUser.generateOTP();
                session.setAttribute("otp", newOtp);
                
                // Set new cooldown
                long newCooldownEndTime = currentTime + TimeUnit.MINUTES.toMillis(OTP_COOLDOWN_MINUTES);
                session.setAttribute("resendCooldown", newCooldownEndTime);

                // Send email using DaoUser
                daoUser.sendVerificationEmail(email, newOtp); 
                
                request.setAttribute("message", "Mã OTP mới đã được gửi đến email của bạn.");
            }
            request.getRequestDispatcher("/jsp/verifyRegisOTP.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/jsp/verifyRegisOTP.jsp").forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        DaoUser daoUser = new DaoUser();

        String userOtp = request.getParameter("otp");
        String storedOtp = (String) session.getAttribute("otp");
        
        // Retrieve user data from session
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        String fullName = (String) session.getAttribute("fullName");
        String phoneNumber = (String) session.getAttribute("phoneNumber");
        String roleStr = (String) session.getAttribute("role"); // Assuming role is stored as String
        
        // Retrieve created_at and updated_at as String and parse them
        String createdAtStr = (String) session.getAttribute("createdAt");
        String updatedAtStr = (String) session.getAttribute("updatedAt");

        if (userOtp != null && storedOtp != null && userOtp.equals(storedOtp)) {
            // OTP matches, create user account
            try {
                Users.Roles role = Users.Roles.valueOf(roleStr.toUpperCase());
                
                // Parse Timestamp strings
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSSSSSS"); // Reverted to SSSSSSS for nanoseconds
                Timestamp createdAt = null;
                Timestamp updatedAt = null;
                
                if (createdAtStr != null) {
                    LocalDateTime localDateTime = LocalDateTime.parse(createdAtStr, formatter);
                    createdAt = Timestamp.valueOf(localDateTime);
                }
                if (updatedAtStr != null) {
                    LocalDateTime localDateTime = LocalDateTime.parse(updatedAtStr, formatter);
                    updatedAt = Timestamp.valueOf(localDateTime);
                }
                
                Users newUser = new Users(email, password, fullName, phoneNumber, role, createdAt, updatedAt);
                
                if (daoUser.createUser(newUser)) {
                    // User created successfully, clear session attributes and redirect to login
                    session.removeAttribute("otp");
                    session.removeAttribute("email");
                    session.removeAttribute("password");
                    session.removeAttribute("fullName");
                    session.removeAttribute("phoneNumber");
                    session.removeAttribute("role");
                    session.removeAttribute("createdAt");
                    session.removeAttribute("updatedAt");
                    session.removeAttribute("resendCooldown"); // Clear cooldown on successful registration
                    
                    session.setAttribute("success", "Account created successfully! Please login."); // Use session attribute
                    response.sendRedirect(request.getContextPath() + "/loginController"); // Redirect to loginController
                } else {
                    // Failed to create user (e.g., database error)
                    request.setAttribute("er", "Failed to create account. Please try again.");
                    request.getRequestDispatcher("jsp/verifyRegisOTP.jsp").forward(request, response);
                }
            } catch (IllegalArgumentException e) {
                Logger.getLogger(VerifyEmailOTPController.class.getName()).log(Level.SEVERE, "Invalid role or timestamp format in session", e);
                request.setAttribute("er", "An internal error occurred. Please try again.");
                request.getRequestDispatcher("jsp/verifyRegisOTP.jsp").forward(request, response);
            }
        } else {
            // OTP does not match
            request.setAttribute("er", "Wrong OTP. Please try again.");
            request.getRequestDispatcher("jsp/verifyRegisOTP.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

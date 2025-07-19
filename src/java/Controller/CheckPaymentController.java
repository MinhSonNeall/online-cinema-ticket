/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import static Controller.InformationTicketController.checkPayment;
import static Controller.InformationTicketController.sendMail;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author Cuong
 */
@WebServlet(name = "CheckPaymentController", urlPatterns = {"/CheckPaymentController"})
public class CheckPaymentController extends HttpServlet {

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
            out.println("<title>Servlet CheckPaymentController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckPaymentController at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        
            String addInfo = request.getParameter("addInfo");  // From hidden
            double amount = Double.parseDouble(request.getParameter("totalPrice"));  // From hidden
            String email = user.getEmail();  // From form input
            String userId = user.getUser_id();  // Giả định Users có method getId()
            String codePayment = "CP" + System.currentTimeMillis();  // Gen code
            System.out.println("email: " + email);
            // int ticketId = Integer.parseInt(request.getParameter("ticketId"));  // From hidden, set khi insert pending

            // Call API to check
            boolean paid = checkPayment(addInfo, (int) amount);
            String paymentTime = null;  // To store 'when' if paid

            if (paid) {
                synchronized (session) {
                    if (session.getAttribute("payment_confirmed") != null) {
                        System.out.println("Email đã gửi, bỏ qua gửi lại.");
                        response.sendRedirect(request.getContextPath() + "/ListMovieController");
                        return;
                    }

                    session.setAttribute("payment_confirmed", true);
                }

                try {
                    sendMail(email, "Thanh toán thành công!!", "Bạn đã đặt vé thành công");
                    session.removeAttribute("payment_confirmed");  // Clear flag sau khi gửi xong
                    
                    
                    response.sendRedirect(request.getContextPath() + "/ListMovieController");
                    return;
                } catch (Exception ex) {
                    ex.printStackTrace();
                    session.removeAttribute("payment_confirmed");
                    request.setAttribute("error", "Thanh toán thành công, nhưng gửi mail thất bại.");
                    request.getRequestDispatcher("/jsp/Movie/infomationticket.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("error", "Chưa tìm thấy giao dịch khớp. Vui lòng thử lại sau vài phút.");
                request.getRequestDispatcher("/jsp/Movie/infomationticket.jsp").forward(request, response);
                return;

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

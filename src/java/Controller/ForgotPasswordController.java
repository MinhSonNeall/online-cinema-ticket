package Controller;

import Entity.Users;
import Model.DaoUser;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;
import java.util.regex.Pattern;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gmail = request.getParameter("email");

        if (gmail == null || gmail.isEmpty()) {
            request.setAttribute("errorform", "Vui lòng nhập địa chỉ email!");
            request.getRequestDispatcher("/jsp/forgotPassword.jsp").forward(request, response);
            return;
        }

        // Validate email format
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pat = Pattern.compile(emailRegex);
        if (!pat.matcher(gmail).matches()) {
            request.setAttribute("errorform", "Định dạng email không hợp lệ!");
            request.getRequestDispatcher("/jsp/forgotPassword.jsp").forward(request, response);
            return;
        }

        DaoUser daoUser = new DaoUser();
        Vector<Users> list = daoUser.listAllUser();
        boolean emailExists = false;
        Users user = null;

        for (Users u : list) {
            if (u.getEmail().equals(gmail)) {
                emailExists = true;
                user = u;
                break;
            }
        }

        if (!emailExists) {
            request.setAttribute("errorform", "Email này chưa được đăng ký!");
            request.getRequestDispatcher("/jsp/forgotPassword.jsp").forward(request, response);
            return;
        }

        // Email exists, proceed to send OTP
        String otp = daoUser.generateOTP();
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("forgotPasswordEmail", gmail); // Store email for OTP verification

        daoUser.sendVerificationEmail(gmail, otp); // Reuse existing email sending method

        response.sendRedirect("forgotPasswordOTPVerify"); // Redirect to OTP verification page
    }

    @Override
    public String getServletInfo() {
        return "Xử lý yêu cầu quên mật khẩu";
    }
}

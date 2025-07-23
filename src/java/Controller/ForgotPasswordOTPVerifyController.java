package Controller;

import Model.DaoUser;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ForgotPasswordOTPVerifyController", urlPatterns = {"/forgotPasswordOTPVerify"})
public class ForgotPasswordOTPVerifyController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/forgotPasswordOTPVerify.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String check = (String) session.getAttribute("email");
            if (check == null) {
                // Email not in session, redirect to registration or login
                response.sendRedirect(request.getContextPath() + "/RegisterController"); // Or registerCustomer.jsp
                return;
            }

        String enteredOtp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        
        String storedOtp = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("forgotPasswordEmail");

        if (enteredOtp == null || enteredOtp.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mã OTP!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }

        if (!enteredOtp.equals(storedOtp)) {
            request.setAttribute("error", "Mã OTP không đúng!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }

        // OTP is correct, now validate and update password
        if (newPassword == null || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu mới và xác nhận!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.contains(" ")) {
            request.setAttribute("error", "Mật khẩu không được có khoảng trắng!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.length() < 12) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 12 ký tự!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }

        DaoUser daoUser = new DaoUser();
        String oldPassword = daoUser.getPasswordByEmail(email);

        if (oldPassword != null && newPassword.equals(oldPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
            return;
        }

        boolean updated = daoUser.updatePassword(email, newPassword);

        if (updated) {
            session.removeAttribute("otp"); // Clear OTP from session
            session.removeAttribute("forgotPasswordEmail"); // Clear email from session
            request.setAttribute("success", "Mật khẩu của bạn đã được đặt lại thành công. Vui lòng đăng nhập.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi đặt lại mật khẩu. Vui lòng thử lại.");
            request.getRequestDispatcher("/jsp/verifyForgotPasswordOTP.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Xử lý xác minh OTP quên mật khẩu và đặt lại mật khẩu";
    }
}
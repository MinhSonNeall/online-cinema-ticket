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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Vector;
import java.util.regex.Pattern;

@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang đăng ký
        request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số từ biểu mẫu
        String gmail = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");
        String full_name = request.getParameter("full_name");
        String phone_number = request.getParameter("phone_number");

        // Kiểm tra null và rỗng
//        if (gmail == null || gmail.isEmpty() || password == null || password.isBlank() ||
//            re_password == null || re_password.isEmpty() || full_name == null || full_name.isEmpty() ||
//            phone_number == null || phone_number.isEmpty()) {
//            request.setAttribute("errorform", "Vui lòng điền đầy đủ thông tin!");
//            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
//            return;
//        }

        // Xác thực mật khẩu
        if (password.contains(" ")) {
            request.setAttribute("errorform", "Mật khẩu không được có khoảng trắng!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }
        if (!password.equals(re_password)) {
            request.setAttribute("errorform", "Mật khẩu nhập lại không đúng!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }
        if (password.length() < 12) {
            request.setAttribute("errorform", "Mật khẩu phải có ít nhất 12 ký tự!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }

        // Validate full_name: not contain special characters
        String nameRegex = "^[a-zA-Z\\s]+$";
        if (!Pattern.matches(nameRegex, full_name.trim())) {
            request.setAttribute("errorform", "Tên phải có ký tự từ bảng chữ cái!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }

        // Validate phone_number: must be at least 10 digits
        String phoneRegex = "^\\d{10,}$";
        if (!Pattern.matches(phoneRegex, phone_number)) {
            request.setAttribute("errorform", "Số điện thoại phải có ít nhất 10 chữ số!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }

        // Xác thực định dạng email
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pat = Pattern.compile(emailRegex);
        if (!pat.matcher(gmail).matches()) {
            request.setAttribute("errorform", "Định dạng email không hợp lệ!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại
        DaoUser daoUser = new DaoUser();
        Vector<Users> list = daoUser.listAllUser();
        boolean emailExists = false;

        for (Users c : list) {
            if (c.getEmail().equals(gmail)) {
                emailExists = true;
                break;
            }
        }
        if (emailExists) {
            request.setAttribute("errorform", "Email đã tồn tại!");
            request.getRequestDispatcher("/jsp/registerCustomer.jsp").forward(request, response);
            return;
        }

        // Sau khi xác thực thành công
        String otp = daoUser.generateOTP();
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        
        // Store individual user details in session
        session.setAttribute("email", gmail);
        session.setAttribute("password", password);
        session.setAttribute("fullName", full_name);
        session.setAttribute("phoneNumber", phone_number);
        session.setAttribute("role", Users.Roles.CUSTOMER.name()); // Default role for new registrations
        
        // Set current timestamps
        Timestamp now = Timestamp.valueOf(LocalDateTime.now());
        session.setAttribute("createdAt", now.toString());
        session.setAttribute("updatedAt", now.toString());

        // Gửi OTP qua email
        daoUser.sendVerificationEmail(gmail, otp);
        // Chuyển hướng đến trang xác minh OTP
        response.sendRedirect("verifyEmailOTP");
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng ký người dùng";
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import Entity.Users;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/*","/adminController"})
public class AdminFilter implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    
    public AdminFilter() {
    }    
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AdminFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }    
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AdminFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        if (debug) {
            log("AdminFilter:doFilter()");
        }
        
        doBeforeProcessing(request, response);
        // Ép kiểu đối tượng request và response sang HttpServletRequest/Response để truy cập các phương thức HTTP
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Lấy đường dẫn URI đầy đủ của yêu cầu (ví dụ: /OnlineCinemaTicket/ManageSeat)
        String requestURI = httpRequest.getRequestURI();
        // Lấy Context Path của ứng dụng (ví dụ: /OnlineCinemaTicket)
        String contextPath = httpRequest.getContextPath();
        // Lấy đường dẫn tương đối trong ứng dụng (ví dụ: /ManageSeat)
        String relativeURI = requestURI.substring(contextPath.length());

        System.out.println("AuthenticationFilter: Đang kiểm tra yêu cầu cho URI: " + relativeURI);

        // Kiểm tra xem yêu cầu hiện tại có nằm trong các URL mà Filter này bảo vệ không.
        // Điều kiện này khớp với urlPatterns đã khai báo trong @WebFilter.
        if (relativeURI.contains("Manage") || relativeURI.equals("/adminController")) {
            // Lấy HttpSession hiện tại. "false" nghĩa là không tạo session mới nếu chưa có.
            HttpSession session = httpRequest.getSession(false);

            // Cố gắng lấy đối tượng người dùng từ session với tên thuộc tính là "user".
            // Nếu session là null hoặc thuộc tính "user" không tồn tại, userObject sẽ là null.
            Object userObject = (session != null) ? session.getAttribute("user") : null;

            // BƯỚC 1: Kiểm tra xem người dùng đã đăng nhập chưa (bằng cách kiểm tra userObject có null không)
            if (userObject == null) {
                System.out.println("AuthenticationFilter: Truy cập trái phép. Người dùng chưa đăng nhập. Chuyển hướng tới trang đăng nhập.");
                // Chuyển hướng trình duyệt đến trang đăng nhập của bạn
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/ListMovieController");
                return; // Dừng xử lý Filter, không cho yêu cầu tiếp tục đến tài nguyên đích
            }

            // BƯỚC 2: Nếu đã đăng nhập, kiểm tra xem đối tượng có phải là kiểu Users hợp lệ và vai trò của họ
            if (userObject instanceof Users) { // Kiểm tra kiểu của đối tượng để tránh ClassCastException
                Users user = (Users) userObject; // Ép kiểu đối tượng về lớp Users của bạn
                Users.Roles userRole = user.getRole(); // Lấy vai trò của người dùng từ đối tượng Users

                // BƯỚC 3: Kiểm tra vai trò của người dùng. Nếu vai trò KHÔNG PHẢI là ADMIN
                if (userRole != Users.Roles.ADMIN) {
                    System.out.println("AuthenticationFilter: Từ chối truy cập. Người dùng " + user.getEmail() +
                                       " có vai trò " + userRole + ". Chuyển hướng tới trang từ chối truy cập.");
                    // Chuyển hướng đến trang thông báo lỗi "truy cập bị từ chối"
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/jsp/authenticationFailed.jsp");
                    return; // Dừng xử lý Filter
                }
                // Nếu người dùng là ADMIN, thì Filter sẽ cho phép yêu cầu đi tiếp
                System.out.println("AuthenticationFilter: Người dùng " + user.getEmail() + " (ADMIN) được phép truy cập " + relativeURI + ".");

            } else {
                // Trường hợp có thuộc tính "user" trong session nhưng nó không phải là đối tượng Users
                System.out.println("AuthenticationFilter: Đối tượng 'user' trong session không hợp lệ (không phải kiểu Users). Hủy session và chuyển hướng tới trang đăng nhập.");
                if (session != null) {
                    session.invalidate(); // Hủy session để buộc người dùng đăng nhập lại
                }
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/ListMovieController");
                return; // Dừng xử lý Filter
            }
        }

        // Nếu yêu cầu không thuộc các URL được bảo vệ (không bắt đầu bằng "/Manage" và không phải "/adminController"),
        // HOẶC nếu người dùng đã được xác thực và có vai trò ADMIN,
        // thì cho phép yêu cầu tiếp tục đi qua chuỗi Filter và đến tài nguyên đích (Servlet/JSP/resource)
        chain.doFilter(request, response);
        
        Throwable problem = null;
        try {
            chain.doFilter(request, response);
        } catch (Throwable t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
            t.printStackTrace();
        }
        
        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {                
                log("AdminFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AdminFilter()");
        }
        StringBuffer sb = new StringBuffer("AdminFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);        
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);                
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");                
                pw.print(stackTrace);                
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
    
    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);        
    }
    
}

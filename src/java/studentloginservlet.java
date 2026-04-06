/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Harshal
 */
@WebServlet(urlPatterns = {"/studentloginservlet"})
public class studentloginservlet extends HttpServlet {


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet studentloginservlet</title>");
            out.println("</head>");
            out.println("<body>");
            
            String email = request.getParameter("email").trim();
    String password = request.getParameter("password").trim();

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

                try (Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hostelmanagement_db",
"root",
""
)) {
String sql = "SELECT * FROM student WHERE email=? AND password=?";
PreparedStatement ps = con.prepareStatement(sql);

ps.setString(1, email);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if (rs.next()) {

HttpSession session = request.getSession();
session.setAttribute("student_id", rs.getInt("id"));
session.setAttribute("student_name", rs.getString("name"));


response.sendRedirect("studentdashboard.jsp");

} else {

response.setContentType("text/html");
out.println("<script>");
out.println("alert('Invalid Email or Password');");
out.println("location='studentlogin.jsp';");
out.println("</script>");
}       }

    } catch (Exception e) {
        e.printStackTrace();
    }

            out.println("</body>");
            out.println("</html>");
        }
    
    
    }}

    
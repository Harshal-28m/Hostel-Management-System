/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Harshal
 */
@WebServlet(urlPatterns = {"/adminloginservlet"})
public class adminloginservlet extends HttpServlet {


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
     response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminloginservlet</title>");
            out.println("</head>");
            out.println("<body>");
           
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

                try (Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hostelmanagement_db",
"root",
""
)) {
String sql = "SELECT * FROM admin WHERE username=? AND password=?";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
stmt.setString(1, username);
stmt.setString(2, password);

ResultSet rs = stmt.executeQuery();

if (rs.next()) {

HttpSession session = request.getSession();
session.setAttribute("username", username);

response.sendRedirect("admindashboard.jsp");

} else {

request.setAttribute("errorMessage", "Invalid Username or Password");
RequestDispatcher rd = request.getRequestDispatcher("adminlogin.jsp");
rd.forward(request, response);
}

rs.close();     }
                }

        } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
        }
    }


            out.println("</body>");
            out.println("</html>");
        }
    }

        
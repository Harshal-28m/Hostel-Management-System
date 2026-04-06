/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.sql.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Harshal
 */
@WebServlet(urlPatterns = {"/viewstudentservlet"})
public class viewstudentservlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet viewstudentservlet</title>");
            out.println("</head>");
            out.println("<body>");
            
           try {

            int id = Integer.parseInt(request.getParameter("id"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hostelmanagement_db","root","");

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM student WHERE id=?");

            ps.setInt(1, id);

            int result = ps.executeUpdate();

            System.out.println("Deleted rows: " + result);

            ps.close();
            con.close();

            response.sendRedirect("viewstudent.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println(e);
        }
    

            out.println("</body>");
            out.println("</html>");
        }
    }
}

        
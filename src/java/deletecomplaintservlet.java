import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deletecomplaintservlet")
public class deletecomplaintservlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;

        try {

        
            int id = Integer.parseInt(request.getParameter("id"));

            System.out.println("Deleting Complaint ID: " + id);

          
            Class.forName("com.mysql.cj.jdbc.Driver");

           
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hostelmanagement_db",
                    "root",
                    ""
            );

         
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM complaint WHERE id=?"
            );

            ps.setInt(1, id);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            System.out.println("Complaint Deleted. Rows affected: " + result);

            
            response.sendRedirect("viewcomplaints.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
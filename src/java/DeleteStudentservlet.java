import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteStudentservlet")
public class DeleteStudentservlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            System.out.println("Deleting Student ID: " + id);

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hostelmanagement_db",
                    "root",
                    ""
            );
            con.setAutoCommit(false);

            PreparedStatement ps1 = con.prepareStatement(
                    "DELETE FROM complaint WHERE student_id=?"
            );
            ps1.setInt(1, id);
            ps1.executeUpdate();
            ps1.close();

            PreparedStatement ps2 = con.prepareStatement(
                    "DELETE FROM student WHERE id=?"
            );
            ps2.setInt(1, id);

            int result = ps2.executeUpdate();
            ps2.close();

            con.commit();

            System.out.println("Student Deleted Successfully. Rows affected: " + result);

            response.sendRedirect("viewstudent.jsp");

        } catch (Exception e) {

            try {
                if (con != null) {
                    con.rollback();   
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());

        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
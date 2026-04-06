package com.model;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/payfeeservlet")
public class payfeeservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            HttpSession session = request.getSession();
            Integer studentId = (Integer) session.getAttribute("student_id");

            if (studentId == null) {
                response.sendRedirect("studentlogin.jsp");
                return;
            }

            double amount = Double.parseDouble(request.getParameter("amount"));

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hostelmanagement_db",
                    "root",
                    ""
            );

            String sql = "UPDATE student SET paid_fee = paid_fee + ?, pending_fee = pending_fee - ? WHERE id=?";

            ps = con.prepareStatement(sql);
            ps.setDouble(1, amount);
            ps.setDouble(2, amount);
            ps.setInt(3, studentId);

            int i = ps.executeUpdate();

            if (i > 0) {
                response.sendRedirect("fees.jsp?msg=paid");
            } else {
                response.sendRedirect("fees.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("fees.jsp?msg=error");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
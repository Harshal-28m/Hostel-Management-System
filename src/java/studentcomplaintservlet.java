package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/studentcomplaintservlet")
public class studentcomplaintservlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int studentId = Integer.parseInt(request.getParameter("student_id"));
            String studentName = request.getParameter("student_name");
            String roomNo = request.getParameter("room_no");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hostelmanagement_db",
                    "root",
                    ""
            );

            String sql = "INSERT INTO complaint(student_id, student_name, room_no, subject, message) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setString(2, studentName);
            ps.setString(3, roomNo);
            ps.setString(4, subject);
            ps.setString(5, message);

            int i = ps.executeUpdate();

            if(i > 0){
                request.setAttribute("msg", "Complaint Submitted Successfully!");
            } else {
                request.setAttribute("msg", "Complaint Not Submitted!");
            }

            ps.close();
            con.close();

            request.getRequestDispatcher("studentcomplaint.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
response.getWriter().println(e);
        }
    }
}
package com.model;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/studentregisterservlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class studentregisterservlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;

        try {
            request.setCharacterEncoding("UTF-8");

            // ================= FILE UPLOAD =================
            Part photoPart = request.getPart("photo");

            String photoName = "";
            if (photoPart != null && photoPart.getSize() > 0) {

                photoName = System.currentTimeMillis() + "_" +
                        photoPart.getSubmittedFileName();

                String uploadPath = request.getServletContext().getRealPath("/") + "uploads";

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                photoPart.write(uploadPath + File.separator + photoName);
            }

            // ================= FORM DATA =================
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String prn = request.getParameter("prn");
            String room_no = request.getParameter("room_no");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String course = request.getParameter("course");
            String year = request.getParameter("year");
            String academicyear = request.getParameter("academicyear");
            String parents_no = request.getParameter("parents_no");
            String dob = request.getParameter("dob");

            int roomNoVal = parseIntSafe(room_no);
            long prnVal = parseLongSafe(prn);
            int durationVal = parseIntSafe(request.getParameter("duration"));
            int feeVal = parseIntSafe(request.getParameter("fee"));
            int paidVal = parseIntSafe(request.getParameter("paid_fee"));

            int pendingVal = feeVal - paidVal;
            if (pendingVal < 0) pendingVal = 0;

            // ================= DB =================
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hostelmanagement_db",
                    "root",
                    ""
            );

            conn.setAutoCommit(false);

            // ✅ FIXED QUERY (18 placeholders)
            String sql = "INSERT INTO student "
                    + "(name,email,password,phone,room_no,address,city,course,parents_no,dob,"
                    + "duration,fee,paid_fee,pending_fee,academicyear,prn,year,photo) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, room_no);
            ps.setString(6, address);
            ps.setString(7, city);
            ps.setString(8, course);
            ps.setString(9, parents_no);
            ps.setString(10, dob);
            ps.setInt(11, durationVal);
            ps.setInt(12, feeVal);
            ps.setInt(13, paidVal);
            ps.setInt(14, pendingVal);
            ps.setString(15, academicyear);
            ps.setLong(16, prnVal);
            ps.setString(17, year);

            if (photoName == null || photoName.equals("")) {
                photoName = "default.png";
            }
            ps.setString(18, photoName);

            int result = ps.executeUpdate();

            // ================= UPDATE ROOM =================
            if (result > 0) {

                String updateRoom = "UPDATE room SET Available='Occupied' WHERE room_no=?";
                ps2 = conn.prepareStatement(updateRoom);
                ps2.setInt(1, roomNoVal);
                ps2.executeUpdate();

                conn.commit();
                response.sendRedirect("studentregister.jsp?msg=success");

            } else {
                conn.rollback();
                response.sendRedirect("studentregister.jsp?msg=error");
            }

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (Exception ignored) {}

            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red'>ERROR:</h3>");
            response.getWriter().println(e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (ps2 != null) ps2.close();
                if (conn != null) conn.close();
            } catch (Exception ignored) {}
        }
    }

    private int parseIntSafe(String value) {
        try {
            return (value == null || value.isEmpty()) ? 0 : Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
        }
    }

    private long parseLongSafe(String value) {
        try {
            return (value == null || value.isEmpty()) ? 0 : Long.parseLong(value);
        } catch (Exception e) {
            return 0;
        }
    }
}
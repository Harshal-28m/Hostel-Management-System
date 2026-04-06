<%-- 
    Document   : fees
    Created on : Mar 23, 2026, 8:29:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page isErrorPage="true" %>

<%
    Integer studentId = (Integer) session.getAttribute("student_id");

    if (studentId == null) {
        response.sendRedirect("studentlogin.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hostelmanagement_db", "root", "");

        ps = con.prepareStatement("SELECT * FROM student WHERE id=?");
        ps.setInt(1, studentId);

        rs = ps.executeQuery();
%>
<%
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
    <% if("paid".equals(msg)){ %>
<meta http-equiv="refresh" content="3;URL=fees.jsp">
<% } %>
<head>
<title>Fee Details</title>
<meta charset="UTF-8">

<style>
body {
    font-family: Arial;
    background: #f4f6f9;
}

.container {
    width: 75%;
    margin: auto;
    margin-top: 40px;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th {
    background: #007bff;
    color: white;
}

th, td {
    padding: 10px;
    text-align: center;
}

.download-btn {
    margin-top: 20px;
    display: inline-block;
    padding: 12px 20px;
    background: green;
    color: white;
    text-decoration: none;
    border-radius: 6px;
}
</style>

</head>
<body>

<div class="container">

<h2>My Fee Details</h2>
<% if("paid".equals(msg)){ %>
    <p style="color:green; text-align:center; font-weight:bold;">
        ✅ Payment Successful! You can now download receipt.
    </p>
<% } %>
<%
    if (rs.next()) {

        double fee = rs.getDouble("fee");
        double paid = rs.getDouble("paid_fee");
        double pending = fee - paid;
%>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>PRN</th>
        <th>Course</th>
        <th>Room No</th>
        <th>Duration</th>
        <th>Total Fee</th>
        <th>Paid</th>
        <th>Pending</th>
        <th>Academic Year</th>
    </tr>

    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getLong("prn") %></td>
        <td><%= rs.getString("course") %></td>
        <td><%= rs.getString("room_no") %></td>
        <td><%= rs.getString("duration") %></td>
        <td><%= fee %></td>
        <td><%= paid %></td>
        <td><%= pending %></td>
        <td><%= rs.getString("academicyear") %></td>
    </tr>
</table>

<br>

<center>

<%
if(pending > 0){
%>

<a href="payfee.jsp" class="download-btn">
    Pay Pending Fee
</a>

<%
}else{
%>

<a href="receipt.jsp" class="download-btn">
    Download Receipt
</a>

<%
}
%>

</center>
<%
    } else {
%>
    <p style="text-align:center; color:red;">No data found!</p>
<%
    }

} catch (Exception e) {
    out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    e.printStackTrace(new java.io.PrintWriter(out));
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (ps != null) ps.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
%>

</div>

</body>
</html>
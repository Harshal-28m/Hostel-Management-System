<%-- 
    Document   : viewComplaints
    Created on : Feb 19, 2026, 9:51:01 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>

<%
    if(session.getAttribute("username") == null){
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin | View Complaints</title>
<meta charset="UTF-8">

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background: linear-gradient(135deg, #eef2f3, #dfe9f3);
}

.header {
    background: #2c3e50;
    color: white;
    padding: 18px 40px;
    font-size: 22px;
    font-weight: bold;
    letter-spacing: 1px;
}

.container {
    padding: 30px;
}

.card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

h2 {
    margin-bottom: 20px;
    color: #333;
}

table {
    width: 100%;
    border-collapse: collapse;
    overflow: hidden;
    border-radius: 10px;
}

th {
    background: #3498db;
    color: white;
    padding: 12px;
    text-align: center;
}

td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #eee;
}
tr:nth-child(even) {
    background: #f9f9f9;
}

tr:hover {
    background: #f1f7ff;
    transition: 0.3s;
}

.btn {
    padding: 8px 14px;
    border-radius: 6px;
    text-decoration: none;
    color: white;
    font-size: 14px;
    transition: 0.3s;
}

.delete {
    background: #e74c3c;
}

.delete:hover {
    background: #c0392b;
}

.back {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    background: #2c3e50;
    color: white;
    padding: 10px 18px;
    border-radius: 6px;
    transition: 0.3s;
}

.back:hover {
    background: #1a252f;
}

@media (max-width: 768px) {
    table, thead, tbody, th, td, tr {
        display: block;
    }

    th {
        display: none;
    }

    td {
        padding: 10px;
        text-align: right;
        position: relative;
    }

    td::before {
        content: attr(data-label);
        position: absolute;
        left: 10px;
        font-weight: bold;
        text-align: left;
    }
}
</style>

</head>

<body>


<div class="container">
<div class="card">

<h2>📋 Student Complaints</h2>

<table>
<tr>
    <th>ID</th>
    <th>Student ID</th>
    <th>Name</th>
    <th>Room</th>
    <th>Subject</th>
    <th>Message</th>
    <th>Action</th>
</tr>

<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hostelmanagement_db","root","");

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM complaint");

        while(rs.next()){
%>

<tr>
    <td data-label="ID"><%= rs.getInt("id") %></td>
    <td data-label="Student ID"><%= rs.getInt("student_id") %></td>
    <td data-label="Name"><%= rs.getString("student_name") %></td>
    <td data-label="Room"><%= rs.getString("room_no") %></td>
    <td data-label="Subject"><%= rs.getString("subject") %></td>
    <td data-label="Message"><%= rs.getString("message") %></td>

    <td data-label="Action">
        <a class="btn delete"
           href="DeleteComplaintServlet?id=<%= rs.getInt("id") %>"
           onclick="return confirm('Delete this complaint?');">
           Delete
        </a>
    </td>
</tr>

<%
        }

        con.close();
    }catch(Exception e){
%>
<tr>
    <td colspan="7" style="color:red;">
        Error: <%= e.getMessage() %>
    </td>
</tr>
<%
    }
%>

</table>

<a href="admindashboard.jsp" class="back">⬅ Back to Dashboard</a>

</div>
</div>

</body>
</html>
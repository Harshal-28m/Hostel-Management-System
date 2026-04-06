<%-- 
    Document   : viewprofile
    Created on : Feb 19, 2026, 8:07:34 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>
<%
    Integer studentId = (Integer) session.getAttribute("student_id");

    if(studentId == null){
        response.sendRedirect("studentlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
    *{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body{
    min-height:100vh;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    background: linear-gradient(135deg,#1e3c72,#2a5298);
}

h2{
    color:#fff;
    margin-bottom:25px;
    font-size:28px;
    letter-spacing:1px;
}

.card{
    width:500px;
    background:#ffffff;
    padding:35px;
    border-radius:15px;
    box-shadow:0 15px 40px rgba(0,0,0,0.3);
    transition:0.3s ease;
    position:relative;
    overflow:hidden;
}

.card:hover{
    transform:translateY(-8px);
}

.card::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:6px;
    background: linear-gradient(to right,#4e73df,#1cc88a);
}

.profile-row{
    display:flex;
    justify-content:space-between;
    padding:12px 0;
    border-bottom:1px solid #eee;
}

.profile-label{
    font-weight:600;
    color:#555;
}

.profile-value{
    color:#222;
    font-weight:500;
}

.error{
    color:red;
    text-align:center;
    font-weight:500;
}

a{
    margin-top:20px;
    padding:12px 25px;
    background:#4e73df;
    color:#fff;
    text-decoration:none;
    border-radius:8px;
    font-weight:500;
    transition:0.3s;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

a:hover{
    background:#2e59d9;
    transform:scale(1.05);
}
    </style>
</head>
<body>

<h2>My Profile</h2>

<div class="card">

<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hostelmanagement_db","root","");

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM student WHERE id=?");

        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
%>

<div class="profile-row">
    <div class="profile-label">Name</div>
    <div class="profile-value"><%= rs.getString("name") %></div>
</div>

<div class="profile-row">
    <div class="profile-label">Email</div>
    <div class="profile-value"><%= rs.getString("email") %></div>
</div>

<div class="profile-row">
    <div class="profile-label">Phone</div>
    <div class="profile-value"><%= rs.getString("phone") %></div>
</div>

<div class="profile-row">
    <div class="profile-label">PRN No</div>
    <div class="profile-value"><%= rs.getString("prn") %></div>
</div>


<div class="profile-row">
    <div class="profile-label">Room No</div>
    <div class="profile-value"><%= rs.getString("room_no") %></div>
</div>

<div class="profile-row">
    <div class="profile-label">City</div>
    <div class="profile-value"><%= rs.getString("city") %></div>
</div>

<div class="profile-row">
    <div class="profile-label">Course</div>
    <div class="profile-value"><%= rs.getString("course") %></div>
</div><%
        } else {
%>
            <p style="color:red;">No profile found!</p>
<%
        }

        con.close();
    }catch(Exception e){
        out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    }
%>

</div>

<br>
<a href="studentdashboard.jsp">⬅ Back</a>
<a href="studentcomplaint.jsp">Give Complaint</a>

</body>
</html>
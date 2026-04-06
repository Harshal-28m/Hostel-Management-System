<%-- 
    Document   : rommavailability
    Created on : 21-Feb-2026, 12:07:21 pm
    Author     : Harshal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>

<%
    if(session.getAttribute("username")==null){
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Room Availability</title>

<style>

body{
    font-family: Arial;
    background:#f4f6f9;
    padding:30px;
}

h2{
    text-align:center;
    margin-bottom:20px;
}

table{
    width:70%;
    margin:auto;
    border-collapse:collapse;
    background:white;
}

th,td{
    border:1px solid black;
    padding:10px;
    text-align:center;
}

th{
    background:#4e73df;
    color:white;
}

.available{
    color:green;
    font-weight:bold;
}

.full{
    color:red;
    font-weight:bold;
}

.back{
    display:block;
    width:150px;
    margin:20px auto;
    text-align:center;
    padding:10px;
    background:#4e73df;
    color:white;
    text-decoration:none;
    border-radius:5px;
}

</style>

</head>

<body>

<h2>Room Availability</h2>

<table>

<tr>
<th>Room No</th>
<th>Type</th>
<th>Capacity</th>
<th>Status</th>
</tr>

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hostelmanagement_db","root","");

Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM room");

while(rs.next()){

String available = rs.getString("available");

%>

<tr>

<td><%= rs.getInt("room_no") %></td>
<td><%= rs.getString("type") %></td>
<td><%= rs.getInt("capacity") %></td>

<td>

<%

if(available.equalsIgnoreCase("Available")){
%>

<span class="available">Available</span>

<%
}else{
%>

<span class="not available">Not Available</span>

<%
}

%>

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.println("Error : "+e);

}

%>

</table>

<a href="admindashboard.jsp" class="back">Back</a>

</body>
</html>
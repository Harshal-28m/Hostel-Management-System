<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>

<!DOCTYPE html>
<html>
<head>
<title>View Students</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:#eef2f7;
padding:30px;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:20px;
}

.header h2{
color:#333;
}

.back{
background:#2563eb;
color:white;
padding:8px 15px;
border-radius:6px;
text-decoration:none;
font-size:14px;
}

.back:hover{
background:#1e40af;
}

.table-container{
background:white;
border-radius:12px;
box-shadow:0 5px 20px rgba(0,0,0,0.1);
overflow:hidden;
}

table{
width:100%;
border-collapse:collapse;
}

th{
background:#1e293b;
color:white;
padding:12px;
font-size:14px;
position:sticky;
top:0;
}

td{
padding:10px;
font-size:14px;
text-align:center;
border-bottom:1px solid #eee;
}

tr:hover{
background:#f9fafb;
}

.badge{
padding:4px 8px;
border-radius:5px;
font-size:12px;
}

.course{
background:#dbeafe;
color:#1e40af;
}

.btn{
padding:6px 10px;
border-radius:5px;
text-decoration:none;
color:white;
font-size:12px;
transition:0.3s;
}

.delete{
background:#ef4444;
}

.delete:hover{
background:#dc2626;
}

.table-wrapper{
overflow-x:auto;
}

</style>
</head>
<body>
<div class="header">
<h2>Student Records</h2>
<a href="admindashboard.jsp" class="back">← Dashboard</a>
</div>

<div class="table-container">
<div class="table-wrapper">

<table>

<tr>
    <th>prn</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Room</th>
<th>City</th>
<th>Course</th>
<th>Year</th>
<th>Academic Year</th>
<th>Parents</th>
<th>DOB</th>
<th>Action</th>
</tr>

<%
try{
Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hostelmanagement_db","root","");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM student");

while(rs.next()){
%>

<tr>
    <td><%= rs.getString("prn") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("phone") %></td>
<td><%= rs.getString("room_no") %></td>
<td><%= rs.getString("city") %></td>

<td>
<span class="badge course">
<%= rs.getString("course") %>
</span>
</td>

<td><%= rs.getString("year") %></td>
<td><%= rs.getString("academicyear") %></td>

<td><%= rs.getString("parents_no") %></td>

<td>
<%= rs.getString("dob") == null ? "N/A" : rs.getString("dob") %>
</td>

<td>
<a class="btn delete"
href="Deletestudentservlet?id=<%= rs.getInt("id") %>"
onclick="return confirm('Delete this student?');">
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
<td colspan="11">Error: <%= e.getMessage() %></td>
</tr>
<%
}
%>

</table>
</div>
</div>

</body>
</html>
<%-- 
    Document   : viewstudentfees
    Created on : 17-Mar-2026, 11:14:43 am
    Author     : Harshal
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>

<title>Student Fee Details</title>

<style>

body{
    font-family:Segoe UI, Arial;
    background:#eef1f5;
    margin:0;
    padding:40px;
}

.container{
    width:95%;
    margin:auto;
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#333;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 5px 15px rgba(0,0,0,0.15);
}

th,td{
    padding:12px;
    border:1px solid #ddd;
    text-align:center;
}

th{
    background:#4e73df;
    color:white;
    font-size:15px;
}

tr:nth-child(even){
    background:#f9f9f9;
}

tr:hover{
    background:#f1f1f1;
}

.back{
    display:block;
    width:140px;
    margin:25px auto;
    text-align:center;
    padding:10px;
    background:#4e73df;
    color:white;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

.back:hover{
    background:#2e59d9;
}

</style>

</head>

<body>

<div class="container">

<h2>Student Fee Details</h2>

<table>

<tr>
<th>PRN</th>
<th>Name</th>
<th>Room No</th>
<th>Duration</th>
<th>Total Fee</th>
<th>Paid Fee</th>
<th>Pending Fee</th>
<th>Phone</th>
</tr>

<%

Connection conn=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

conn=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hostelmanagement_db",
"root",
""
);

String sql="SELECT prn,name,room_no,duration,fee,paid_fee,pending_fee,phone FROM student";

ps=conn.prepareStatement(sql);

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getString("prn")%></td>

<td><%=rs.getString("name")%></td>

<td><%=rs.getString("room_no")%></td>

<td><%=rs.getString("duration")%> Months</td>

<td>₹<%=rs.getString("fee")%></td>

<td>₹<%=rs.getString("paid_fee")%></td>

<td>₹<%=rs.getString("pending_fee")%></td>

<td><%=rs.getString("phone")%></td>

</tr>

<%

}

}catch(Exception e){

out.println("<tr><td colspan='8'>Error : "+e.getMessage()+"</td></tr>");

}finally{

try{ if(rs!=null) rs.close(); }catch(Exception e){}
try{ if(ps!=null) ps.close(); }catch(Exception e){}
try{ if(conn!=null) conn.close(); }catch(Exception e){}

}

%>

</table>

<a href="admindashboard.jsp" class="back">⬅ Back</a>

</div>

</body>
</html>
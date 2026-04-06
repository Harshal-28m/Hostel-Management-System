<%-- 
    Document   : receipt
    Created on : Mar 23, 2026, 9:56:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
Integer studentId = (Integer) session.getAttribute("student_id");

if (studentId == null) {
    response.sendRedirect("studentlogin.jsp");
    return;
}

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hostelmanagement_db", "root", "");

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM student WHERE id=?");

ps.setInt(1, studentId);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>Receipt</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
    body {
    font-family: 'Poppins', Arial, sans-serif;
    background: #eef2f7;
    margin: 0;
    padding: 30px;
}

.receipt {
    width: 750px;
    margin: auto;
    background: #fff;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #007bff;
    padding-bottom: 10px;
}

.top-bar h1 {
    margin: 0;
    color: #007bff;
}

.top-bar .receipt-id {
    text-align: right;
    font-size: 14px;
    color: #555;
}

.title {
    text-align: center;
    font-size: 22px;
    margin: 20px 0;
    font-weight: bold;
    color: #333;
}

.info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.info div {
    font-size: 14px;
    color: #555;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

th {
    background: #007bff;
    color: white;
    padding: 10px;
}

td {
    padding: 12px;
    border-bottom: 1px solid #ddd;
    text-align: center;
}

.total-box {
    margin-top: 20px;
    text-align: right;
}

.total-box p {
    font-size: 16px;
    margin: 5px 0;
}

.total-box .highlight {
    font-weight: bold;
    color: #007bff;
}

.status {
    padding: 6px 15px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: bold;
}

.paid {
    background: #28a745;
    color: white;
}

.pending {
    background: #dc3545;
    color: white;
}



.print-btn {
    margin-top: 25px;
    padding: 12px 25px;
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

.print-btn:hover {
    opacity: 0.9;
}

@media print {
    .print-btn {
        display: none;
    }

    body {
        background: white;
    }

    .receipt {
        box-shadow: none;
    }
}
</style>

<script>
function printReceipt() {
    window.print();
}
</script>

</head>
<body>

<div class="receipt">

<div class="top-bar">
    <h1>IMRDA Hostel</h1>
    <div class="receipt-id">
        Receipt No: #<%= studentId %><br>
        Date: <%= new java.util.Date() %>
    </div>
</div>

<div class="title">FEE INVOICE</div>

<%
if (rs.next()) {

    double fee = rs.getDouble("fee");
    double paid = rs.getDouble("paid_fee");
    double pending = fee - paid;

    String statusClass = (pending == 0) ? "paid" : "pending";
    String statusText = (pending == 0) ? "PAID" : "PENDING";
%>

<div class="info">
    <div>
        <b>Name:</b> <%= rs.getString("name") %><br>
        <b>Course:</b> <%= rs.getString("course") %><br>
        <b>PRN No</b> <%= rs.getString("prn") %>
        
    </div>

    <div>
        <b>Room No:</b> <%= rs.getString("room_no") %><br>
        <b>Academic Year:</b> <%= rs.getString("academicyear") %>
    </div>
</div>

<table>
    <tr>
        <th>Description</th>
        <th>Amount (₹)</th>
    </tr>
    <tr>
    <td>Duration</td>
    <td><%= rs.getString("duration") %> Months</td>
</tr>
    <tr>
        <td>Total Fee</td>
        <td><%= fee %></td>
    </tr>
    <tr>
        <td>Paid Fee</td>
        <td><%= paid %></td>
    </tr>
    <tr>
        <td>Pending Fee</td>
        <td><%= pending %></td>
    </tr>
</table>

<div class="total-box">
    <p>Status: <span class="status <%= statusClass %>"><%= statusText %></span></p>
</div>


<%
}
con.close();
%>

</div>
<center>
<button class="print-btn" onclick="printReceipt()">
    Download / Print Receipt
</button>
</center>

</body>
</html>
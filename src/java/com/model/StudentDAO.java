package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private final Connection con;

    public StudentDAO(Connection con) {
        this.con = con;
    }

    public List<Student> getAllStudents() {

        List<Student> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM student";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();

                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPassword(rs.getString("password"));
                s.setPhone(rs.getString("phone"));
                s.setRoom_no(rs.getString("room_no"));
                s.setAddress(rs.getString("address"));
                s.setCity(rs.getString("city"));
                s.setCourse(rs.getString("course"));
                s.setParents_no(rs.getString("parents_no"));
                s.setDob(rs.getString("dob"));

                list.add(s);
            }

            System.out.println("Students fetched = " + list.size());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
package com.example.pttk_final.DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EmployeeDAO extends DAO {

    public EmployeeDAO() {
        super();
    }

    public boolean existsByMemberId(int memberId) {
        String sql = "SELECT 1 FROM tblEmployee WHERE tblMemberid = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean ensureEmployee(int memberId, String defaultPosition) {
        if (memberId <= 0) {
            return false;
        }
        if (existsByMemberId(memberId)) {
            return true;
        }
        String sql = "INSERT INTO tblEmployee(tblMemberid, position) VALUES(?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ps.setString(2, defaultPosition);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

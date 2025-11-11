package com.example.pttk_final.DAO;

import com.example.pttk_final.Entity.Member;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO extends DAO {

    public MemberDAO() {
        super();
    }

    public boolean addMember(Member member) {
        String sql = "INSERT INTO tblMember(username, password, name, dateOfBirth, address, phoneNumber, email) VALUES(?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, member.getUsername());
            ps.setString(2, member.getPassword());
            ps.setString(3, member.getName());
            ps.setDate(4, member.getDateOfBirth());
            ps.setString(5, member.getAddress());
            ps.setString(6, member.getPhoneNumber());
            ps.setString(7, member.getEmail());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Member checkLogin(String username, String password) {
        String sql = "SELECT * FROM tblMember WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setName(rs.getString("name"));
                // Lấy các thông tin khác nếu cần
                return member;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

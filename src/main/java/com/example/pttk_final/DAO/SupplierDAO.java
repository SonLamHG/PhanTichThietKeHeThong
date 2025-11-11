package com.example.pttk_final.DAO;

import com.example.pttk_final.Entity.Supplier;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO extends DAO {

    public SupplierDAO() {
        super();
    }

    public List<Supplier> searchSupplier(String name) {
        List<Supplier> list = new ArrayList<>();
        String sql = "SELECT * FROM tblSupplier WHERE name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setName(rs.getString("name"));
                supplier.setAddress(rs.getString("address"));
                supplier.setPhoneNumber(rs.getString("phoneNumber"));
                supplier.setEmail(rs.getString("email"));
                list.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Supplier getSupplierById(int id) {
        String sql = "SELECT * FROM tblSupplier WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setName(rs.getString("name"));
                supplier.setAddress(rs.getString("address"));
                supplier.setPhoneNumber(rs.getString("phoneNumber"));
                supplier.setEmail(rs.getString("email"));
                return supplier;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addSupplier(Supplier supplier) {
        String sql = "INSERT INTO tblSupplier(name, address, phoneNumber, email) VALUES(?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, supplier.getName());
            ps.setString(2, supplier.getAddress());
            ps.setString(3, supplier.getPhoneNumber());
            ps.setString(4, supplier.getEmail());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

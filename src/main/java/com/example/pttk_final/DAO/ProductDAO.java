package com.example.pttk_final.DAO;

import com.example.pttk_final.Entity.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DAO {

    public ProductDAO() {
        super();
    }

    public List<Product> searchProduct(String name) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM tblProduct WHERE name LIKE ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setUnitPrice(rs.getFloat("unitPrice"));
                    product.setBrand(rs.getString("brand"));
                    product.setCategory(rs.getString("category"));
                    product.setUnit(rs.getString("unit"));
                    list.add(product);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in searchProduct: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM tblProduct WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setUnitPrice(rs.getFloat("unitPrice"));
                    product.setBrand(rs.getString("brand"));
                    product.setCategory(rs.getString("category"));
                    product.setUnit(rs.getString("unit"));
                    return product;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getProductById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO tblProduct(name, unitPrice, brand, category, unit) VALUES(?,?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getName());
            ps.setFloat(2, product.getUnitPrice());
            ps.setString(3, product.getBrand());
            ps.setString(4, product.getCategory());
            ps.setString(5, product.getUnit());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            System.err.println("Error in addProduct: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

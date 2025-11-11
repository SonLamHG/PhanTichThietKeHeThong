package com.example.pttk_final.DAO;

import com.example.pttk_final.Entity.PurchaseDetail;
import com.example.pttk_final.Entity.PurchaseInvoice;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class PurchaseDAO extends DAO {

    public PurchaseDAO() {
        super();
    }

    public int addPurchaseInvoice(PurchaseInvoice invoice) {
        String sql = "INSERT INTO tblPurchaseInvoice(paymentDate, paymentType, tblSupplierid, tblEmployeetblMemberid) VALUES(?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, invoice.getPaymentDate());
            ps.setString(2, invoice.getPaymentType());
            ps.setInt(3, invoice.getSupplier().getId());
            ps.setInt(4, invoice.getEmployee().getId());

            ps.executeUpdate();
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int invoiceId = generatedKeys.getInt(1);
                // Add purchase details
                for (PurchaseDetail detail : invoice.getListPD()) {
                    addPurchaseDetail(detail, invoiceId);
                }
                return invoiceId;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void addPurchaseDetail(PurchaseDetail detail, int invoiceId) {
        String sql = "INSERT INTO tblPurchaseDetail(quantity, unitPrice, tblPurchaseInvoiceid, tblProductid) VALUES(?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, detail.getQuantity());
            ps.setFloat(2, detail.getUnitPrice());
            ps.setInt(3, invoiceId);
            ps.setInt(4, detail.getProduct().getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

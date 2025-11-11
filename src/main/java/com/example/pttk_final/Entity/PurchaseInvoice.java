package com.example.pttk_final.Entity;

import java.sql.Date;
import java.util.List;

public class PurchaseInvoice {
    private int id;
    private Date paymentDate;
    private String paymentType;
    private Supplier supplier;
    private Employee employee;
    private List<PurchaseDetail> listPD;

    public PurchaseInvoice() {
    }

    public PurchaseInvoice(int id, Date paymentDate, String paymentType, Supplier supplier, Employee employee, List<PurchaseDetail> listPD) {
        this.id = id;
        this.paymentDate = paymentDate;
        this.paymentType = paymentType;
        this.supplier = supplier;
        this.employee = employee;
        this.listPD = listPD;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public List<PurchaseDetail> getListPD() {
        return listPD;
    }

    public void setListPD(List<PurchaseDetail> listPD) {
        this.listPD = listPD;
    }
}

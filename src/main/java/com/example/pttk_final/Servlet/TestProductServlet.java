package com.example.pttk_final.Servlet;

import com.example.pttk_final.DAO.ProductDAO;
import com.example.pttk_final.Entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "TestProductServlet", urlPatterns = "/test-products")
public class TestProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><meta charset='UTF-8'><title>Test</title></head><body>");
            out.println("<h1>Testing Product DAO</h1>");
            out.flush();
            
            System.out.println("Creating ProductDAO...");
            ProductDAO productDAO = new ProductDAO();
            out.println("<p>✓ ProductDAO created</p>");
            out.flush();
            
            System.out.println("Searching products...");
            List<Product> products = productDAO.searchProduct("");
            out.println("<p>✓ Search completed. Found: " + (products != null ? products.size() : "null") + " products</p>");
            out.flush();
            
            if (products != null && !products.isEmpty()) {
                out.println("<table border='1' style='border-collapse:collapse;'>");
                out.println("<tr style='background:#eee;'><th>ID</th><th>Name</th><th>Brand</th><th>Unit</th><th>Price</th></tr>");
                
                for (Product p : products) {
                    out.println("<tr>");
                    out.println("<td>" + p.getId() + "</td>");
                    out.println("<td>" + p.getName() + "</td>");
                    out.println("<td>" + (p.getBrand() != null ? p.getBrand() : "-") + "</td>");
                    out.println("<td>" + p.getUnit() + "</td>");
                    out.println("<td>" + String.format("%,.0f", p.getUnitPrice()) + "</td>");
                    out.println("</tr>");
                    out.flush(); // Flush after each row
                }
                
                out.println("</table>");
            }
            
            out.println("<hr><p style='color:green;font-weight:bold;'>✓ SUCCESS - All data loaded!</p>");
            out.println("</body></html>");
            out.flush();
            
        } catch (Exception e) {
            System.err.println("Error in TestProductServlet: " + e.getMessage());
            e.printStackTrace();
            
            out.println("<div style='padding:20px;background:#fee;border:2px solid red;'>");
            out.println("<h2 style='color:red;'>ERROR</h2>");
            out.println("<p><strong>Message:</strong> " + e.getMessage() + "</p>");
            out.println("<pre style='background:#fff;padding:10px;overflow:auto;'>");
            e.printStackTrace(out);
            out.println("</pre>");
            out.println("</div></body></html>");
            out.flush();
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}

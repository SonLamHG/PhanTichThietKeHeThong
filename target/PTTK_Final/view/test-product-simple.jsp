<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pttk_final.DAO.ProductDAO" %>
<%@ page import="com.example.pttk_final.Entity.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Product Search</title>
</head>
<body>
    <h1>Test Product Search - Simple Version</h1>
    <%
    try {
        out.println("<p>Starting product search...</p>");
        out.flush();
        
        ProductDAO productDAO = new ProductDAO();
        out.println("<p>ProductDAO created successfully</p>");
        out.flush();
        
        List<Product> products = productDAO.searchProduct("");
        out.println("<p>Search completed. Found " + (products != null ? products.size() : 0) + " products</p>");
        out.flush();
        
        if (products != null && !products.isEmpty()) {
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>Name</th><th>Brand</th><th>Unit</th><th>Price</th></tr>");
            for (Product p : products) {
                out.println("<tr>");
                out.println("<td>" + p.getId() + "</td>");
                out.println("<td>" + (p.getName() != null ? p.getName() : "null") + "</td>");
                out.println("<td>" + (p.getBrand() != null ? p.getBrand() : "null") + "</td>");
                out.println("<td>" + (p.getUnit() != null ? p.getUnit() : "null") + "</td>");
                out.println("<td>" + p.getUnitPrice() + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } else {
            out.println("<p>No products found or products is null</p>");
        }
        
        out.println("<p style='color:green;font-weight:bold;'>SUCCESS - Page loaded completely!</p>");
        out.flush();
        
    } catch (Exception e) {
        out.println("<div style='color:red;padding:20px;background:#ffeeee;'>");
        out.println("<h2>ERROR:</h2>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
        out.println("</div>");
        out.flush();
    }
    %>
</body>
</html>

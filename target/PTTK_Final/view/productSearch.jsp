<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pttk_final.Entity.Member" %>
<%@ page import="com.example.pttk_final.Entity.Product" %>
<%@ page import="java.util.List" %>
<%
    Member user = (Member) session.getAttribute("user");
    String contextPath = request.getContextPath();
    if (user == null) {
        response.sendRedirect(contextPath + "/view/login.jsp");
        return;
    }
    String keyword = request.getParameter("productName") == null ? "" : request.getParameter("productName");
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) request.getAttribute("products");
    String flashSuccess = (String) session.getAttribute("purchaseSuccess");
    if (flashSuccess != null) {
        session.removeAttribute("purchaseSuccess");
    }
    String flashError = (String) session.getAttribute("purchaseError");
    if (flashError != null) {
        session.removeAttribute("purchaseError");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm sản phẩm</title>
    <style>
        :root{--primary:#2563eb;--text:#0f172a;--muted:#64748b}
        *{box-sizing:border-box}
        body{margin:0;font-family:"Segoe UI",Arial,sans-serif;color:var(--text)}
        .appbar{position:sticky;top:0;background:var(--primary);color:#fff;padding:14px 20px;display:flex;align-items:center;justify-content:space-between}
        .appbar h1{margin:0;font-size:20px}
        .appbar .right a{color:#fff;text-decoration:none;margin-left:12px;font-weight:600}
        .page{padding:20px}
        form.search{display:flex;gap:10px}
        form.search input[type=text]{flex:1;padding:10px 12px;border:1px solid #cbd5e1;border-radius:8px}
        .btn{display:inline-block;padding:8px 14px;border-radius:8px;text-decoration:none;font-weight:600;border:1px solid #cbd5e1;color:var(--text)}
        .btn.primary{background:var(--primary);color:#fff;border:none}
        table{width:100%;border-collapse:collapse;margin-top:14px}
        th,td{padding:10px 12px;border-bottom:1px solid #e2e8f0;text-align:left}
        thead th{background:#f3f6fb}
        .alert{padding:10px 12px;border-left:4px solid;border-radius:6px;margin:10px 0}
        .alert.success{background:#ecfdf5;border-color:#16a34a}
        .alert.error{background:#fef2f2;border-color:#dc2626}
        .empty{padding:14px 0;color:var(--muted);text-align:center}
        .form-inline{display:flex;gap:10px;align-items:center}
        .form-inline input[type=number]{width:80px;padding:8px 10px;border-radius:8px;border:1px solid #cbd5e1}
        .form-inline input[type=text]{width:120px;padding:8px 10px;border-radius:8px;border:1px solid #cbd5e1}
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
<div class="appbar">
    <h1>Tìm kiếm sản phẩm</h1>
    <div class="right">
        <a class="btn" href="<%= contextPath %>/purchase">Trở lại phiếu nhập</a>
        <a class="btn primary" href="<%= contextPath %>/view/addProduct.jsp">Thêm sản phẩm</a>
    </div>
</div>

<div class="page">
    <form class="search" action="<%= contextPath %>/purchase" method="get">
        <input type="hidden" name="action" value="searchProduct">
        <input type="text" name="productName" value="<%= keyword %>" placeholder="Nhập tên sản phẩm hoặc mã">
        <button class="btn primary" type="submit">Tìm kiếm</button>
    </form>

    <% if (flashSuccess != null) { %>
        <div class="alert success"><%= flashSuccess %></div>
    <% } %>
    <% if (flashError != null) { %>
        <div class="alert error"><%= flashError %></div>
    <% } %>

    <% if (products != null && !products.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>Tên sản phẩm</th>
            <th>Thương hiệu</th>
            <th>Đơn vị</th>
            <th>Đơn giá (VNĐ)</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <% for (Product product : products) { %>
        <tr>
            <td><%= product.getName() %></td>
            <td><%= product.getBrand() == null ? "-" : product.getBrand() %></td>
            <td><%= product.getUnit() %></td>
            <td><%= String.format("%,.0f", product.getUnitPrice()) %></td>
            <td>
                <form class="form-inline" action="<%= contextPath %>/purchase" method="post">
                    <input type="hidden" name="action" value="addProduct">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" value="1" min="1">
                    <label>Đơn giá:</label>
                    <input type="text" name="unitPrice" value="<%= product.getUnitPrice() %>">
                    <button class="btn primary" type="submit">Thêm</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else if (products != null) { %>
        <div class="empty">Không tìm thấy sản phẩm phù hợp. Hãy thử lại với từ khóa khác.</div>
    <% } %>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pttk_final.Entity.Member" %>
<%@ page import="com.example.pttk_final.Entity.Supplier" %>
<%@ page import="java.util.List" %>
<%
    Member user = (Member) session.getAttribute("user");
    String contextPath = request.getContextPath();
    if (user == null) {
        response.sendRedirect(contextPath + "/view/login.jsp");
        return;
    }
    String keyword = request.getParameter("supplierName") == null ? "" : request.getParameter("supplierName");
    @SuppressWarnings("unchecked")
    List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
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
    <title>Tìm kiếm nhà cung cấp</title>
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
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
<div class="appbar">
    <h1>Tìm kiếm nhà cung cấp</h1>
    <div class="right">
        <a class="btn" href="<%= contextPath %>/purchase">Trở lại phiếu nhập</a>
        <a class="btn primary" href="<%= contextPath %>/view/addSupplier.jsp">Thêm nhà cung cấp</a>
    </div>
</div>

<div class="page">
    <form class="search" action="<%= contextPath %>/purchase" method="get">
        <input type="hidden" name="action" value="searchSupplier">
        <input type="text" name="supplierName" value="<%= keyword %>" placeholder="Nhập tên hoặc từ khóa">
        <button class="btn primary" type="submit">Tìm kiếm</button>
    </form>

    <% if (flashSuccess != null) { %>
        <div class="alert success"><%= flashSuccess %></div>
    <% } %>
    <% if (flashError != null) { %>
        <div class="alert error"><%= flashError %></div>
    <% } %>

    <% if (suppliers != null && !suppliers.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>Tên nhà cung cấp</th>
            <th>Địa chỉ</th>
            <th>Điện thoại</th>
            <th>Email</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <% for (Supplier supplier : suppliers) { %>
        <tr>
            <td><%= supplier.getName() %></td>
            <td><%= supplier.getAddress() %></td>
            <td><%= supplier.getPhoneNumber() %></td>
            <td><%= supplier.getEmail() %></td>
            <td>
                <a class="btn primary" href="<%= contextPath %>/purchase?action=selectSupplier&id=<%= supplier.getId() %>">Chọn</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else if (suppliers != null) { %>
        <div class="empty">Không tìm thấy nhà cung cấp phù hợp. Hãy thử lại với từ khóa khác.</div>
    <% } %>
</div>
</body>
</html>

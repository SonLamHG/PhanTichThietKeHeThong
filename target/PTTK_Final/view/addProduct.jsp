<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pttk_final.Entity.Member" %>
<%
    Member user = (Member) session.getAttribute("user");
    String contextPath = request.getContextPath();
    if (user == null) {
        response.sendRedirect(contextPath + "/view/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm sản phẩm</title>
    <style>
        :root{--primary:#2563eb;--text:#0f172a}
        *{box-sizing:border-box}
        body{margin:0;font-family:"Segoe UI",Arial,sans-serif;color:var(--text)}
        .appbar{position:sticky;top:0;background:var(--primary);color:#fff;padding:14px 20px;display:flex;justify-content:space-between;align-items:center}
        .appbar h1{margin:0;font-size:20px}
        .appbar a{color:#fff;text-decoration:none;font-weight:600}
        .page{padding:20px}
        form{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:16px}
        label{font-weight:600;margin-bottom:6px;display:block}
        input[type=text],input[type=number]{width:100%;padding:10px 12px;border-radius:8px;border:1px solid #cbd5e1}
        .actions{grid-column:1 / -1}
        .btn{padding:10px 16px;border-radius:8px;border:none;background:var(--primary);color:#fff;font-weight:600}
        .back-link{display:inline-block;margin-top:12px;color:var(--primary);text-decoration:none;font-weight:600}
    </style>
</head>
<body>
<div class="appbar">
    <h1>Thêm sản phẩm</h1>
    <a href="<%= contextPath %>/purchase?action=productSearch">Quay lại danh sách</a>
</div>
<div class="page">
    <form action="<%= contextPath %>/purchase" method="post">
        <input type="hidden" name="action" value="addNewProduct">

        <div>
            <label for="name">Tên sản phẩm</label>
            <input id="name" type="text" name="name" required>
        </div>

        <div class="input-row">
            <div>
                <label for="price">Đơn giá (VNĐ)</label>
                <input id="price" type="number" step="0.01" min="0" name="price" required>
            </div>
            <div>
                <label for="unit">Đơn vị tính</label>
                <input id="unit" type="text" name="unit" required>
            </div>
        </div>

        <div class="input-row">
            <div>
                <label for="brand">Thương hiệu</label>
                <input id="brand" type="text" name="brand">
            </div>
            <div>
                <label for="category">Danh mục</label>
                <input id="category" type="text" name="category">
            </div>
        </div>

        <div class="actions">
            <button class="btn" type="submit">Lưu sản phẩm</button>
        </div>
    </form>
    <a class="back-link" href="<%= contextPath %>/purchase?action=productSearch">&larr; Quay lại danh sách</a>
</div>
</body>
</html>

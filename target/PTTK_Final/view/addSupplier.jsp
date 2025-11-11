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
    <title>Thêm nhà cung cấp</title>
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
        input[type=text],input[type=email]{width:100%;padding:10px 12px;border-radius:8px;border:1px solid #cbd5e1}
        .actions{margin-top:10px}
        .btn{padding:10px 16px;border-radius:8px;border:none;background:var(--primary);color:#fff;font-weight:600}
        .back-link{display:inline-block;margin-top:12px;color:var(--primary);text-decoration:none;font-weight:600}
    </style>
</head>
<body>
<div class="appbar">
    <h1>Thêm nhà cung cấp</h1>
    <a href="<%= contextPath %>/purchase?action=supplierSearch">Quay lại danh sách</a>
</div>
<div class="page">
    <form action="<%= contextPath %>/purchase" method="post">
        <input type="hidden" name="action" value="addSupplier">

        <div>
            <label for="name">Tên nhà cung cấp</label>
            <input id="name" type="text" name="name" required>
        </div>
        <div>
            <label for="address">Địa chỉ</label>
            <input id="address" type="text" name="address" required>
        </div>
        <div>
            <label for="phone">Số điện thoại</label>
            <input id="phone" type="text" name="phone" required>
        </div>
        <div>
            <label for="email">Email</label>
            <input id="email" type="email" name="email">
        </div>
        <div class="actions">
            <button class="btn" type="submit">Lưu nhà cung cấp</button>
        </div>
    </form>
    <a class="back-link" href="<%= contextPath %>/purchase?action=supplierSearch">&larr; Quay lại danh sách</a>
</div>
</body>
</html>

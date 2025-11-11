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
    <title>Bảng điều khiển</title>
    <style>
        :root { --primary:#2563eb; --text:#0f172a; --muted:#64748b; }
        * { box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            color: var(--text);
            background: #ffffff;
        }
        .appbar {
            position: sticky; top: 0; width: 100%;
            background: var(--primary);
            color: #fff; padding: 14px 20px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .appbar h1 { margin: 0; font-size: 20px; font-weight: 600; }
        .appbar .right a { color:#fff; text-decoration:none; margin-left:12px; font-weight:600; }

        .content { padding: 20px; }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 16px;
        }
        .tile {
            padding: 20px;
            background: #f3f6fb;
            border: 1px dashed #c7d2fe;
            border-radius: 10px;
            text-decoration: none; color: inherit;
        }
        .tile h2 { margin: 0 0 6px; font-size: 18px; color: var(--primary); }
        .tile p { margin: 0; color: var(--muted); }
        .cta { margin: 16px 0 24px; display:flex; gap:10px; flex-wrap: wrap; }
        .btn { padding:10px 16px; border-radius:8px; text-decoration:none; font-weight:600; display:inline-block; }
        .btn.primary { background: var(--primary); color:#fff; }
        .btn.ghost { border:1px solid #cbd5e1; color: var(--text); }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>
<body>
<div class="appbar">
    <h1>Xin chào, <%= user.getName() %></h1>
    <div class="right">
        <a href="<%= contextPath %>/purchase">Tạo phiếu nhập</a>
        <a href="<%= contextPath %>/logout">Đăng xuất</a>
    </div>
    </div>

<div class="content">
    <div class="cta">
        <a class="btn primary" href="<%= contextPath %>/purchase">Bắt đầu lập phiếu nhập</a>
        <a class="btn ghost" href="<%= contextPath %>/purchase?action=supplierSearch">Xem nhà cung cấp</a>
        <a class="btn ghost" href="<%= contextPath %>/purchase?action=productSearch">Xem sản phẩm</a>
    </div>

    <div class="grid">
        <a class="tile" href="<%= contextPath %>/purchase">
            <h2>Quản lý nhập hàng</h2>
            <p>Lập phiếu nhập, chọn nhà cung cấp và kiểm soát hàng hóa.</p>
        </a>
        <a class="tile" href="<%= contextPath %>/purchase?action=supplierSearch">
            <h2>Nhà cung cấp</h2>
            <p>Tra cứu thông tin nhà cung cấp, cập nhật dữ liệu liên hệ.</p>
        </a>
        <a class="tile" href="<%= contextPath %>/purchase?action=productSearch">
            <h2>Sản phẩm</h2>
            <p>Kiểm tra danh mục sản phẩm, bổ sung thông tin chi tiết.</p>
        </a>
    </div>
</div>
</body>
</html>

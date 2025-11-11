<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pttk_final.Entity.Member" %>
<%@ page import="com.example.pttk_final.Entity.Supplier" %>
<%@ page import="com.example.pttk_final.Entity.PurchaseDetail" %>
<%@ page import="java.util.List" %>
<%
    Member user = (Member) session.getAttribute("user");
    String contextPath = request.getContextPath();
    if (user == null) {
        response.sendRedirect(contextPath + "/view/login.jsp");
        return;
    }
    Supplier selectedSupplier = (Supplier) session.getAttribute("selectedSupplier");
    List<PurchaseDetail> cart = (List<PurchaseDetail>) session.getAttribute("cart");

    String flashSuccess = (String) session.getAttribute("purchaseSuccess");
    if (flashSuccess != null) {
        session.removeAttribute("purchaseSuccess");
    }
    String flashError = (String) session.getAttribute("purchaseError");
    if (flashError != null) {
        session.removeAttribute("purchaseError");
    }
    String requestError = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý nhập hàng</title>
    <style>
        :root { --primary:#2563eb; --text:#0f172a; --muted:#64748b; }
        *{box-sizing:border-box}
        body{margin:0;font-family:"Segoe UI",Arial,sans-serif;color:var(--text);background:#fff}
        .appbar{position:sticky;top:0;background:var(--primary);color:#fff;padding:14px 20px;display:flex;justify-content:space-between;align-items:center}
        .appbar h1{margin:0;font-size:20px}
        .appbar .actions a{color:#fff;text-decoration:none;margin-left:12px;font-weight:600}
        .page{padding:20px}
        h2{margin:0 0 10px;color:var(--primary);font-size:18px}
        .section{margin-bottom:20px;padding:14px;border-bottom:1px solid #e2e8f0}
        .row{display:flex;justify-content:space-between;gap:12px;flex-wrap:wrap}
        .btn{display:inline-block;padding:8px 14px;border-radius:8px;text-decoration:none;font-weight:600;border:1px solid #cbd5e1;color:var(--text)}
        .btn.primary{background:var(--primary);color:#fff;border:none}
        .btn.danger{background:#dc2626;color:#fff;border:none}
        table{width:100%;border-collapse:collapse}
        th,td{padding:10px 12px;border-bottom:1px solid #e2e8f0;text-align:left}
        thead th{background:#f3f6fb}
        .badge{display:inline-block;padding:4px 8px;border-radius:999px;background:#f3f6fb;color:var(--text);font-size:12px}
        .alert{padding:10px 12px;border-left:4px solid;border-radius:6px;margin:10px 0}
        .alert.success{background:#ecfdf5;border-color:#16a34a}
        .alert.error{background:#fef2f2;border-color:#dc2626}
        .empty{color:var(--muted);padding:10px 0}
        .total-row{font-weight:700;background:#f3f6fb}
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
<div class="appbar">
    <h1>Phiếu nhập hàng</h1>
    <div class="actions">
        <span class="badge">NV: <%= user.getName() %></span>
        <a class="btn" href="<%= contextPath %>/view/home.jsp">Trang chủ</a>
        <a class="btn" href="<%= contextPath %>/logout">Đăng xuất</a>
    </div>
</div>

<div class="page">

    <% if (flashSuccess != null) { %>
        <div class="alert success"><%= flashSuccess %></div>
    <% } %>
    <% if (flashError != null) { %>
        <div class="alert error"><%= flashError %></div>
    <% } %>
    <% if (requestError != null) { %>
        <div class="alert error"><%= requestError %></div>
    <% } %>

    <div class="section">
        <div class="row">
            <div style="min-width:260px;">
                <h2>Nhà cung cấp</h2>
                <% if (selectedSupplier != null) { %>
                    <div><strong><%= selectedSupplier.getName() %></strong></div>
                    <div>Địa chỉ: <%= selectedSupplier.getAddress() %></div>
                    <div>Điện thoại: <%= selectedSupplier.getPhoneNumber() %></div>
                    <div>Email: <%= selectedSupplier.getEmail() %></div>
                <% } else { %>
                    <div class="empty">Chưa chọn nhà cung cấp.</div>
                <% } %>
            </div>
            <div>
                <a class="btn primary" href="<%= contextPath %>/purchase?action=supplierSearch">Chọn nhà cung cấp</a>
                <a class="btn" href="<%= contextPath %>/view/addSupplier.jsp">Thêm nhà cung cấp mới</a>
            </div>
        </div>
    </div>

    <div class="section">
        <div class="row">
            <h2>Giỏ sản phẩm</h2>
            <div>
                <a class="btn primary" href="<%= contextPath %>/purchase?action=productSearch">Thêm sản phẩm</a>
                <a class="btn" href="<%= contextPath %>/view/addProduct.jsp">Tạo sản phẩm mới</a>
            </div>
        </div>

        <% if (cart != null && !cart.isEmpty()) {
            float totalAmount = 0;
        %>
        <table>
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn giá (VNĐ)</th>
                <th>Thành tiền</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <% for (PurchaseDetail detail : cart) {
                float amount = detail.getQuantity() * detail.getUnitPrice();
                totalAmount += amount;
            %>
            <tr>
                <td><%= detail.getProduct().getName() %></td>
                <td><%= detail.getQuantity() %></td>
                <td><%= String.format("%,.0f", detail.getUnitPrice()) %></td>
                <td><%= String.format("%,.0f", amount) %></td>
                <td>
                    <form style="display:inline" action="<%= contextPath %>/purchase" method="post">
                        <input type="hidden" name="action" value="removeProduct">
                        <input type="hidden" name="productId" value="<%= detail.getProduct().getId() %>">
                        <button class="btn danger" type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
            <% } %>
            <tr class="total-row">
                <td colspan="3">Tổng cộng</td>
                <td colspan="2"><%= String.format("%,.0f", totalAmount) %> VNĐ</td>
            </tr>
            </tbody>
        </table>
        <form style="margin-top: 16px; display: flex; gap: 12px; align-items: center;" action="<%= contextPath %>/purchase" method="post">
            <input type="hidden" name="action" value="createInvoice">
            <label>Hình thức thanh toán:</label>
            <select name="paymentType" style="padding: 10px 16px; border-radius: 8px; border: 1px solid #cbd5f5;">
                <option value="Tiền mặt">Tiền mặt</option>
                <option value="Chuyển khoản">Chuyển khoản</option>
            </select>
            <button class="btn primary" type="submit">Xác nhận nhập hàng</button>
        </form>
        <% } else { %>
        <div class="empty">Chưa có sản phẩm nào trong phiếu nhập. Hãy thêm sản phẩm từ danh sách.</div>
        <% } %>
    </div>
</div>
</body>
</html>

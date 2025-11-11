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
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhập hàng - Hệ thống quản lý</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --primary-light: #dbeafe;
            --success: #10b981;
            --success-light: #d1fae5;
            --error: #ef4444;
            --error-light: #fee2e2;
            --warning: #f59e0b;
            --warning-light: #fef3c7;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --text-muted: #9ca3af;
            --border: #e5e7eb;
            --bg-primary: #ffffff;
            --bg-secondary: #f9fafb;
            --bg-hover: #f3f4f6;
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--bg-secondary);
            color: var(--text-primary);
            line-height: 1.6;
            min-height: 100vh;
        }
        
        /* Header */
        .header {
            background: var(--bg-primary);
            border-bottom: 1px solid var(--border);
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 16px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }
        
        .header-left h1 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 4px;
        }
        
        .header-left .user-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: var(--primary-light);
            color: var(--primary-dark);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .header-right {
            display: flex;
            gap: 12px;
        }
        
        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
        }
        
        .btn-secondary {
            background: var(--bg-primary);
            color: var(--text-primary);
            border: 1px solid var(--border);
        }
        
        .btn-secondary:hover {
            background: var(--bg-hover);
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        .btn-danger {
            background: var(--error);
            color: white;
        }
        
        .btn-danger:hover {
            background: #dc2626;
        }
        
        .btn-sm {
            padding: 6px 14px;
            font-size: 13px;
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px 24px;
        }
        
        /* Alerts */
        .alert {
            padding: 14px 18px;
            border-radius: 10px;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            font-size: 14px;
            animation: slideIn 0.3s ease;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-success {
            background: var(--success-light);
            color: #065f46;
            border: 1px solid var(--success);
        }
        
        .alert-error {
            background: var(--error-light);
            color: #991b1b;
            border: 1px solid var(--error);
        }
        
        .alert::before {
            content: '✓';
            font-weight: 700;
            font-size: 16px;
        }
        
        .alert-error::before {
            content: '✕';
        }
        
        /* Section Card */
        .section-card {
            background: var(--bg-primary);
            border-radius: 12px;
            padding: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 24px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }
        
        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-actions {
            display: flex;
            gap: 10px;
        }
        
        /* Supplier Info */
        .supplier-info {
            background: var(--bg-secondary);
            padding: 20px;
            border-radius: 10px;
            border: 2px dashed var(--border);
        }
        
        .supplier-info h3 {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 12px;
            color: var(--primary);
        }
        
        .supplier-info .info-row {
            display: flex;
            gap: 8px;
            margin-bottom: 6px;
            font-size: 14px;
        }
        
        .supplier-info .info-label {
            font-weight: 600;
            color: var(--text-secondary);
            min-width: 100px;
        }
        
        .supplier-info .info-value {
            color: var(--text-primary);
        }
        
        .empty-state-mini {
            color: var(--text-muted);
            font-size: 14px;
            font-style: italic;
        }
        
        /* Table */
        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid var(--border);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: var(--bg-secondary);
        }
        
        th {
            padding: 14px 16px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background 0.15s ease;
        }
        
        tbody tr:hover {
            background: var(--bg-secondary);
        }
        
        tbody tr:last-child {
            border-bottom: none;
        }
        
        td {
            padding: 16px;
            font-size: 14px;
        }
        
        .total-row {
            background: var(--primary-light) !important;
            font-weight: 700;
            font-size: 15px;
        }
        
        .total-row td {
            color: var(--primary-dark);
        }
        
        /* Checkout Section */
        .checkout-section {
            background: var(--warning-light);
            border: 2px solid var(--warning);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
        
        .checkout-form {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }
        
        .checkout-form label {
            font-weight: 600;
            font-size: 14px;
            color: var(--text-primary);
        }
        
        .checkout-form select {
            padding: 10px 16px;
            border: 2px solid var(--border);
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            background: white;
            cursor: pointer;
        }
        
        .checkout-form select:focus {
            outline: none;
            border-color: var(--primary);
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
        }
        
        .empty-icon {
            font-size: 48px;
            margin-bottom: 12px;
            opacity: 0.5;
        }
        
        .empty-message {
            font-size: 14px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .header-right {
                width: 100%;
            }
            
            .container {
                padding: 20px 16px;
            }
            
            .section-card {
                padding: 20px 16px;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .section-actions {
                width: 100%;
            }
            
            .checkout-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .checkout-form select,
            .checkout-form button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <div class="header-left">
                <h1>📋 Phiếu nhập hàng</h1>
                <span class="user-badge">👤 <%= user.getName() %></span>
            </div>
            <div class="header-right">
                <a href="<%= contextPath %>/view/home.jsp" class="btn btn-secondary">🏠 Trang chủ</a>
                <a href="<%= contextPath %>/logout" class="btn btn-secondary">Đăng xuất</a>
            </div>
        </div>
    </header>

    <main class="container">
        <!-- Alerts -->
        <% if (flashSuccess != null) { %>
            <div class="alert alert-success"><%= flashSuccess %></div>
        <% } %>
        <% if (flashError != null) { %>
            <div class="alert alert-error"><%= flashError %></div>
        <% } %>
        <% if (requestError != null) { %>
            <div class="alert alert-error"><%= requestError %></div>
        <% } %>

        <!-- Supplier Section -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">🏢 Nhà cung cấp</h2>
                <div class="section-actions">
                    <a href="<%= contextPath %>/purchase?action=supplierSearch" class="btn btn-primary btn-sm">
                        Chọn nhà cung cấp
                    </a>
                    <a href="<%= contextPath %>/view/addSupplier.jsp" class="btn btn-secondary btn-sm">
                        + Thêm mới
                    </a>
                </div>
            </div>
            
            <% if (selectedSupplier != null) { %>
                <div class="supplier-info">
                    <h3><%= selectedSupplier.getName() %></h3>
                    <div class="info-row">
                        <span class="info-label">📍 Địa chỉ:</span>
                        <span class="info-value"><%= selectedSupplier.getAddress() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">📞 Điện thoại:</span>
                        <span class="info-value"><%= selectedSupplier.getPhoneNumber() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">📧 Email:</span>
                        <span class="info-value"><%= selectedSupplier.getEmail() %></span>
                    </div>
                </div>
            <% } else { %>
                <div class="supplier-info">
                    <p class="empty-state-mini">
                        ⚠️ Chưa chọn nhà cung cấp. Vui lòng chọn nhà cung cấp để tiếp tục.
                    </p>
                </div>
            <% } %>
        </div>

        <!-- Cart Section -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">🛒 Giỏ sản phẩm</h2>
                <div class="section-actions">
                    <a href="<%= contextPath %>/purchase?action=productSearch" class="btn btn-primary btn-sm">
                        + Thêm sản phẩm
                    </a>
                    <a href="<%= contextPath %>/view/addProduct.jsp" class="btn btn-secondary btn-sm">
                        Tạo sản phẩm mới
                    </a>
                </div>
            </div>

            <% if (cart != null && !cart.isEmpty()) {
                float totalAmount = 0;
            %>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn giá (VNĐ)</th>
                            <th>Thành tiền</th>
                            <th style="width: 100px;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (PurchaseDetail detail : cart) {
                            float amount = detail.getQuantity() * detail.getUnitPrice();
                            totalAmount += amount;
                        %>
                        <tr>
                            <td><strong><%= detail.getProduct().getName() %></strong></td>
                            <td><%= detail.getQuantity() %></td>
                            <td><%= String.format("%,.0f", detail.getUnitPrice()) %></td>
                            <td><%= String.format("%,.0f", amount) %></td>
                            <td>
                                <form style="display:inline" action="<%= contextPath %>/purchase" method="post">
                                    <input type="hidden" name="action" value="removeProduct">
                                    <input type="hidden" name="productId" value="<%= detail.getProduct().getId() %>">
                                    <button class="btn btn-danger btn-sm" type="submit">Xóa</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        <tr class="total-row">
                            <td colspan="3"><strong>💰 TỔNG CỘNG</strong></td>
                            <td colspan="2"><strong><%= String.format("%,.0f", totalAmount) %> VNĐ</strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <div class="checkout-section">
                <form class="checkout-form" action="<%= contextPath %>/purchase" method="post">
                    <input type="hidden" name="action" value="createInvoice">
                    <label>💳 Hình thức thanh toán:</label>
                    <select name="paymentType">
                        <option value="Tiền mặt">💵 Tiền mặt</option>
                        <option value="Chuyển khoản">🏦 Chuyển khoản</option>
                    </select>
                    <button class="btn btn-primary" type="submit">
                        ✅ Xác nhận nhập hàng
                    </button>
                </form>
            </div>
            <% } else { %>
            <div class="empty-state">
                <div class="empty-icon">🛒</div>
                <p class="empty-message">
                    Chưa có sản phẩm nào trong phiếu nhập.<br>
                    Hãy thêm sản phẩm từ danh sách.
                </p>
            </div>
            <% } %>
        </div>
    </main>
</body>
</html>

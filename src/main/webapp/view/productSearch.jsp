<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pttk_final.Entity.Member" %>
<%@ page import="com.example.pttk_final.Entity.Product" %>
<%@ page import="java.util.List" %>
<%!
    // Helper method to escape HTML attributes
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;");
    }
%>
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
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm sản phẩm - Hệ thống quản lý</title>
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
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --text-muted: #9ca3af;
            --border: #e5e7eb;
            --bg-primary: #ffffff;
            --bg-secondary: #f9fafb;
            --bg-hover: #f3f4f6;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
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
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }
        
        .header-title {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .header-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 18px;
        }
        
        .header-title h1 {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
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
            box-shadow: var(--shadow-sm);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px 24px;
        }
        
        /* Search Card */
        .search-card {
            background: var(--bg-primary);
            border-radius: 12px;
            padding: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 24px;
        }
        
        .search-header h2 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 4px;
        }
        
        .search-header p {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 20px;
        }
        
        .search-form {
            display: flex;
            gap: 12px;
        }
        
        .search-input-wrapper {
            flex: 1;
            position: relative;
        }
        
        .search-input-wrapper::before {
            content: '🔍';
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            opacity: 0.5;
        }
        
        .search-input {
            width: 100%;
            padding: 12px 16px 12px 48px;
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.2s ease;
            background: var(--bg-secondary);
        }
        
        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            background: var(--bg-primary);
            box-shadow: 0 0 0 3px var(--primary-light);
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
        
        /* Results Card */
        .results-card {
            background: var(--bg-primary);
            border-radius: 12px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        
        .results-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
        }
        
        .results-header h3 {
            font-size: 16px;
            font-weight: 600;
        }
        
        .results-count {
            font-size: 14px;
            color: var(--text-secondary);
            margin-top: 4px;
        }
        
        /* Table */
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: var(--bg-secondary);
        }
        
        th {
            padding: 16px 24px;
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
        
        td {
            padding: 20px 24px;
            font-size: 14px;
        }
        
        td:first-child {
            font-weight: 600;
        }
        
        /* Product form inline */
        .product-form {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .product-form label {
            font-size: 13px;
            color: var(--text-secondary);
            font-weight: 600;
        }
        
        .product-form input[type="number"],
        .product-form input[type="text"] {
            padding: 8px 12px;
            border: 2px solid var(--border);
            border-radius: 6px;
            font-size: 14px;
            width: 90px;
            font-family: inherit;
        }
        
        .product-form input[type="text"] {
            width: 120px;
        }
        
        .product-form input:focus {
            outline: none;
            border-color: var(--primary);
        }
        
        /* Selected Products Section */
        .selected-section {
            margin-top: 32px;
        }
        
        .section-divider {
            height: 2px;
            background: linear-gradient(90deg, var(--primary), transparent);
            margin: 32px 0;
        }
        
        .selected-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .selected-title {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 20px;
            font-weight: 700;
        }
        
        .selected-badge {
            background: var(--primary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .btn-danger {
            background: var(--error);
            color: white;
        }
        
        .btn-danger:hover {
            background: #dc2626;
        }
        
        .btn-success {
            background: var(--success);
            color: white;
        }
        
        .btn-success:hover {
            background: #059669;
        }
        
        .total-row {
            background: var(--primary-light) !important;
            font-weight: 700;
            font-size: 15px;
        }
        
        .total-row td {
            color: var(--primary-dark);
            padding: 16px 24px !important;
        }
        
        .hidden {
            display: none;
        }
        
        .btn-add-simple {
            padding: 6px 14px;
            font-size: 13px;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 24px;
        }
        
        .empty-icon {
            font-size: 64px;
            margin-bottom: 16px;
            opacity: 0.3;
        }
        
        .empty-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .empty-message {
            font-size: 14px;
            color: var(--text-secondary);
            max-width: 400px;
            margin: 0 auto;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-container {
                padding: 0 16px;
                flex-wrap: wrap;
                height: auto;
                padding-top: 12px;
                padding-bottom: 12px;
            }
            
            .header-right {
                width: 100%;
                margin-top: 12px;
            }
            
            .container {
                padding: 20px 16px;
            }
            
            .search-form {
                flex-direction: column;
            }
            
            .product-form {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .product-form input {
                width: 100% !important;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <div class="header-title">
                <div class="header-icon">📦</div>
                <h1>Tìm kiếm sản phẩm</h1>
            </div>
            <div class="header-right">
                <a href="<%= contextPath %>/purchase" class="btn btn-secondary">← Trở lại</a>
                <a href="<%= contextPath %>/view/addProduct.jsp" class="btn btn-primary">+ Thêm mới</a>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="search-card">
            <div class="search-header">
                <h2>Tìm kiếm sản phẩm</h2>
                <p>Nhập tên hoặc mã sản phẩm để tìm kiếm</p>
            </div>
            <form class="search-form" action="<%= contextPath %>/purchase" method="get">
                <input type="hidden" name="action" value="searchProduct">
                <div class="search-input-wrapper">
                    <input 
                        type="text" 
                        name="productName" 
                        value="<%= keyword %>" 
                        placeholder="Nhập tên sản phẩm, mã, thương hiệu..."
                        class="search-input"
                        autofocus
                    >
                </div>
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </form>
        </div>

        <% if (flashSuccess != null) { %>
            <div class="alert alert-success"><%= flashSuccess %></div>
        <% } %>
        <% if (flashError != null) { %>
            <div class="alert alert-error"><%= flashError %></div>
        <% } %>

        <% if (products != null && !products.isEmpty()) { %>
        <div class="results-card">
            <div class="results-header">
                <h3>Kết quả tìm kiếm</h3>
                <div class="results-count">Tìm thấy <%= products.size() %> sản phẩm</div>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Thương hiệu</th>
                            <th>Đơn vị</th>
                            <th>Đơn giá (VNĐ)</th>
                            <th style="width: 120px; text-align: center;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Product product : products) { %>
                        <tr id="search-row-<%= product.getId() %>">
                            <td><%= product.getName() %></td>
                            <td><%= product.getBrand() == null ? "-" : product.getBrand() %></td>
                            <td><%= product.getUnit() %></td>
                            <td><%= String.format("%,.0f", product.getUnitPrice()) %></td>
                            <td style="text-align: center;">
                                <button 
                                    class="btn btn-primary btn-add-simple btn-select-product" 
                                    data-id="<%= product.getId() %>"
                                    data-name="<%= escapeHtml(product.getName()) %>"
                                    data-unit="<%= escapeHtml(product.getUnit()) %>"
                                    data-price="<%= product.getUnitPrice() %>"
                                    type="button"
                                >
                                    + Chọn
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } else if (products != null) { %>
        <div class="results-card">
            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <div class="empty-title">Không tìm thấy kết quả</div>
                <div class="empty-message">
                    Không có sản phẩm nào phù hợp với từ khóa "<%= keyword %>".
                    Vui lòng thử lại với từ khóa khác hoặc thêm sản phẩm mới.
                </div>
            </div>
        </div>
        <% } %>

        <!-- Selected Products Section -->
        <div class="section-divider"></div>
        
        <div class="selected-section">
            <div class="selected-header">
                <h2 class="selected-title">
                    🛒 Sản phẩm đã chọn
                    <span class="selected-badge" id="selected-count">0</span>
                </h2>
                <div style="display: flex; gap: 12px;">
                    <button class="btn btn-danger btn-sm" onclick="clearAllProducts()" id="clear-btn" style="display: none;">
                        🗑️ Xóa tất cả
                    </button>
                    <button class="btn btn-success" onclick="submitSelectedProducts()" id="submit-btn" style="display: none;">
                        ✅ Thêm vào phiếu nhập
                    </button>
                </div>
            </div>

            <div class="results-card" id="selected-products-container" style="display: none;">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>Đơn vị</th>
                                <th style="width: 150px;">Số lượng</th>
                                <th style="width: 180px;">Đơn giá (VNĐ)</th>
                                <th style="width: 180px;">Thành tiền</th>
                                <th style="width: 100px; text-align: center;">Xóa</th>
                            </tr>
                        </thead>
                        <tbody id="selected-products-tbody">
                            <!-- Products will be added here dynamically -->
                        </tbody>
                        <tfoot>
                            <tr class="total-row">
                                <td colspan="4"><strong>💰 TỔNG CỘNG</strong></td>
                                <td colspan="2"><strong id="total-amount">0 VNĐ</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <div class="results-card" id="empty-selected" style="text-align: center; padding: 40px;">
                <div class="empty-icon">🛒</div>
                <div class="empty-title">Chưa có sản phẩm nào được chọn</div>
                <div class="empty-message">
                    Hãy chọn sản phẩm từ danh sách kết quả tìm kiếm bên trên
                </div>
            </div>
        </div>

        <!-- Hidden form to submit products -->
        <form id="submit-form" action="<%= contextPath %>/purchase" method="post" style="display: none;">
            <input type="hidden" name="action" value="addMultipleProducts">
            <div id="form-inputs"></div>
        </form>
    </main>

    <script>
        let selectedProducts = {};

        // Event delegation for select product buttons
        document.addEventListener('DOMContentLoaded', function() {
            // Delegate click events on document body
            document.body.addEventListener('click', function(e) {
                // Check if clicked element or its parent has the class
                const target = e.target.closest('.btn-select-product');
                if (target) {
                    e.preventDefault();
                    const id = parseInt(target.dataset.id);
                    const name = target.dataset.name;
                    const unit = target.dataset.unit;
                    const price = parseFloat(target.dataset.price);
                    addProduct(id, name, unit, price);
                }
            });
        });

        function addProduct(id, name, unit, defaultPrice) {
            if (selectedProducts[id]) {
                alert('Sản phẩm này đã được chọn!');
                return;
            }

            selectedProducts[id] = {
                id: id,
                name: name,
                unit: unit,
                quantity: 1,
                unitPrice: defaultPrice
            };

            renderSelectedProducts();
        }

        function removeProduct(id) {
            delete selectedProducts[id];
            renderSelectedProducts();
        }

        function updateQuantity(id, quantity) {
            if (selectedProducts[id]) {
                selectedProducts[id].quantity = parseInt(quantity) || 1;
                updateTotal();
            }
        }

        function updatePrice(id, price) {
            if (selectedProducts[id]) {
                selectedProducts[id].unitPrice = parseFloat(price) || 0;
                updateTotal();
            }
        }

        function clearAllProducts() {
            if (confirm('Bạn có chắc muốn xóa tất cả sản phẩm đã chọn?')) {
                selectedProducts = {};
                renderSelectedProducts();
            }
        }

        function renderSelectedProducts() {
            const tbody = document.getElementById('selected-products-tbody');
            const container = document.getElementById('selected-products-container');
            const emptyState = document.getElementById('empty-selected');
            const count = document.getElementById('selected-count');
            const clearBtn = document.getElementById('clear-btn');
            const submitBtn = document.getElementById('submit-btn');

            const productCount = Object.keys(selectedProducts).length;
            count.textContent = productCount;

            if (productCount === 0) {
                container.style.display = 'none';
                emptyState.style.display = 'block';
                clearBtn.style.display = 'none';
                submitBtn.style.display = 'none';
                return;
            }

            container.style.display = 'block';
            emptyState.style.display = 'none';
            clearBtn.style.display = 'inline-flex';
            submitBtn.style.display = 'inline-flex';

            tbody.innerHTML = '';
            for (let id in selectedProducts) {
                const product = selectedProducts[id];
                const total = product.quantity * product.unitPrice;
                
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td><strong>${product.name}</strong></td>
                    <td>${product.unit}</td>
                    <td>
                        <input 
                            type="number" 
                            value="${product.quantity}" 
                            min="1" 
                            onchange="updateQuantity(${id}, this.value)"
                            style="width: 100%; padding: 8px 12px; border: 2px solid var(--border); border-radius: 6px; font-size: 14px;"
                        >
                    </td>
                    <td>
                        <input 
                            type="number" 
                            value="${product.unitPrice}" 
                            min="0" 
                            step="0.01"
                            onchange="updatePrice(${id}, this.value)"
                            style="width: 100%; padding: 8px 12px; border: 2px solid var(--border); border-radius: 6px; font-size: 14px;"
                        >
                    </td>
                    <td><strong>${formatCurrency(total)}</strong></td>
                    <td style="text-align: center;">
                        <button 
                            class="btn btn-danger btn-sm" 
                            onclick="removeProduct(${id})"
                            type="button"
                        >
                            Xóa
                        </button>
                    </td>
                `;
                tbody.appendChild(row);
            }

            updateTotal();
        }

        function updateTotal() {
            let total = 0;
            for (let id in selectedProducts) {
                const product = selectedProducts[id];
                total += product.quantity * product.unitPrice;
            }
            document.getElementById('total-amount').textContent = formatCurrency(total);
        }

        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount) + ' VNĐ';
        }

        function submitSelectedProducts() {
            const productCount = Object.keys(selectedProducts).length;
            if (productCount === 0) {
                alert('Vui lòng chọn ít nhất một sản phẩm!');
                return;
            }

            const form = document.getElementById('submit-form');
            const formInputs = document.getElementById('form-inputs');
            formInputs.innerHTML = '';

            for (let id in selectedProducts) {
                const product = selectedProducts[id];
                
                // Add productId
                const inputId = document.createElement('input');
                inputId.type = 'hidden';
                inputId.name = 'productIds';
                inputId.value = id;
                formInputs.appendChild(inputId);

                // Add quantity
                const inputQty = document.createElement('input');
                inputQty.type = 'hidden';
                inputQty.name = 'quantities';
                inputQty.value = product.quantity;
                formInputs.appendChild(inputQty);

                // Add unitPrice
                const inputPrice = document.createElement('input');
                inputPrice.type = 'hidden';
                inputPrice.name = 'unitPrices';
                inputPrice.value = product.unitPrice;
                formInputs.appendChild(inputPrice);
            }

            form.submit();
        }
    </script>
</body>
</html>

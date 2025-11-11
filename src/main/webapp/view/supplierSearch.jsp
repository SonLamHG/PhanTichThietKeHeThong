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
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm nhà cung cấp - Hệ thống quản lý</title>
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
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
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
        
        /* Header Styles */
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
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
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
            align-items: center;
            gap: 12px;
        }
        
        /* Button Styles */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
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
            border-color: var(--text-muted);
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: var(--shadow-sm);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            box-shadow: var(--shadow);
            transform: translateY(-1px);
        }
        
        .btn-icon::before {
            content: '';
            width: 18px;
            height: 18px;
            display: inline-block;
        }
        
        /* Main Container */
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
        
        .search-header {
            margin-bottom: 20px;
        }
        
        .search-header h2 {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 4px;
        }
        
        .search-header p {
            font-size: 14px;
            color: var(--text-secondary);
        }
        
        .search-form {
            display: flex;
            gap: 12px;
            align-items: stretch;
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
        
        .btn-search {
            padding: 12px 32px;
            font-size: 15px;
        }
        
        /* Alert Messages */
        .alert {
            padding: 14px 18px;
            border-radius: 10px;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            font-size: 14px;
            line-height: 1.5;
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
            color: var(--text-primary);
        }
        
        .results-count {
            font-size: 14px;
            color: var(--text-secondary);
            margin-top: 4px;
        }
        
        /* Table Styles */
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
            white-space: nowrap;
        }
        
        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background-color 0.15s ease;
        }
        
        tbody tr:hover {
            background: var(--bg-secondary);
        }
        
        tbody tr:last-child {
            border-bottom: none;
        }
        
        td {
            padding: 20px 24px;
            font-size: 14px;
            color: var(--text-primary);
        }
        
        td:first-child {
            font-weight: 600;
        }
        
        .td-email {
            color: var(--primary);
        }
        
        .td-actions {
            text-align: right;
        }
        
        .btn-select {
            padding: 8px 20px;
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
            color: var(--text-primary);
            margin-bottom: 8px;
        }
        
        .empty-message {
            font-size: 14px;
            color: var(--text-secondary);
            max-width: 400px;
            margin: 0 auto;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .header-container {
                padding: 0 16px;
                height: auto;
                flex-direction: column;
                gap: 12px;
                padding-top: 12px;
                padding-bottom: 12px;
            }
            
            .header-right {
                width: 100%;
                justify-content: space-between;
            }
            
            .container {
                padding: 20px 16px;
            }
            
            .search-card {
                padding: 20px;
            }
            
            .search-form {
                flex-direction: column;
            }
            
            .btn-search {
                width: 100%;
            }
            
            .table-container {
                overflow-x: scroll;
            }
            
            th, td {
                padding: 12px 16px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <div class="header-left">
                <div class="header-title">
                    <div class="header-icon">NCC</div>
                    <h1>Tìm kiếm nhà cung cấp</h1>
                </div>
            </div>
            <div class="header-right">
                <a href="<%= contextPath %>/purchase" class="btn btn-secondary">← Trở lại</a>
                <a href="<%= contextPath %>/view/addSupplier.jsp" class="btn btn-primary">+ Thêm mới</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container">
        <!-- Search Card -->
        <div class="search-card">
            <div class="search-header">
                <h2>Tìm kiếm nhà cung cấp</h2>
                <p>Nhập tên hoặc thông tin nhà cung cấp để tìm kiếm</p>
            </div>
            <form class="search-form" action="<%= contextPath %>/purchase" method="get">
                <input type="hidden" name="action" value="searchSupplier">
                <div class="search-input-wrapper">
                    <input 
                        type="text" 
                        name="supplierName" 
                        value="<%= keyword %>" 
                        placeholder="Nhập tên nhà cung cấp, địa chỉ, số điện thoại..."
                        class="search-input"
                        autofocus
                    >
                </div>
                <button type="submit" class="btn btn-primary btn-search">Tìm kiếm</button>
            </form>
        </div>

        <!-- Alert Messages -->
        <% if (flashSuccess != null) { %>
            <div class="alert alert-success"><%= flashSuccess %></div>
        <% } %>
        <% if (flashError != null) { %>
            <div class="alert alert-error"><%= flashError %></div>
        <% } %>

        <!-- Results Table -->
        <% if (suppliers != null && !suppliers.isEmpty()) { %>
        <div class="results-card">
            <div class="results-header">
                <h3>Kết quả tìm kiếm</h3>
                <div class="results-count">Tìm thấy <%= suppliers.size() %> nhà cung cấp</div>
            </div>
            <div class="table-container">
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
                            <td class="td-email"><%= supplier.getEmail() %></td>
                            <td class="td-actions">
                                <a 
                                    href="<%= contextPath %>/purchase?action=selectSupplier&id=<%= supplier.getId() %>" 
                                    class="btn btn-primary btn-select"
                                >
                                    Chọn
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } else if (suppliers != null) { %>
        <div class="results-card">
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <div class="empty-title">Không tìm thấy kết quả</div>
                <div class="empty-message">
                    Không có nhà cung cấp nào phù hợp với từ khóa "<%= keyword %>". 
                    Vui lòng thử lại với từ khóa khác hoặc thêm nhà cung cấp mới.
                </div>
            </div>
        </div>
        <% } %>
    </main>
</body>
</html>

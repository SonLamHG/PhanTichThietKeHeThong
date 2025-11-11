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
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Hệ thống quản lý</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --primary-light: #dbeafe;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --text-muted: #9ca3af;
            --border: #e5e7eb;
            --bg-primary: #ffffff;
            --bg-secondary: #f9fafb;
            --bg-hover: #f3f4f6;
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
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
        
        /* Header */
        .header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            box-shadow: var(--shadow-lg);
        }
        
        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .header-left h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 4px;
        }
        
        .header-left p {
            opacity: 0.9;
            font-size: 14px;
        }
        
        .header-right {
            display: flex;
            gap: 12px;
        }
        
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
        
        .btn-white {
            background: white;
            color: var(--primary);
        }
        
        .btn-white:hover {
            background: var(--bg-secondary);
            transform: translateY(-1px);
        }
        
        .btn-transparent {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn-transparent:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 24px;
        }
        
        /* Quick Actions */
        .quick-actions {
            display: flex;
            gap: 12px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: var(--shadow);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background: var(--bg-primary);
            color: var(--text-primary);
            border: 1px solid var(--border);
        }
        
        .btn-secondary:hover {
            background: var(--bg-hover);
        }
        
        /* Cards Grid */
        .section-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 20px;
        }
        
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
        }
        
        .card {
            background: var(--bg-primary);
            border-radius: 12px;
            padding: 28px;
            text-decoration: none;
            color: inherit;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--primary-dark));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
        
        .card:hover::before {
            transform: scaleX(1);
        }
        
        .card-icon {
            width: 56px;
            height: 56px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 20px;
            background: var(--primary-light);
        }
        
        .card:nth-child(2) .card-icon {
            background: #d1fae5;
        }
        
        .card:nth-child(3) .card-icon {
            background: #fef3c7;
        }
        
        .card-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }
        
        .card-description {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.6;
        }
        
        .card-arrow {
            margin-top: 16px;
            color: var(--primary);
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        
        .card:hover .card-arrow {
            gap: 8px;
        }
        
        /* Stats Section */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: var(--bg-primary);
            padding: 24px;
            border-radius: 12px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }
        
        .stat-label {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 8px;
        }
        
        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--text-primary);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }
            
            .header-right {
                width: 100%;
            }
            
            .container {
                padding: 24px 16px;
            }
            
            .cards-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <div class="header-left">
                <h1>👋 Xin chào, <%= user.getName() %>!</h1>
                <p>Chào mừng bạn trở lại hệ thống quản lý</p>
            </div>
            <div class="header-right">
                <a href="<%= contextPath %>/purchase" class="btn btn-white">📦 Tạo phiếu nhập</a>
                <a href="<%= contextPath %>/logout" class="btn btn-transparent">Đăng xuất</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container">
        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="<%= contextPath %>/purchase" class="btn btn-primary">🚀 Bắt đầu lập phiếu nhập</a>
            <a href="<%= contextPath %>/purchase?action=supplierSearch" class="btn btn-secondary">🏢 Xem nhà cung cấp</a>
            <a href="<%= contextPath %>/purchase?action=productSearch" class="btn btn-secondary">📦 Xem sản phẩm</a>
        </div>

        <!-- Main Features -->
        <h2 class="section-title">Chức năng chính</h2>
        <div class="cards-grid">
            <a href="<%= contextPath %>/purchase" class="card">
                <div class="card-icon">📋</div>
                <h3 class="card-title">Quản lý nhập hàng</h3>
                <p class="card-description">
                    Lập phiếu nhập hàng, chọn nhà cung cấp và kiểm soát hàng hóa một cách hiệu quả.
                </p>
                <div class="card-arrow">Bắt đầu →</div>
            </a>
            
            <a href="<%= contextPath %>/purchase?action=supplierSearch" class="card">
                <div class="card-icon">🏢</div>
                <h3 class="card-title">Nhà cung cấp</h3>
                <p class="card-description">
                    Tra cứu, quản lý thông tin nhà cung cấp và cập nhật dữ liệu liên hệ.
                </p>
                <div class="card-arrow">Xem chi tiết →</div>
            </a>
            
            <a href="<%= contextPath %>/purchase?action=productSearch" class="card">
                <div class="card-icon">📦</div>
                <h3 class="card-title">Sản phẩm</h3>
                <p class="card-description">
                    Kiểm tra danh mục sản phẩm, bổ sung và cập nhật thông tin chi tiết.
                </p>
                <div class="card-arrow">Khám phá →</div>
            </a>
        </div>
    </main>
</body>
</html>

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
    <title>Thêm sản phẩm - Hệ thống quản lý</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --primary-light: #dbeafe;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --border: #e5e7eb;
            --bg-primary: #ffffff;
            --bg-secondary: #f9fafb;
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
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
            max-width: 900px;
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
            font-size: 18px;
        }
        
        .header-title h1 {
            font-size: 20px;
            font-weight: 700;
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            background: var(--bg-secondary);
            color: var(--text-primary);
            border: 1px solid var(--border);
            transition: all 0.2s ease;
        }
        
        .btn-back:hover {
            background: var(--bg-primary);
        }
        
        /* Form Container */
        .form-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 24px;
        }
        
        .form-card {
            background: var(--bg-primary);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 32px;
        }
        
        .form-header {
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--bg-secondary);
        }
        
        .form-header h2 {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        
        .form-header p {
            font-size: 14px;
            color: var(--text-secondary);
        }
        
        /* Form */
        form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        label {
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
            color: var(--text-primary);
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            opacity: 0.5;
        }
        
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px 16px 12px 48px;
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.2s ease;
            background: var(--bg-secondary);
        }
        
        input:focus {
            outline: none;
            border-color: var(--primary);
            background: var(--bg-primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }
        
        /* Form Actions */
        .form-actions {
            grid-column: 1 / -1;
            display: flex;
            gap: 12px;
            margin-top: 12px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }
        
        .btn-submit {
            flex: 1;
            padding: 14px 24px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }
        
        .btn-cancel {
            padding: 14px 24px;
            background: var(--bg-secondary);
            color: var(--text-primary);
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }
        
        .btn-cancel:hover {
            background: var(--bg-primary);
            border-color: var(--text-secondary);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            form {
                grid-template-columns: 1fr;
            }
            
            .form-card {
                padding: 24px 20px;
            }
            
            .form-actions {
                flex-direction: column-reverse;
            }
            
            .btn-submit,
            .btn-cancel {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <div class="header-title">
                <div class="header-icon">📦</div>
                <h1>Thêm sản phẩm</h1>
            </div>
            <a href="<%= contextPath %>/purchase?action=productSearch" class="btn-back">
                ← Quay lại
            </a>
        </div>
    </header>

    <main class="form-container">
        <div class="form-card">
            <div class="form-header">
                <h2>Thông tin sản phẩm</h2>
                <p>Điền đầy đủ thông tin sản phẩm mới</p>
            </div>
            
            <form action="<%= contextPath %>/purchase" method="post">
                <input type="hidden" name="action" value="addNewProduct">
                
                <div class="form-group full-width">
                    <label for="name">Tên sản phẩm *</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📦</span>
                        <input 
                            id="name" 
                            type="text" 
                            name="name" 
                            placeholder="Nhập tên sản phẩm"
                            required
                            autofocus
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="price">Đơn giá (VNĐ) *</label>
                    <div class="input-wrapper">
                        <span class="input-icon">💰</span>
                        <input 
                            id="price" 
                            type="number" 
                            step="0.01" 
                            min="0" 
                            name="price" 
                            placeholder="0"
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="unit">Đơn vị tính *</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📏</span>
                        <input 
                            id="unit" 
                            type="text" 
                            name="unit" 
                            placeholder="Cái, Kg, Hộp, ..."
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="brand">Thương hiệu</label>
                    <div class="input-wrapper">
                        <span class="input-icon">🏷️</span>
                        <input 
                            id="brand" 
                            type="text" 
                            name="brand" 
                            placeholder="Nhập tên thương hiệu"
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="category">Danh mục</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📂</span>
                        <input 
                            id="category" 
                            type="text" 
                            name="category" 
                            placeholder="Nhập danh mục"
                        >
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="<%= contextPath %>/purchase?action=productSearch" class="btn-cancel">
                        Hủy bỏ
                    </a>
                    <button type="submit" class="btn-submit">
                        ✅ Lưu sản phẩm
                    </button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>

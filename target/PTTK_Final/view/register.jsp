<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMsg = (String) request.getAttribute("error");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Hệ thống quản lý</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            width: 600px;
            height: 600px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -300px;
            right: -300px;
        }
        
        body::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            bottom: -200px;
            left: -200px;
        }
        
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 640px;
            position: relative;
            z-index: 1;
            overflow: hidden;
        }
        
        .register-header {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            padding: 40px;
            text-align: center;
            color: white;
        }
        
        .register-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 20px;
            backdrop-filter: blur(10px);
        }
        
        .register-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        
        .register-header p {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .register-body {
            padding: 40px;
        }
        
        .alert {
            background: #fee2e2;
            color: #991b1b;
            padding: 14px 18px;
            border-radius: 10px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideDown 0.3s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert::before {
            content: '⚠️';
            font-size: 18px;
        }
        
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
            color: #1f2937;
            margin-bottom: 8px;
            font-size: 14px;
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
        input[type="password"],
        input[type="email"],
        input[type="date"] {
            width: 100%;
            padding: 14px 16px 14px 48px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.2s ease;
            background: #f9fafb;
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: #10b981;
            background: white;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }
        
        .btn-register {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4);
            grid-column: 1 / -1;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
        }
        
        .btn-register:active {
            transform: translateY(0);
        }
        
        .register-footer {
            margin-top: 24px;
            text-align: center;
            padding-top: 24px;
            border-top: 1px solid #e5e7eb;
            color: #6b7280;
            font-size: 14px;
            grid-column: 1 / -1;
        }
        
        .register-footer a {
            color: #10b981;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s ease;
        }
        
        .register-footer a:hover {
            color: #059669;
            text-decoration: underline;
        }
        
        @media (max-width: 640px) {
            form {
                grid-template-columns: 1fr;
            }
            
            .register-header,
            .register-body {
                padding: 30px 24px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <div class="register-icon">📝</div>
            <h1>Đăng ký tài khoản</h1>
            <p>Điền thông tin để tham gia hệ thống</p>
        </div>
        
        <div class="register-body">
            <% if (errorMsg != null) { %>
                <div class="alert"><%= errorMsg %></div>
            <% } %>
            
            <form action="<%= contextPath %>/register" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <div class="input-wrapper">
                        <span class="input-icon">👤</span>
                        <input 
                            id="username" 
                            type="text" 
                            name="username" 
                            placeholder="Tên đăng nhập"
                            required
                            autofocus
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="input-wrapper">
                        <span class="input-icon">🔒</span>
                        <input 
                            id="password" 
                            type="password" 
                            name="password" 
                            placeholder="Mật khẩu"
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="name">Họ và tên</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📛</span>
                        <input 
                            id="name" 
                            type="text" 
                            name="name" 
                            placeholder="Họ và tên đầy đủ"
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="dob">Ngày sinh</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📅</span>
                        <input 
                            id="dob" 
                            type="date" 
                            name="dob" 
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📞</span>
                        <input 
                            id="phone" 
                            type="text" 
                            name="phone" 
                            placeholder="Số điện thoại"
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="address">Địa chỉ</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📍</span>
                        <input 
                            id="address" 
                            type="text" 
                            name="address" 
                            placeholder="Địa chỉ chi tiết"
                            required
                        >
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="email">Email</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📧</span>
                        <input 
                            id="email" 
                            type="email" 
                            name="email" 
                            placeholder="email@example.com"
                            required
                        >
                    </div>
                </div>
                
                <button type="submit" class="btn-register">Đăng ký ngay</button>
                
                <div class="register-footer">
                    Đã có tài khoản? 
                    <a href="<%= contextPath %>/view/login.jsp">Đăng nhập ngay</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>

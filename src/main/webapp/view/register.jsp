<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMsg = (String) request.getAttribute("error");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký thành viên</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0f172a;
        }
        .card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 30px 60px rgba(15, 23, 42, 0.25);
            padding: 48px 56px;
            width: 100%;
            max-width: 560px;
        }
        h1 {
            margin: 0 0 12px;
            font-size: 28px;
            text-align: center;
        }
        p.subtitle {
            margin: 0 0 24px;
            text-align: center;
            color: #64748b;
        }
        form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 18px 24px;
        }
        .full {
            grid-column: 1 / -1;
        }
        label {
            display: block;
            font-weight: 600;
            color: #1f2a44;
            margin-bottom: 6px;
        }
        input[type="text"], input[type="password"], input[type="date"], input[type="email"] {
            width: 100%;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid #cbd5f5;
            font-size: 15px;
        }
        button {
            width: 100%;
            padding: 12px 18px;
            border-radius: 999px;
            border: none;
            background: #16a34a;
            color: #ffffff;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        button:hover {
            background: #15803d;
        }
        .footer {
            margin-top: 24px;
            text-align: center;
            color: #475569;
        }
        .footer a {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }
        .footer a:hover {
            text-decoration: underline;
        }
        .alert {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px 16px;
            border-radius: 12px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="card">
    <h1>Đăng ký tài khoản</h1>
    <p class="subtitle">Điền đầy đủ thông tin bên dưới để tham gia hệ thống</p>

    <% if (errorMsg != null) { %>
        <div class="alert"><%= errorMsg %></div>
    <% } %>

    <form action="<%= contextPath %>/register" method="post">
        <div>
            <label for="username">Tên đăng nhập</label>
            <input id="username" type="text" name="username" required>
        </div>
        <div>
            <label for="password">Mật khẩu</label>
            <input id="password" type="password" name="password" required>
        </div>
        <div class="full">
            <label for="name">Họ và tên</label>
            <input id="name" type="text" name="name" required>
        </div>
        <div>
            <label for="dob">Ngày sinh</label>
            <input id="dob" type="date" name="dob" required>
        </div>
        <div>
            <label for="phone">Số điện thoại</label>
            <input id="phone" type="text" name="phone" required>
        </div>
        <div class="full">
            <label for="address">Địa chỉ</label>
            <input id="address" type="text" name="address" required>
        </div>
        <div class="full">
            <label for="email">Email</label>
            <input id="email" type="email" name="email" required>
        </div>
        <div class="full">
            <button type="submit">Đăng ký</button>
        </div>
    </form>

    <div class="footer">
        Đã có tài khoản? <a href="<%= contextPath %>/view/login.jsp">Đăng nhập ngay</a>
    </div>
</div>
</body>
</html>

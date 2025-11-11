<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMsg = (String) request.getAttribute("error");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #0ea5e9 0%, #2563eb 100%);
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
            max-width: 420px;
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
        label {
            font-weight: 600;
            color: #1f2a44;
            display: block;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid #cbd5f5;
            margin-bottom: 18px;
            font-size: 15px;
        }
        button {
            width: 100%;
            padding: 12px 18px;
            border-radius: 999px;
            border: none;
            background: #2563eb;
            color: #ffffff;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        button:hover {
            background: #1d4ed8;
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
    <h1>Đăng nhập</h1>
    <p class="subtitle">Quản lý hệ thống bán hàng online</p>

    <% if (errorMsg != null) { %>
        <div class="alert"><%= errorMsg %></div>
    <% } %>

    <form action="<%= contextPath %>/login" method="post">
        <label for="username">Tên đăng nhập</label>
        <input id="username" type="text" name="username" required>

        <label for="password">Mật khẩu</label>
        <input id="password" type="password" name="password" required>

        <button type="submit">Đăng nhập</button>
    </form>

    <div class="footer">
        Chưa có tài khoản? <a href="<%= contextPath %>/view/register.jsp">Đăng ký ngay</a>
    </div>
</div>
</body>
</html>

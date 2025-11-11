# HƯỚNG DẪN DEBUG LỖI ERR_INCOMPLETE_CHUNKED_ENCODING

## ✅ CÁC FIX ĐÃ ÁP DỤNG:

1. **ProductDAO.java**: 
   - Try-with-resources cho tất cả database operations
   - Better error logging

2. **DAO.java**:
   - Auto-reconnect database nếu connection bị đóng
   - Connection validation

3. **PurchaseServlet.java**:
   - Try-catch cho handleProductSearch và preloadProducts
   - Fallback empty list nếu có lỗi

4. **productSearch.jsp**:
   - Buffer size 16KB
   - Try-catch toàn bộ page
   - Null safety
   - Loại bỏ hàm escapeHtml() gây lỗi

## 🔍 CÁCH TEST:

### Bước 1: Restart Tomcat Server
```
Dừng và khởi động lại Tomcat để load code mới
```

### Bước 2: Test với servlet đơn giản
```
URL: http://localhost:8080/test-products
```
✅ Nếu THÀNH CÔNG → Vấn đề ở JSP phức tạp
❌ Nếu BỊ LỖI → Vấn đề ở Database/DAO

### Bước 3: Test với JSP đơn giản
```
URL: http://localhost:8080/view/test-product-simple.jsp
```

### Bước 4: Kiểm tra Console Log
Tìm trong Tomcat logs:
- "Database connection established successfully"
- "Error in searchProduct:"
- Bất kỳ stack trace nào

### Bước 5: Test database connection
Chạy file test-database.sql trong MySQL để kiểm tra:
- Table tồn tại
- Có dữ liệu
- Columns đúng

## 🐛 CÁC NGUYÊN NHÂN PHỔ BIẾN:

1. **Database Connection Issues**
   - MySQL server không chạy
   - Sai password (hiện tại: "12345")
   - Port 3306 bị chặn
   - Database "pttk_final" không tồn tại

2. **Data Issues**
   - Column null trong database
   - Encoding UTF-8 không đúng
   - Data quá lớn

3. **Server Issues**
   - Tomcat chưa được restart
   - Code chưa được compile
   - .class files cũ trong target/

4. **JSP Compilation Issues**
   - Syntax error trong JSP
   - Missing imports
   - Methods không tồn tại

## 💡 GIẢI PHÁP KHẨN CẤP:

### Solution 1: Xóa work directory của Tomcat
```powershell
# Trong thư mục Tomcat
Remove-Item -Recurse -Force work/*
```

### Solution 2: Clear target và rebuild
```powershell
cd d:\code\Visual_Project\PTTK_Final
Remove-Item -Recurse -Force target
mvn clean package
```

### Solution 3: Kiểm tra MySQL connection
```powershell
mysql -u root -p12345 -e "USE pttk_final; SELECT COUNT(*) FROM tblProduct;"
```

### Solution 4: Nếu vẫn lỗi, simplify JSP
Tạm thời comment phần table trong productSearch.jsp và chỉ hiển thị:
```jsp
<p>Found <%= products.size() %> products</p>
```

## 📝 THÔNG TIN CUNG CẤP KHI BÁO LỖI:

Nếu vẫn bị lỗi, hãy cung cấp:
1. Log từ Tomcat console (toàn bộ stack trace)
2. Kết quả của test-products servlet
3. Kết quả của test-product-simple.jsp
4. Kết quả query: SELECT COUNT(*) FROM tblProduct
5. Version của Tomcat, MySQL, JDK

## 🎯 NEXT STEPS:

1. **Restart Tomcat** (BẮT BUỘC!)
2. **Test http://localhost:8080/test-products**
3. **Kiểm tra console log**
4. **Báo kết quả để tôi giúp thêm**

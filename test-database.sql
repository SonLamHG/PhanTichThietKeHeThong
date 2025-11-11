-- Test query để kiểm tra database connection
-- Chạy trong MySQL Workbench hoặc command line

USE pttk_final;

-- Kiểm tra table tồn tại
SHOW TABLES LIKE 'tblProduct';

-- Kiểm tra dữ liệu
SELECT COUNT(*) as total_products FROM tblProduct;

-- Lấy vài sản phẩm mẫu
SELECT * FROM tblProduct LIMIT 5;

-- Kiểm tra columns
DESCRIBE tblProduct;

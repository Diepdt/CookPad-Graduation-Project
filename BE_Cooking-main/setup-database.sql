-- =====================================================
-- SCRIPT TẠO DATABASE CHO DỰ ÁN COOKPAD
-- Chạy script này trong MySQL Workbench hoặc command line
-- =====================================================

-- 1. Tạo database
CREATE DATABASE IF NOT EXISTS cooking_db 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

-- 2. Sử dụng database
USE cooking_db;

-- =====================================================
-- LƯU Ý: Các bảng sẽ được TỰ ĐỘNG tạo bởi Hibernate
-- khi chạy Spring Boot (ddl-auto: update)
-- 
-- Script này chỉ tạo database rỗng.
-- Spring Boot sẽ tự động:
--   - Tạo tất cả các bảng từ Entity classes
--   - Tạo các foreign key constraints
--   - Tạo admin user mặc định
-- =====================================================

-- 3. (Tùy chọn) Kiểm tra database đã tạo thành công
SHOW DATABASES LIKE 'cooking_db';

-- 4. (Tùy chọn) Tạo user riêng cho ứng dụng (bảo mật hơn)
-- CREATE USER 'cooking_app'@'localhost' IDENTIFIED BY 'your_secure_password';
-- GRANT ALL PRIVILEGES ON cooking_db.* TO 'cooking_app'@'localhost';
-- FLUSH PRIVILEGES;

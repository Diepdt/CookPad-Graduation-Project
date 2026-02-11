# =====================================================
# HƯỚNG DẪN CHẠY DỰ ÁN COOKPAD
# =====================================================

## 📋 YÊU CẦU HỆ THỐNG

### Bắt buộc:
- **MySQL 8.0+** (đang chạy trên port 3306)
- **Java 21** (JDK)
- **Node.js 18+**
- **pnpm** (package manager)

### Tùy chọn (cho AI features):
- GROQ API Key (miễn phí tại https://console.groq.com)
- Pinecone API Key (miễn phí tại https://www.pinecone.io)

---

## 🚀 CÁC BƯỚC CHẠY DỰ ÁN

### BƯỚC 1: Tạo Database MySQL

**Cách 1: Dùng MySQL Command Line**
```bash
mysql -u root -p
```
Sau đó chạy:
```sql
CREATE DATABASE cooking_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

**Cách 2: Dùng MySQL Workbench**
- Mở MySQL Workbench
- Kết nối đến localhost
- Chạy file `BE_Cooking-main/setup-database.sql`

**Cách 3: Dùng script có sẵn**
```bash
mysql -u root -p < BE_Cooking-main/setup-database.sql
```

---

### BƯỚC 2: Cấu hình Backend (nếu cần)

Mở file `BE_Cooking-main/cooking/src/main/resources/application.yml`

Kiểm tra cấu hình database:
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/cooking_db
    username: root
    password:           # ← Thêm password MySQL của bạn nếu có
```

**Nếu MySQL của bạn có password**, sửa dòng `password:` thành:
```yaml
    password: your_mysql_password
```

---

### BƯỚC 3: Chạy Backend (Spring Boot)

Mở Terminal 1:
```bash
cd BE_Cooking-main/cooking
mvn spring-boot:run
```

**Lần đầu chạy:**
- Maven sẽ tải dependencies (có thể mất vài phút)
- Hibernate sẽ TỰ ĐỘNG tạo tất cả các bảng trong database
- Tài khoản Admin mặc định sẽ được tạo:
  - Username: `admin`
  - Password: `admin12345`

**Khi thấy dòng sau là thành công:**
```
Started CookingApplication in X.XXX seconds
```

**Kiểm tra:** Mở trình duyệt → http://localhost:8080/swagger-ui/index.html

---

### BƯỚC 4: Chạy Frontend (Next.js)

Mở Terminal 2 (giữ Terminal 1 đang chạy BE):

```bash
cd FE_Cooking-main

# Cài đặt pnpm nếu chưa có
npm install -g pnpm

# Cài đặt dependencies
pnpm install

# Chạy development server
pnpm dev
```

**Khi thấy dòng sau là thành công:**
```
▲ Next.js 16.x.x
- Local: http://localhost:3000
```

**Mở trình duyệt:** http://localhost:3000

---

## ✅ KIỂM TRA HỆ THỐNG

| Thành phần | URL | Trạng thái |
|------------|-----|------------|
| Frontend | http://localhost:3000 | Giao diện web |
| Backend API | http://localhost:8080 | API Server |
| Swagger Docs | http://localhost:8080/swagger-ui/index.html | API Documentation |

---

## 🔐 TÀI KHOẢN MẶC ĐỊNH

| Role | Username | Password |
|------|----------|----------|
| Admin | `admin` | `admin12345` |

---

## ⚠️ XỬ LÝ LỖI THƯỜNG GẶP

### 1. Lỗi "Communications link failure" (MySQL không kết nối được)
- Kiểm tra MySQL đang chạy: `mysql -u root -p`
- Kiểm tra port 3306 không bị chặn

### 2. Lỗi "Access denied for user 'root'"
- Sửa password trong `application.yml`

### 3. Lỗi "Unknown database 'cooking_db'"
- Chạy lại Bước 1 để tạo database

### 4. Lỗi "NEXT_PUBLIC_API_HOST is undefined"
- Kiểm tra file `.env.local` trong thư mục `FE_Cooking-main`
- Restart frontend: `pnpm dev`

### 5. Lỗi Maven "JAVA_HOME not set"
- Cài đặt Java 21 JDK
- Thiết lập biến môi trường JAVA_HOME

---

## 📁 CẤU TRÚC DỰ ÁN

```
Website chia sẻ công thức nấu ăn/
├── BE_Cooking-main/          # Backend (Java Spring Boot)
│   ├── cooking/              # Source code chính
│   │   ├── src/
│   │   └── pom.xml           # Maven config
│   └── setup-database.sql    # Script tạo database
│
├── FE_Cooking-main/          # Frontend (Next.js)
│   ├── app/                  # Pages & routes
│   ├── components/           # React components
│   ├── .env.local            # Environment config
│   └── package.json          # Dependencies
│
└── README.md                 # Mô tả dự án
```

---

## 🎉 HOÀN THÀNH!

Sau khi chạy cả BE và FE, bạn có thể:
- Đăng ký tài khoản mới
- Đăng nhập với tài khoản admin
- Tạo và xem công thức nấu ăn
- Sử dụng các tính năng khác của hệ thống

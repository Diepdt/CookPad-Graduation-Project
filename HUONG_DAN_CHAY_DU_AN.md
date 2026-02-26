# HUONG DAN CHAY DU AN COOKPAD

## YEU CAU HE THONG

### Bat buoc:
- **MySQL 8.0+** (dang chay tren port 3306)
- **Java 21** (JDK)
- **Node.js 18+**
- **npm** hoac **pnpm** (package manager)

### Tuy chon (cho AI features):
- GROQ API Key (mien phi tai https://console.groq.com)

---

## CAC BUOC CHAY DU AN

### BUOC 1: Tao Database MySQL

**Cach 1: Dung MySQL Command Line**
```bash
mysql -u root -p
```
Sau do chay:
```sql
CREATE DATABASE cooking_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

**Cach 2: Dung MySQL Workbench**
- Mo MySQL Workbench
- Ket noi den localhost
- Chay file `BE_Cooking-main/setup-database.sql`

---

### BUOC 2: Cau hinh Backend (neu can)

Mo file `BE_Cooking-main/cooking/src/main/resources/application.yml`

Kiem tra cau hinh database:
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/cooking_db
    username: root
    password: 123456    # Doi thanh password MySQL cua ban
```

---

### BUOC 3: Chay Backend (Spring Boot)

Mo Terminal 1:

**Tren Windows (dung Maven Wrapper - KHUYEN NGHI):**
```powershell
cd BE_Cooking-main/cooking
.\mvnw.cmd spring-boot:run
```

**Tren macOS/Linux:**
```bash
cd BE_Cooking-main/cooking
./mvnw spring-boot:run
```

**Neu da cai Maven toan cuc:**
```bash
cd BE_Cooking-main/cooking
mvn spring-boot:run
```

**Lan dau chay:**
- Maven se tai dependencies (co the mat vai phut)
- Hibernate se TU DONG tao tat ca cac bang trong database
- Tai khoan Admin mac dinh se duoc tao:
  - Username: `admin`
  - Password: `admin12345`

**Khi thay dong sau la thanh cong:**
```
Started CookingApplication in X.XXX seconds
```

**Kiem tra:** Mo trinh duyet -> http://localhost:8080/swagger-ui/index.html

---

### BUOC 4: Chay Frontend (Next.js)

Mo Terminal 2 (giu Terminal 1 dang chay BE):

**Dung npm:**
```bash
cd FE_Cooking-main
npm install
npm run dev
```

**Hoac dung pnpm:**
```bash
cd FE_Cooking-main
npm install -g pnpm
pnpm install
pnpm dev
```

**Khi thay dong sau la thanh cong:**
```
Next.js 16.x.x
- Local: http://localhost:3000
```

**Mo trinh duyet:** http://localhost:3000

---

## KIEM TRA HE THONG

| Thanh phan | URL | Trang thai |
|------------|-----|------------|
| Frontend | http://localhost:3000 | Giao dien web |
| Backend API | http://localhost:8080 | API Server |
| Swagger Docs | http://localhost:8080/swagger-ui/index.html | API Documentation |

---

## TAI KHOAN MAC DINH

| Role | Username | Password |
|------|----------|----------|
| Admin | `admin` | `admin12345` |

---

## XU LY LOI THUONG GAP

### 1. Loi "'mvn' is not recognized" (Windows)
- **Giai phap:** Dung Maven Wrapper: `.\mvnw.cmd spring-boot:run`

### 2. Loi "Communications link failure" (MySQL khong ket noi duoc)
- Kiem tra MySQL dang chay: `mysql -u root -p`
- Kiem tra port 3306 khong bi chan

### 3. Loi "Access denied for user 'root'"
- Sua password trong `application.yml` cho dung voi MySQL cua ban

### 4. Loi "Unknown database 'cooking_db'"
- Chay lai Buoc 1 de tao database

### 5. Loi Maven "JAVA_HOME not set"
- Cai dat Java 21 JDK
- Thiet lap bien moi truong JAVA_HOME

---

## CAU TRUC DU AN

```
source_code/
|-- BE_Cooking-main/          # Backend (Java Spring Boot 3.5.6)
|   |-- cooking/              # Source code chinh
|   |   |-- src/
|   |   |-- mvnw.cmd          # Maven Wrapper (Windows)
|   |   |-- mvnw              # Maven Wrapper (Unix)
|   |   +-- pom.xml           # Maven config (Java 21)
|   +-- setup-database.sql    # Script tao database
|
|-- FE_Cooking-main/          # Frontend (Next.js 16)
|   |-- app/                  # Pages & routes
|   |-- components/           # React components
|   +-- package.json          # Dependencies
|
+-- README.md                 # Mo ta du an
```

---

## HOAN THANH!

Sau khi chay ca BE va FE, ban co the:
- Dang ky tai khoan moi
- Dang nhap voi tai khoan admin
- Tao va xem cong thuc nau an
- Su dung cac tinh nang khac cua he thong

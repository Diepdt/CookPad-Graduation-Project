# CookPad - Nen tang Chia se Cong thuc Nau an & Goi y AI

CookPad la he thong da nen tang (Web & Mobile App) cho phep nguoi dung chia se cong thuc nau an, ket noi cong dong yeu bep, va dac biet ho tro goi y mon an thong minh dua tren nguyen lieu co san su dung cong nghe AI (RAG).

---

## Cong nghe su dung (Tech Stack)

Du an duoc xay dung theo mo hinh Client-Server voi cac cong nghe hien dai:

### Backend (Server):
- **Java Spring Boot 3.5.6** (Core Framework)
- **Spring AI** (Tich hop AI)
- **MySQL 8.0** (Database)
- **GROQ API** (LLM cho AI Chat)
- **VNPay / Momo** (Cong thanh toan)
- **JWT** (Xac thuc bao mat)

### Frontend (Website):
- **Next.js 16** (React Framework)
- **TypeScript**
- **Tailwind CSS** (Styling)
- **Zustand** (State Management)
- **TanStack Query** (Data fetching)

---

## Cac Actor (Tac nhan) trong he thong

He thong duoc thiet ke voi 3 nhom nguoi dung chinh:

### 1. Nguoi dung thuong (User / Foodie)
La nguoi tham gia nen tang de tim kiem cam hung nau an hoac dat mon.

- Tim kiem cong thuc (theo ten, nguyen lieu, tag).
- Su dung AI: Chatbot hoi dap, goi y mon an tu hinh anh hoac danh sach nguyen lieu.
- Tuong tac: Like, Comment, Luu cong thuc vao bo suu tap (Collection).
- Theo doi (Follow) cac dau bep khac.
- Dat mua mon an (Order) tu cac dau bep ban hang.

### 2. Dau bep (Chef / Seller)
La nguoi dung da thuc hien nang cap tai khoan (Upgrade Package) de mo khoa tinh nang chia se va kinh doanh.

- Toan bo quyen cua User.
- Dang tai va quan ly cong thuc nau an (Recipe).
- Tao mon an (Dish) de ban dua tren cong thuc.
- Quan ly gian hang, quan ly don hang (Order Management).
- Quan ly vi tien (Seller Wallet) va rut tien doanh thu.

### 3. Quan tri vien (Admin)
Nguoi van hanh he thong.

- Quan ly nguoi dung (User/Chef).
- Duyet yeu cau nang cap len Dau bep (Chef Request).
- Quan ly noi dung (Cong thuc, Bai dang) de dam bao tieu chuan cong dong.
- Xem thong ke he thong (Doanh thu, luong truy cap).

---

## Cac nghiep vu chinh (Business Processes)

### 1. Nghiep vu Cong thuc & Cong dong (Core Features)
- **Quan ly cong thuc (CRUD):** Dau bep co the tao cong thuc voi chi tiet tung buoc (Step), nguyen lieu (Ingredients), hinh anh/video minh hoa.
- **Tuong tac xa hoi:** Nguoi dung co the tha tim, binh luan, va theo doi (Follow) nguoi tao noi dung. He thong co co che thong bao (Notification) khi co tuong tac moi.
- **Bo suu tap (Collection):** Nguoi dung tao cac bo suu tap ca nhan (vi du: `Mon an sang`, `Mon chay`) de luu tru cong thuc yeu thich.

### 2. Nghiep vu Goi y thong minh (AI Features)
- **Search by Ingredients (RAG):** Nguoi dung nhap danh sach nguyen lieu dang co trong tu lanh -> He thong su dung Vector Search ket hop Spring AI de goi y cac mon an phu hop nhat.
- **Food Chatbot:** Tro ly ao tra loi cac cau hoi ve dinh duong, cach nau an.
- **Image Recognition:** Nguoi dung chup anh nguyen lieu -> AI nhan dien va de xuat cong thuc.

### 3. Nghiep vu Thuong mai dien tu (E-commerce)
- **Nau ho (Ordering):** Nguoi dung co the dat mon an truc tiep tu Dau bep (neu Dau bep co mo ban mon do).
- **Gio hang & Thanh toan:**
  - Them mon vao gio hang.
  - Thanh toan tich hop cong VNPay hoac Momo.
  - Quy trinh don hang: Dat hang -> Cho xac nhan -> Dang nau -> Dang giao -> Hoan thanh.

### 4. Nghiep vu Tai chinh & Nang cap
- **Nang cap tai khoan:** Nguoi dung mua goi Premium/Chef de mo khoa tinh nang dang bai va ban hang.
- **Vi dien tu (Wallet):**
  - Quan ly dong tien vao (tu don hang ban duoc).
  - Yeu cau rut tien (Withdraw Request) ve tai khoan ngan hang.

---

## Cau truc du an

```
source_code/
|-- BE_Cooking-main/          # Backend (Java Spring Boot 3.5.6)
|   |-- cooking/
|   |   |-- src/main/java/    # Source code chinh
|   |   |-- mvnw.cmd          # Maven Wrapper (Windows)
|   |   +-- pom.xml           # Maven config (Java 21)
|   +-- setup-database.sql    # Script tao database
|
|-- FE_Cooking-main/          # Frontend (Next.js 16)
|   |-- app/                  # Pages & routes
|   |-- components/           # React components
|   |-- api/                  # API clients
|   +-- package.json          # Dependencies
|
+-- HUONG_DAN_CHAY_DU_AN.md   # Huong dan chay du an
```

---

## Huong dan chay du an

Xem chi tiet tai file [HUONG_DAN_CHAY_DU_AN.md](HUONG_DAN_CHAY_DU_AN.md)

### Tong quan:
1. Tao database MySQL: `cooking_db`
2. Chay Backend: `cd BE_Cooking-main/cooking && .\mvnw.cmd spring-boot:run`
3. Chay Frontend: `cd FE_Cooking-main && npm install && npm run dev`

### URLs:
- Frontend: http://localhost:3000
- Backend API: http://localhost:8080
- Swagger Docs: http://localhost:8080/swagger-ui/index.html

### Tai khoan mac dinh:
- Admin: `admin` / `admin12345`

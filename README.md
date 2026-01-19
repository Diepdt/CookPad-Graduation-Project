CookPad - Nền tảng Chia sẻ Công thức Nấu ăn & Gợi ý AI
CookPad là hệ thống đa nền tảng (Web & Mobile App) cho phép người dùng chia sẻ công thức nấu ăn, kết nối cộng đồng yêu bếp, và đặc biệt hỗ trợ gợi ý món ăn thông minh dựa trên nguyên liệu có sẵn sử dụng công nghệ AI (RAG).

🚀 Công nghệ sử dụng (Tech Stack)
Dự án được xây dựng theo mô hình Client-Server với các công nghệ hiện đại:

Backend (Server):

Java Spring Boot (Core Framework)

Spring AI (Tích hợp AI)

MySQL (Database)

Pinecone (Vector Database cho RAG/AI Search)

VNPay / Momo (Cổng thanh toán)

JWT (Xác thực bảo mật)

Frontend (Website):

Next.js 16 (React Framework)

TypeScript

Tailwind CSS (Styling)

Zustand (State Management)

Mobile App:

React Native (Expo)

Expo Router

👥 Các Actor (Tác nhân) trong hệ thống
Hệ thống được thiết kế với 3 nhóm người dùng chính, mỗi nhóm có quyền hạn và chức năng riêng biệt:

1. Người dùng thường (User / Foodie)
Là người tham gia nền tảng để tìm kiếm cảm hứng nấu ăn hoặc đặt món.

Tìm kiếm công thức (theo tên, nguyên liệu, tag).

Sử dụng AI: Chatbot hỏi đáp, gợi ý món ăn từ hình ảnh hoặc danh sách nguyên liệu.

Tương tác: Like, Comment, Lưu công thức vào bộ sưu tập (Collection).

Theo dõi (Follow) các đầu bếp khác.

Đặt mua món ăn (Order) từ các đầu bếp bán hàng.

2. Đầu bếp (Chef / Seller)
Là người dùng đã thực hiện nâng cấp tài khoản (Upgrade Package) để mở khóa tính năng chia sẻ và kinh doanh.

Toàn bộ quyền của User.

Đăng tải và quản lý công thức nấu ăn (Recipe).

Tạo món ăn (Dish) để bán dựa trên công thức.

Quản lý gian hàng, quản lý đơn hàng (Order Management).

Quản lý ví tiền (Seller Wallet) và rút tiền doanh thu.

3. Quản trị viên (Admin)
Người vận hành hệ thống.

Quản lý người dùng (User/Chef).

Duyệt yêu cầu nâng cấp lên Đầu bếp (Chef Request).

Quản lý nội dung (Công thức, Bài đăng) để đảm bảo tiêu chuẩn cộng đồng.

Xem thống kê hệ thống (Doanh thu, lượng truy cập).

💼 Các nghiệp vụ chính (Business Processes)
Dưới đây là mô tả chi tiết các luồng nghiệp vụ quan trọng trong dự án:

1. Nghiệp vụ Công thức & Cộng đồng (Core Features)
Quản lý công thức (CRUD): Đầu bếp có thể tạo công thức với chi tiết từng bước (Step), nguyên liệu (Ingredients), hình ảnh/video minh họa.

Tương tác xã hội: Người dùng có thể thả tim, bình luận, và theo dõi (Follow) người tạo nội dung. Hệ thống có cơ chế thông báo (Notification) khi có tương tác mới.

Bộ sưu tập (Collection): Người dùng tạo các bộ sưu tập cá nhân (ví dụ: "Món ăn sáng", "Món chay") để lưu trữ công thức yêu thích.

2. Nghiệp vụ Gợi ý thông minh (AI Features)
Search by Ingredients (RAG): Người dùng nhập danh sách nguyên liệu đang có trong tủ lạnh -> Hệ thống sử dụng Vector Search (Pinecone) kết hợp Spring AI để gợi ý các món ăn phù hợp nhất.

Food Chatbot: Trợ lý ảo trả lời các câu hỏi về dinh dưỡng, cách nấu ăn.

Image Recognition: Người dùng chụp ảnh nguyên liệu -> AI nhận diện và đề xuất công thức.

3. Nghiệp vụ Thương mại điện tử (E-commerce)
Nấu hộ (Ordering): Người dùng có thể đặt món ăn trực tiếp từ Đầu bếp (nếu Đầu bếp có mở bán món đó).

Giỏ hàng & Thanh toán:

Thêm món vào giỏ hàng.

Thanh toán tích hợp cổng VNPay hoặc Momo.

Quy trình đơn hàng: Đặt hàng -> Chờ xác nhận -> Đang nấu -> Đang giao -> Hoàn thành.

4. Nghiệp vụ Tài chính & Nâng cấp
Nâng cấp tài khoản: Người dùng mua gói Premium/Chef để mở khóa tính năng đăng bài và bán hàng.

Ví điện tử (Wallet):

Quản lý dòng tiền vào (từ đơn hàng bán được).

Yêu cầu rút tiền (Withdraw Request) về tài khoản ngân hàng.

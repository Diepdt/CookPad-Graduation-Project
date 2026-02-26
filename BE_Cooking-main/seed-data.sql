-- =====================================================
-- SEED DATA CHO DỰ ÁN COOKPAD
-- Chạy script này SAU KHI đã khởi động Spring Boot lần đầu
-- (để Hibernate tạo các bảng trước)
-- 
-- Cách chạy: mysql -u root -p cooking_db < seed-data.sql
-- Hoặc copy nội dung vào MySQL Workbench và chạy
-- =====================================================

USE cooking_db;

-- Tắt kiểm tra foreign key tạm thời để xóa dữ liệu
SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- XÓA DỮ LIỆU CŨ (để có thể chạy lại script)
-- =====================================================
DELETE FROM comments WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung', 'foodie_an', 'foodie_mai', 'seller_nam'));
DELETE FROM user_follows WHERE follower_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung', 'foodie_an', 'foodie_mai', 'seller_nam'));
DELETE FROM collection_recipes WHERE collection_id IN (SELECT collection_id FROM collections WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('foodie_an', 'foodie_mai')));
DELETE FROM collections WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('foodie_an', 'foodie_mai'));
DELETE FROM dish WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'seller_nam'));
DELETE FROM recipe_ingredients WHERE recipe_id IN (SELECT recipe_id FROM recipes WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung')));
DELETE FROM recipe_tag WHERE recipe_id IN (SELECT recipe_id FROM recipes WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung')));
DELETE FROM recipe_category WHERE recipe_id IN (SELECT recipe_id FROM recipes WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung')));
DELETE FROM steps WHERE recipe_id IN (SELECT recipe_id FROM recipes WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung')));
DELETE FROM recipes WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung'));
DELETE FROM user_roles WHERE user_id IN (SELECT user_id FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung', 'foodie_an', 'foodie_mai', 'seller_nam'));
DELETE FROM users WHERE username IN ('chef_minh', 'chef_lan', 'chef_hung', 'foodie_an', 'foodie_mai', 'seller_nam');

-- Bật lại kiểm tra foreign key
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- 1. CATEGORIES - Danh mục món ăn
-- =====================================================
INSERT INTO categories (name, slug, description, image_url) VALUES
('Món Việt', 'mon-viet', 'Các món ăn truyền thống Việt Nam', 'https://images.unsplash.com/photo-1534422298391-e4f8c172789a?w=400'),
('Món Á', 'mon-a', 'Ẩm thực các nước châu Á', 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=400'),
('Món Âu', 'mon-au', 'Ẩm thực châu Âu', 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=400'),
('Món Chay', 'mon-chay', 'Các món ăn chay thanh đạm', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400'),
('Món Tráng Miệng', 'mon-trang-mieng', 'Bánh ngọt, chè, kem', 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=400'),
('Món Nhanh', 'mon-nhanh', 'Các món dễ làm, tiết kiệm thời gian', 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'),
('Món Canh & Súp', 'mon-canh-sup', 'Các loại canh, súp, lẩu', 'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=400'),
('Món Hải Sản', 'mon-hai-san', 'Các món từ hải sản tươi ngon', 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400'),
('Món Nhậu', 'mon-nhau', 'Món ăn kèm nhâm nhi', 'https://images.unsplash.com/photo-1555126634-323283e090fa?w=400'),
('Đồ Uống', 'do-uong', 'Nước ép, sinh tố, đồ uống', 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400')
ON DUPLICATE KEY UPDATE description = VALUES(description), image_url = VALUES(image_url);

-- =====================================================
-- 2. TAGS - Nhãn/Hashtag
-- =====================================================
INSERT INTO tags (name, slug) VALUES
('Dễ làm', 'de-lam'),
('Healthy', 'healthy'),
('Gia đình', 'gia-dinh'),
('Tiệc tùng', 'tiec-tung'),
('Ăn kiêng', 'an-kieng'),
('Đồ nướng', 'do-nuong'),
('Chiên giòn', 'chien-gion'),
('Hấp', 'hap'),
('Nước sốt đặc biệt', 'nuoc-sot-dac-biet'),
('Truyền thống', 'truyen-thong'),
('Fusion', 'fusion'),
('Ít calo', 'it-calo'),
('Giàu protein', 'giau-protein'),
('Nguyên liệu rẻ', 'nguyen-lieu-re'),
('Món nước', 'mon-nuoc')
ON DUPLICATE KEY UPDATE slug = VALUES(slug);

-- =====================================================
-- 3. INGREDIENTS - Nguyên liệu
-- =====================================================
INSERT INTO ingredients (name, normalized_name) VALUES
-- Thịt
('Thịt heo', 'thit heo'),
('Thịt bò', 'thit bo'),
('Thịt gà', 'thit ga'),
('Thịt vịt', 'thit vit'),
('Ba chỉ', 'ba chi'),
('Sườn non', 'suon non'),
('Thịt xay', 'thit xay'),
-- Hải sản
('Tôm', 'tom'),
('Cá', 'ca'),
('Mực', 'muc'),
('Cua', 'cua'),
('Nghêu', 'ngheu'),
('Ốc', 'oc'),
-- Rau củ
('Hành tây', 'hanh tay'),
('Hành lá', 'hanh la'),
('Tỏi', 'toi'),
('Gừng', 'gung'),
('Ớt', 'ot'),
('Cà chua', 'ca chua'),
('Cà rốt', 'ca rot'),
('Khoai tây', 'khoai tay'),
('Bí đỏ', 'bi do'),
('Bắp cải', 'bap cai'),
('Rau muống', 'rau muong'),
('Cải thìa', 'cai thia'),
('Đậu que', 'dau que'),
('Nấm', 'nam'),
('Giá đỗ', 'gia do'),
-- Gia vị
('Muối', 'muoi'),
('Đường', 'duong'),
('Nước mắm', 'nuoc mam'),
('Dầu ăn', 'dau an'),
('Tiêu', 'tieu'),
('Bột ngọt', 'bot ngot'),
('Hạt nêm', 'hat nem'),
('Nước tương', 'nuoc tuong'),
('Dấm', 'dam'),
('Dầu hào', 'dau hao'),
('Sa tế', 'sa te'),
-- Khác
('Trứng', 'trung'),
('Đậu phụ', 'dau phu'),
('Mì gói', 'mi goi'),
('Bún', 'bun'),
('Phở', 'pho'),
('Cơm', 'com'),
('Bột mì', 'bot mi'),
('Bột gạo', 'bot gao'),
('Sữa', 'sua'),
('Nước cốt dừa', 'nuoc cot dua')
ON DUPLICATE KEY UPDATE normalized_name = VALUES(normalized_name);

-- =====================================================
-- 4. USERS - Thêm users mẫu
-- Password: "password123" được mã hóa bằng BCrypt
-- BCrypt hash của "password123": $2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi
-- =====================================================
INSERT INTO users (username, password_hash, email, dob, bio, avatar_url, created_at, status) VALUES
('chef_minh', '$2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi', 'chef_minh@example.com', '1990-05-15', 'Đầu bếp chuyên nghiệp với 10 năm kinh nghiệm, chuyên ẩm thực Việt Nam', 'https://i.pravatar.cc/150?u=chef_minh', NOW(), 'ACTIVE'),
('chef_lan', '$2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi', 'chef_lan@example.com', '1985-08-22', 'Yêu nấu ăn và chia sẻ công thức gia truyền', 'https://i.pravatar.cc/150?u=chef_lan', NOW(), 'ACTIVE'),
('chef_hung', '$2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi', 'chef_hung@example.com', '1992-03-10', 'Chuyên gia ẩm thực Á châu, đam mê món ăn fusion', 'https://i.pravatar.cc/150?u=chef_hung', NOW(), 'ACTIVE'),
('foodie_an', '$2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi', 'foodie_an@example.com', '1998-11-30', 'Người yêu ẩm thực, thích khám phá món mới', 'https://i.pravatar.cc/150?u=foodie_an', NOW(), 'ACTIVE'),
('foodie_mai', '$2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi', 'foodie_mai@example.com', '1995-07-18', 'Mẹ bỉm sữa yêu nấu ăn cho gia đình', 'https://i.pravatar.cc/150?u=foodie_mai', NOW(), 'ACTIVE'),
('seller_nam', '$2a$10$EqKcp1WFKzJJMsGE7X1kPuZn0y8HvHNyZxSxKv6L.5YqLqGh0.lZi', 'seller_nam@example.com', '1988-02-25', 'Kinh doanh đồ ăn online, giao hàng tận nơi', 'https://i.pravatar.cc/150?u=seller_nam', NOW(), 'ACTIVE');

-- Gán roles cho users
INSERT INTO user_roles (user_id, role_id) VALUES
((SELECT user_id FROM users WHERE username = 'chef_minh'), (SELECT id FROM roles WHERE name = 'USER')),
((SELECT user_id FROM users WHERE username = 'chef_minh'), (SELECT id FROM roles WHERE name = 'CHEF')),
((SELECT user_id FROM users WHERE username = 'chef_lan'), (SELECT id FROM roles WHERE name = 'USER')),
((SELECT user_id FROM users WHERE username = 'chef_lan'), (SELECT id FROM roles WHERE name = 'CHEF')),
((SELECT user_id FROM users WHERE username = 'chef_hung'), (SELECT id FROM roles WHERE name = 'USER')),
((SELECT user_id FROM users WHERE username = 'chef_hung'), (SELECT id FROM roles WHERE name = 'CHEF')),
((SELECT user_id FROM users WHERE username = 'foodie_an'), (SELECT id FROM roles WHERE name = 'USER')),
((SELECT user_id FROM users WHERE username = 'foodie_mai'), (SELECT id FROM roles WHERE name = 'USER')),
((SELECT user_id FROM users WHERE username = 'seller_nam'), (SELECT id FROM roles WHERE name = 'USER')),
((SELECT user_id FROM users WHERE username = 'seller_nam'), (SELECT id FROM roles WHERE name = 'SELLER'));

-- =====================================================
-- 5. RECIPES - Công thức nấu ăn
-- =====================================================
INSERT INTO recipes (title, description, servings, prep_time, cook_time, difficulty, created_at, updated_at, image_url, video_url, views, status, scope, user_id) VALUES
('Phở Bò Hà Nội', 'Phở bò truyền thống Hà Nội với nước dùng trong vắt, thơm ngọt từ xương bò hầm. Món ăn tinh hoa ẩm thực Việt Nam, phù hợp cho bữa sáng hoặc khi bạn muốn thưởng thức hương vị quê hương.', 4, 60, 180, 'HARD', NOW(), NOW(), 'https://images.unsplash.com/photo-1503764654157-72d979d9af2f?w=800', NULL, 1250, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_minh')),
('Bún Chả Hà Nội', 'Bún chả Hà Nội đúng vị với thịt nướng thơm lừng, nước mắm chua ngọt hài hòa. Đây là món ăn đã chinh phục cả Tổng thống Obama khi đến Việt Nam.', 2, 30, 30, 'MEDIUM', NOW(), NOW(), 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=800', NULL, 890, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_minh')),
('Gỏi Cuốn Tôm Thịt', 'Gỏi cuốn tươi mát với tôm, thịt heo, bún và rau sống. Chấm kèm nước mắm pha hoặc tương đậu phộng. Món ăn nhẹ nhàng, giàu dinh dưỡng, phù hợp cho ngày hè.', 4, 45, 15, 'EASY', NOW(), NOW(), 'https://images.unsplash.com/photo-1562967916-eb82221dfb92?w=800', NULL, 2100, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_lan')),
('Cơm Tấm Sườn Bì Chả', 'Cơm tấm Sài Gòn đầy đủ sườn nướng, bì, chả trứng kèm mỡ hành và nước mắm đặc biệt. Bữa sáng no bụng của người Sài Gòn.', 1, 20, 45, 'MEDIUM', NOW(), NOW(), 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800', NULL, 1560, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_lan')),
('Bánh Mì Thịt Nguội', 'Bánh mì Việt Nam nổi tiếng thế giới với vỏ giòn, nhân thịt nguội, pate, rau sống và nước sốt đặc biệt. Đơn giản nhưng đầy đủ hương vị.', 2, 15, 5, 'VERY_EASY', NOW(), NOW(), 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800', NULL, 3200, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_hung')),
('Thịt Kho Tàu Trứng', 'Thịt ba chỉ kho với trứng và nước dừa, vị ngọt thơm đậm đà. Món ăn truyền thống không thể thiếu trong ngày Tết của người miền Nam.', 6, 15, 90, 'EASY', NOW(), NOW(), 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800', NULL, 1890, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_lan')),
('Canh Chua Cá Lóc', 'Canh chua đặc trưng miền Tây với cá lóc, thơm, cà chua, đậu bắp và rau thơm. Vị chua thanh, ngọt tự nhiên từ nguyên liệu tươi.', 4, 20, 30, 'EASY', NOW(), NOW(), 'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=800', NULL, 980, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_minh')),
('Bò Lúc Lắc', 'Thịt bò xào với ớt chuông, hành tây, ướp đậm đà. Món ăn thịnh soạn, dễ làm, phù hợp bữa tiệc gia đình.', 4, 20, 15, 'EASY', NOW(), NOW(), 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800', NULL, 1450, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_hung')),
('Bánh Xèo Miền Nam', 'Bánh xèo giòn rụm với nhân tôm, thịt, giá đỗ. Cuốn rau sống chấm nước mắm chua ngọt. Món ăn dân dã mà ngon tuyệt.', 4, 30, 30, 'MEDIUM', NOW(), NOW(), 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', NULL, 2340, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_lan')),
('Chả Giò Rán', 'Chả giò vàng giòn với nhân thịt, mộc nhĩ, miến. Món khai vị hấp dẫn cho mọi bữa tiệc.', 6, 45, 20, 'MEDIUM', NOW(), NOW(), 'https://images.unsplash.com/photo-1560713781-d00f6c18f388?w=800', NULL, 1670, 'APPROVED', 'PUBLIC', (SELECT user_id FROM users WHERE username = 'chef_minh'));

-- =====================================================
-- 6. STEPS - Các bước nấu ăn (cho recipe Phở bò)
-- =====================================================
INSERT INTO steps (step_number, step_time, description, recipe_id) VALUES
(1, 30, 'Rửa sạch xương bò, chần qua nước sôi để loại bỏ bọt bẩn. Rửa lại với nước lạnh.', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
(2, 15, 'Nướng hành tây, gừng trên bếp than hoặc bếp gas cho đến khi cháy đen bên ngoài, thơm mùi.', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
(3, 120, 'Cho xương vào nồi nước lớn, thêm hành tây, gừng nướng. Đun sôi rồi hạ lửa nhỏ, hầm trong 2-3 tiếng. Hớt bọt thường xuyên.', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
(4, 10, 'Thêm gia vị: muối, đường, nước mắm vào nước dùng. Nêm nếm vừa ăn.', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
(5, 5, 'Thái thịt bò thật mỏng. Chần bánh phở qua nước sôi.', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
(6, 5, 'Xếp bánh phở vào tô, đặt thịt bò lên trên; trong bao gồm hành, ngò, giá. Chan nước dùng nóng. Ăn kèm với tương ớt, tương đen và chanh.', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'));

-- Steps cho Bún chả
INSERT INTO steps (step_number, step_time, description, recipe_id) VALUES
(1, 15, 'Thịt ba chỉ thái lát mỏng, thịt xay viên thành từng miếng nhỏ. Ướp với hành tím băm, tỏi, nước mắm, đường, tiêu trong 30 phút.', (SELECT recipe_id FROM recipes WHERE title = 'Bún Chả Hà Nội')),
(2, 15, 'Nướng thịt trên bếp than hoặc chảo đến khi vàng đều, thơm lừng.', (SELECT recipe_id FROM recipes WHERE title = 'Bún Chả Hà Nội')),
(3, 10, 'Pha nước mắm: 3 muỗng nước mắm, 2 muỗng đường, 1 muỗng dấm, 100ml nước ấm. Thêm tỏi ớt băm nhỏ.', (SELECT recipe_id FROM recipes WHERE title = 'Bún Chả Hà Nội')),
(4, 5, 'Chuẩn bị bún tươi, rau sống (xà lách, húng, kinh giới), đu đủ xanh ngâm chua.', (SELECT recipe_id FROM recipes WHERE title = 'Bún Chả Hà Nội')),
(5, 5, 'Bày bún ra đĩa, thịt nướng vào bát nước mắm pha. Ăn kèm rau sống.', (SELECT recipe_id FROM recipes WHERE title = 'Bún Chả Hà Nội'));

-- Steps cho Gỏi cuốn
INSERT INTO steps (step_number, step_time, description, recipe_id) VALUES
(1, 15, 'Luộc tôm, thịt ba chỉ chín. Tôm bóc vỏ, thịt thái lát mỏng. Để nguội.', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt')),
(2, 10, 'Rửa sạch rau sống (xà lách, húng, hẹ), bún tươi.', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt')),
(3, 5, 'Nhúng bánh tráng vào nước ấm cho mềm, đặt lên mặt phẳng.', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt')),
(4, 15, 'Xếp rau, bún, thịt, tôm lên bánh tráng. Cuộn chặt tay, gấp 2 mép lại.', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt')),
(5, 10, 'Pha nước chấm tương đậu phộng: đậu phộng rang xay, tương đen, nước dừa, đường, tỏi ớt.', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'));

-- =====================================================
-- 7. RECIPE_CATEGORY - Liên kết công thức với danh mục
-- =====================================================
INSERT INTO recipe_category (recipe_id, category_id)
SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Phở Bò Hà Nội' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Phở Bò Hà Nội' AND c.name = 'Món Canh & Súp'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Bún Chả Hà Nội' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Gỏi Cuốn Tôm Thịt' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Gỏi Cuốn Tôm Thịt' AND c.name = 'Món Nhanh'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Cơm Tấm Sườn Bì Chả' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Bánh Mì Thịt Nguội' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Bánh Mì Thịt Nguội' AND c.name = 'Món Nhanh'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Thịt Kho Tàu Trứng' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Canh Chua Cá Lóc' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Canh Chua Cá Lóc' AND c.name = 'Món Canh & Súp'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Canh Chua Cá Lóc' AND c.name = 'Món Hải Sản'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Bò Lúc Lắc' AND c.name = 'Món Á'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Bánh Xèo Miền Nam' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Chả Giò Rán' AND c.name = 'Món Việt'
UNION SELECT r.recipe_id, c.category_id FROM recipes r, categories c WHERE r.title = 'Chả Giò Rán' AND c.name = 'Món Nhậu';

-- =====================================================
-- 8. RECIPE_TAG - Liên kết công thức với tags
-- =====================================================
INSERT INTO recipe_tag (recipe_id, tag_id)
SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Phở Bò Hà Nội' AND t.name = 'Truyền thống'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Phở Bò Hà Nội' AND t.name = 'Món nước'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bún Chả Hà Nội' AND t.name = 'Đồ nướng'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bún Chả Hà Nội' AND t.name = 'Truyền thống'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Gỏi Cuốn Tôm Thịt' AND t.name = 'Healthy'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Gỏi Cuốn Tôm Thịt' AND t.name = 'Dễ làm'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Gỏi Cuốn Tôm Thịt' AND t.name = 'Ít calo'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Cơm Tấm Sườn Bì Chả' AND t.name = 'Đồ nướng'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Cơm Tấm Sườn Bì Chả' AND t.name = 'Gia đình'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bánh Mì Thịt Nguội' AND t.name = 'Dễ làm'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bánh Mì Thịt Nguội' AND t.name = 'Nguyên liệu rẻ'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Thịt Kho Tàu Trứng' AND t.name = 'Truyền thống'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Thịt Kho Tàu Trứng' AND t.name = 'Gia đình'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Canh Chua Cá Lóc' AND t.name = 'Healthy'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Canh Chua Cá Lóc' AND t.name = 'Món nước'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bò Lúc Lắc' AND t.name = 'Giàu protein'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bò Lúc Lắc' AND t.name = 'Tiệc tùng'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bánh Xèo Miền Nam' AND t.name = 'Truyền thống'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Bánh Xèo Miền Nam' AND t.name = 'Chiên giòn'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Chả Giò Rán' AND t.name = 'Chiên giòn'
UNION SELECT r.recipe_id, t.id FROM recipes r, tags t WHERE r.title = 'Chả Giò Rán' AND t.name = 'Tiệc tùng';

-- =====================================================
-- 9. RECIPE_INGREDIENTS - Nguyên liệu cho công thức
-- =====================================================
-- Phở bò
INSERT INTO recipe_ingredients (quantity, unit, display_order, raw_name, note, recipe_id, ingredient_id) VALUES
(1, 'kg', 1, 'Xương bò', 'Xương ống hoặc xương sườn', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Thịt bò')),
(500, 'g', 2, 'Thịt bò', 'Thăn hoặc nạm, thái mỏng', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Thịt bò')),
(2, 'củ', 3, 'Hành tây', 'Để nướng', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Hành tây')),
(1, 'củ', 4, 'Gừng', 'Nướng thơm', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Gừng')),
(500, 'g', 5, 'Bánh phở', 'Phở tươi hoặc khô', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Phở')),
(2, 'muỗng canh', 6, 'Nước mắm', NULL, (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Nước mắm')),
(1, 'muỗng canh', 7, 'Muối', NULL, (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Muối')),
(1, 'muỗng canh', 8, 'Đường', NULL, (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), (SELECT ingredient_id FROM ingredients WHERE name = 'Đường'));

-- Gỏi cuốn
INSERT INTO recipe_ingredients (quantity, unit, display_order, raw_name, note, recipe_id, ingredient_id) VALUES
(200, 'g', 1, 'Tôm', 'Tôm sú hoặc tôm thẻ, luộc chín', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'), (SELECT ingredient_id FROM ingredients WHERE name = 'Tôm')),
(200, 'g', 2, 'Thịt ba chỉ', 'Luộc chín, thái lát', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'), (SELECT ingredient_id FROM ingredients WHERE name = 'Ba chỉ')),
(200, 'g', 3, 'Bún tươi', NULL, (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'), (SELECT ingredient_id FROM ingredients WHERE name = 'Bún')),
(100, 'g', 4, 'Giá đỗ', 'Rửa sạch', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'), (SELECT ingredient_id FROM ingredients WHERE name = 'Giá đỗ'));

-- Thịt kho tàu
INSERT INTO recipe_ingredients (quantity, unit, display_order, raw_name, note, recipe_id, ingredient_id) VALUES
(800, 'g', 1, 'Thịt ba chỉ', 'Cắt miếng vuông 4cm', (SELECT recipe_id FROM recipes WHERE title = 'Thịt Kho Tàu Trứng'), (SELECT ingredient_id FROM ingredients WHERE name = 'Ba chỉ')),
(6, 'quả', 2, 'Trứng', 'Luộc chín, bóc vỏ', (SELECT recipe_id FROM recipes WHERE title = 'Thịt Kho Tàu Trứng'), (SELECT ingredient_id FROM ingredients WHERE name = 'Trứng')),
(200, 'ml', 3, 'Nước cốt dừa', 'Hoặc nước dừa tươi', (SELECT recipe_id FROM recipes WHERE title = 'Thịt Kho Tàu Trứng'), (SELECT ingredient_id FROM ingredients WHERE name = 'Nước cốt dừa')),
(3, 'muỗng canh', 4, 'Nước mắm', NULL, (SELECT recipe_id FROM recipes WHERE title = 'Thịt Kho Tàu Trứng'), (SELECT ingredient_id FROM ingredients WHERE name = 'Nước mắm')),
(2, 'muỗng canh', 5, 'Đường', 'Để thắng màu', (SELECT recipe_id FROM recipes WHERE title = 'Thịt Kho Tàu Trứng'), (SELECT ingredient_id FROM ingredients WHERE name = 'Đường')),
(1, 'muỗng cà phê', 6, 'Tiêu', NULL, (SELECT recipe_id FROM recipes WHERE title = 'Thịt Kho Tàu Trứng'), (SELECT ingredient_id FROM ingredients WHERE name = 'Tiêu'));

-- =====================================================
-- 10. DISHES - Món ăn bán (E-commerce)
-- =====================================================
INSERT INTO dish (user_id, name, description, img_url, price, remaining_servings, status, recipe_id, version) VALUES
((SELECT user_id FROM users WHERE username = 'seller_nam'), 'Phở Bò Đặc Biệt', 'Phở bò với thịt bò tươi, nước dùng đậm đà. Giao hàng nóng hổi.', 'https://images.unsplash.com/photo-1503764654157-72d979d9af2f?w=400', 55000, 20, 'ACTIVE', (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội'), 1),
((SELECT user_id FROM users WHERE username = 'seller_nam'), 'Bún Chả Combo', 'Bún chả kèm nem rán, nước mắm pha sẵn.', 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=400', 60000, 15, 'ACTIVE', (SELECT recipe_id FROM recipes WHERE title = 'Bún Chả Hà Nội'), 1),
((SELECT user_id FROM users WHERE username = 'chef_minh'), 'Gỏi Cuốn 10 Cuốn', 'Set 10 cuốn gỏi cuốn tôm thịt kèm nước chấm đậu phộng.', 'https://images.unsplash.com/photo-1562967916-eb82221dfb92?w=400', 80000, 10, 'ACTIVE', (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'), 1),
((SELECT user_id FROM users WHERE username = 'seller_nam'), 'Cơm Tấm Đầy Đủ', 'Cơm tấm sườn bì chả, mỡ hành, nước mắm đặc biệt.', 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=400', 45000, 25, 'ACTIVE', NULL, 1),
((SELECT user_id FROM users WHERE username = 'chef_minh'), 'Bánh Xèo Giòn', 'Bánh xèo nhân tôm thịt kèm rau sống và nước mắm.', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400', 35000, 30, 'ACTIVE', NULL, 1);

-- =====================================================
-- 11. COLLECTIONS - Bộ sưu tập yêu thích
-- =====================================================
INSERT INTO collections (name, description, is_public, user_id, created_at, updated_at) VALUES
('Món Sáng Yêu Thích', 'Những món ăn sáng ngon miệng của tôi', 1, (SELECT user_id FROM users WHERE username = 'foodie_an'), NOW(), NOW()),
('Món Dễ Làm', 'Công thức đơn giản cho người mới học nấu ăn', 1, (SELECT user_id FROM users WHERE username = 'foodie_mai'), NOW(), NOW()),
('Món Cho Gia Đình', 'Các món phù hợp cho bữa cơm gia đình', 1, (SELECT user_id FROM users WHERE username = 'foodie_mai'), NOW(), NOW());

-- Collection recipes
INSERT INTO collection_recipes (collection_id, recipe_id, added_at)
SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Sáng Yêu Thích' AND r.title = 'Phở Bò Hà Nội'
UNION SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Sáng Yêu Thích' AND r.title = 'Bánh Mì Thịt Nguội'
UNION SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Sáng Yêu Thích' AND r.title = 'Cơm Tấm Sườn Bì Chả'
UNION SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Dễ Làm' AND r.title = 'Gỏi Cuốn Tôm Thịt'
UNION SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Dễ Làm' AND r.title = 'Bánh Mì Thịt Nguội'
UNION SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Cho Gia Đình' AND r.title = 'Thịt Kho Tàu Trứng'
UNION SELECT c.collection_id, r.recipe_id, NOW() FROM collections c, recipes r WHERE c.name = 'Món Cho Gia Đình' AND r.title = 'Canh Chua Cá Lóc';

-- =====================================================
-- 12. USER_FOLLOW - Quan hệ follow giữa users
-- =====================================================
INSERT INTO user_follows (follower_id, followed_id, created_at) VALUES
((SELECT user_id FROM users WHERE username = 'foodie_an'), (SELECT user_id FROM users WHERE username = 'chef_minh'), NOW()),
((SELECT user_id FROM users WHERE username = 'foodie_an'), (SELECT user_id FROM users WHERE username = 'chef_lan'), NOW()),
((SELECT user_id FROM users WHERE username = 'foodie_mai'), (SELECT user_id FROM users WHERE username = 'chef_minh'), NOW()),
((SELECT user_id FROM users WHERE username = 'foodie_mai'), (SELECT user_id FROM users WHERE username = 'chef_hung'), NOW()),
((SELECT user_id FROM users WHERE username = 'chef_lan'), (SELECT user_id FROM users WHERE username = 'chef_minh'), NOW());

-- =====================================================
-- 13. COMMENTS - Bình luận cho công thức
-- =====================================================
INSERT INTO comments (content, created_at, updated_at, user_id, recipe_id) VALUES
('Món này ngon quá! Tôi đã nấu thử và cả nhà khen nức nở.', NOW(), NOW(), (SELECT user_id FROM users WHERE username = 'foodie_an'), (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
('Cảm ơn chef đã chia sẻ công thức. Rất chi tiết và dễ hiểu.', NOW(), NOW(), (SELECT user_id FROM users WHERE username = 'foodie_mai'), (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
('Phần nước dùng thơm lắm, y như hàng phở ngoài tiệm!', NOW(), NOW(), (SELECT user_id FROM users WHERE username = 'foodie_an'), (SELECT recipe_id FROM recipes WHERE title = 'Phở Bò Hà Nội')),
('Gỏi cuốn của mình làm theo công thức này được khen nhiều lắm.', NOW(), NOW(), (SELECT user_id FROM users WHERE username = 'foodie_mai'), (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt')),
('Món này dễ làm mà ngon, phù hợp cho người mới học nấu ăn.', NOW(), NOW(), (SELECT user_id FROM users WHERE username = 'foodie_an'), (SELECT recipe_id FROM recipes WHERE title = 'Gỏi Cuốn Tôm Thịt'));

-- =====================================================
-- HOÀN THÀNH! 
-- =====================================================
SELECT 'Seed data đã được chèn thành công!' AS Status;
SELECT COUNT(*) AS 'Số lượng Users' FROM users;
SELECT COUNT(*) AS 'Số lượng Categories' FROM categories;
SELECT COUNT(*) AS 'Số lượng Tags' FROM tags;
SELECT COUNT(*) AS 'Số lượng Ingredients' FROM ingredients;
SELECT COUNT(*) AS 'Số lượng Recipes' FROM recipes;
SELECT COUNT(*) AS 'Số lượng Steps' FROM steps;
SELECT COUNT(*) AS 'Số lượng Dishes' FROM dish;

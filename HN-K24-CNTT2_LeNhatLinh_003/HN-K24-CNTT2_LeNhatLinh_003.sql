create database test;
use test;

-- PHẦN 1: THIẾT KẾ CSDL & CHÈN DỮ LIỆU
create table Guests_test (
	guest_id int primary key auto_increment,
    full_name varchar (100) not null,
    email varchar(100) unique not null,
    phone varchar(50) not null,
    points varchar(50) not null
);
 
 create table Guest_Profiles (
	profile_id int primary key auto_increment,
    guest_id int,
    address varchar (100) not null,
    birthday varchar (50) not null,
    national_id varchar(50) unique
 );
 
 create table Rooms_test (
	room_id int primary key auto_increment,
    room_name varchar(100) not null,
    room_type varchar(100) not null,
    price_per_night varchar(100) not null,
    room_status varchar(100) not null
 );
 
 create table Bookings_test (
	booking_id int primary key auto_increment,
    guest_id int,
    check_in_date varchar(100) not null,
    check_out_date varchar(100) not null,
    total_charge varchar(100) not null,
    booking_status varchar(50) not null 
 );
 
 create table Room_Log (
	log_id int  primary key auto_increment,
    room_id int,
    action_type varchar(100) not null,
    change_note varchar(100) not null,
    logged_at varchar(100)
 );
 
-- Viết script INSERT dữ liệu theo bảng dữ liệu mẫu
insert into guests_test (guest_id, full_name, email, phone, points) values 
(1, 'Nguyen Van A', 'anv@gmail.com', '901234567', '150'),
(2, 'Tran Thi B', 'btt@gmail.com', '912345678', '150'),
(3, 'Le Van C', 'cle@yahoo.com', '922334455', '0'),
(4, 'Pham Minh D', 'dpham@hotmail.com', '933445566', '1000'),
(5, 'Hoang Anh E', 'ehoang@gmail.com', '944556677', '20');

insert into guest_profiles (profile_id, guest_id, address, birthday, national_id) values 
(101, 1, '123 Le Loi, Q1, HCM', '5/15/1990','12345' ),
(102, '2', '456 Nguyen Hue, Q1, HCM', '10/20/1985', '23456'),
(103, '3', '789 Phan Chu Trinh, Da Nang', '12/1/1995', '34567'),
(104, '4', '101 Hoang Hoa Tham, Ha Noi', '3/25/1988', '45678'),
(105, '5', '202 Tran Hung Dao, Can Tho', '7/10/2000', '56789');

insert into rooms_test (room_id, room_name, room_type, price_per_night, room_status) values 
(1, 'Room 101', 'Standard', '10','Available' ),
(2, 'Room 202', 'Deluxe', '5', 'Occupied'),
(3, 'Room 303', 'Suite', '50', 'Available'),
(4, 'Room 104', 'Standard', '0', 'Occupied'),
(5, 'Room 205', 'Deluxe', '20', 'Maintenance');

insert into bookings_test(booking_id, guest_id, check_in_date, check_out_date, total_charge, booking_status) values 
(1001, 1, '11/15/2023 10:30', '11/18/2023 12:00', '35,500,000', 'Completed'),
(1002, 2, '12/1/2023 14:20', '12/4/2023 12:00', '28,000,000', 'Completed'),
(1003, 1, '1/10/2024 9:15', '1/11/2024 12:00', '500,000', 'Pending'),
(1004, 3, '5/20/2023 16:45', '5/22/2023 12:00', '7,000,000', 'Cancelled'),
(1005, 4, '1/18/2024 11:00', '1/20/2024 12:00', '1,200,000', 'Completed');

insert into room_log (log_id, room_id, action_type, change_note, logged_at) values 
(1, 1, 'Check-in', 'Guest checked in', '10/1/2023 8:00'),
(2, 1, 'Check-out', 'Guest checked out', '11/15/2023 10:35'),
(3, 4, 'Maintenance', 'Room reported as damaged', '11/20/2023 15:00'),
(4, 2, 'Check-in', 'New guest arrival', '11/25/2023 9:00'),
(5, 3, 'Maintenance', 'Schedule maintenance', '12/1/2023 13:00');
-- Viết câu lệnh UPDATE cộng 200 điểm tích lũy cho các khách hàng có email là đuôi '@gmail.com'

--   - Viết câu lệnh DELETE xóa các bản ghi trong Room_Log có logged_at trước ngày 10/11/2023.
delete from Room_Log_test where logged_at > '10/11/2023';

-- PHẦN 2: TRUY VẤN DỮ LIỆU CƠ BẢN (15 ĐIỂM)
-- Câu 1 (5đ): Lấy danh sách phòng (room_name, price_per_night, room_status) có giá thuê > 1.000.000 hoặc room_status = 'Maintenance' hoặc room_type = 'Suite'.
select room_name, price_per_night, room_status from rooms_test 
where price_per_night > '1.000.000' or room_status = 'Maintenance'or  room_type = 'Suite';
 
-- Câu 2 (5đ): Lấy thông tin khách (full_name, email) có email thuộc domain '@gmail.com' và loyalty_points nằm trong khoảng từ 50 đến 300.
select full_name, email from guests_test where email like'%@gmail.com' and points between 50 and 300;
-- Câu 3 (5đ): Hiển thị 3 booking có total_charge cao nhất, sắp xếp giảm dần, và bỏ qua booking cao nhất (chỉ lấy từ booking thứ 2 → thứ 4). Yêu cầu dùng LIMIT + OFFSET
select t.total_charge from bookings_test b order by t.total_charge limit 3 offset 1;

-- ---
-- PHẦN 3: TRUY VẤN DỮ LIỆU NÂNG CAO (20 ĐIỂM)
-- Mục tiêu: Kiểm tra tư duy liên kết bảng và thống kê dữ liệu.
-- - Câu 1 (6đ): Viết câu lệnh truy vấn lấy ra các thông tin lịch đặt phòng gồm :
--   - full_name
--   - national_id
--   - booking_id
--   - check_in_date
--   - total_charge
select full_name, national_id, booking_id, check_in_date, total_charge from guests_test g
join guest_profiles p on p.guest_id = g. guest_id;


-- - Câu 2 (7đ): Tính tổng số tiền thanh toán của mỗi khách. Chỉ hiển thị các khách có tổng chi tiêu của booking đã hoàn thành > 20.000.000 VNĐ.
select count(*) from bookings_test where total_charge > '20.000.000';
-- - Câu 3 (7đ): Tìm thông tin phòng có price_per_night cao nhất trong danh sách các phòng đã từng xuất hiện trong booking thành công.
select price_per_night from rooms_test r
join bookings_test on 

-- ---
-- PHẦN 4: INDEX VÀ VIEW (10 ĐIỂM)
-- Mục tiêu: Kiểm tra khả năng tối ưu hóa và đóng gói truy vấn.
-- - Câu 1 (5đ): Tạo Composite Index tên idx_booking_status_date trên bảng Bookings gồm 2 cột:
--   - booking_status
--   - created_at
delimiter //
	create index idx_booking_status_date  bookings_test
    begin
    end //
delimietr ;

-- - Câu 2 (5đ): Tạo View vw_guest_booking_stats hiển thị:
--   - Guest Name
--   - Tổng số booking đã đặt
--   - Tổng số tiền đã thanh toán (chỉ lấy booking không bị hủy)


-- ---
-- PHẦN 5: TRIGGER (10 ĐIỂM)
-- Mục tiêu: Kiểm tra kỹ năng xử lý sự kiện tự động.
-- - Câu 1 (5đ): Tạo trigger trg_after_update_booking_status. Khi một booking chuyển trạng thái sang 'Completed', tự động ghi vào Room_Log:
--   - action_type = 'Check-out'
--   - change_note = 'Booking Completed'
--   - room_id lấy từ booking liên quan
--   - logged_at = NOW()
delimiter //
	create trigger trg_after_update_booking_status after update on bookings_test
    for each row
    begin
		set booking_status ='Completed';
        insert into room_log(action_type, change_note, room_id, logged_at) values ('Check-out','Booking Completed',logged_at = NOW());
        
    end //
delimiter ;
-- - Câu 2 (5đ): Tạo trigger trg_update_loyalty_points trên bảng Bookings. Khi thêm booking mới với trạng thái 'Completed', tự động cộng loyalty_points cho khách:
--   - Cứ mỗi 1.000.000 VNĐ → cộng 2 điểm.
delimiter //
	create trigger trg_update_loyalty_points before update on bookings_test
delimiter ;

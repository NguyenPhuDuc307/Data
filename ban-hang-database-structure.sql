-- =====================================================
-- HỆ THỐNG QUẢN LÝ BÁN HÀNG - CẤU TRÚC CSDL
-- =====================================================
-- Tác giả: Generated for Database Management Course
-- Ngày tạo: 31/05/2025
-- Mô tả: Script tạo cấu trúc CSDL cho hệ thống quản lý bán hàng
-- =====================================================

-- Xóa các bảng nếu đã tồn tại (để có thể chạy lại script)
DROP TABLE IF EXISTS BAN;
DROP TABLE IF EXISTS HH;
DROP TABLE IF EXISTS KH;

-- =====================================================
-- 1. TẠO BẢNG KH (KHÁCH HÀNG)
-- =====================================================
CREATE TABLE KH (
    MaKH VARCHAR(10) PRIMARY KEY,
    TenKH NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200),
    
    -- Ràng buộc bổ sung
    CONSTRAINT chk_kh_makh CHECK (MaKH <> ''),
    CONSTRAINT chk_kh_tenkh CHECK (TenKH <> '')
);

-- Thêm comment cho bảng và cột
COMMENT ON TABLE KH IS 'Bảng thông tin khách hàng';
COMMENT ON COLUMN KH.MaKH IS 'Mã khách hàng - Khóa chính';
COMMENT ON COLUMN KH.TenKH IS 'Tên khách hàng';
COMMENT ON COLUMN KH.DiaChi IS 'Địa chỉ khách hàng';

-- =====================================================
-- 2. TẠO BẢNG HH (HÀNG HÓA)
-- =====================================================
CREATE TABLE HH (
    MaHH VARCHAR(10) PRIMARY KEY,
    TenHH NVARCHAR(100) NOT NULL,
    Nuocsx NVARCHAR(50),
    Gia DECIMAL(15,2) DEFAULT 0,
    
    -- Ràng buộc bổ sung
    CONSTRAINT chk_hh_mahh CHECK (MaHH <> ''),
    CONSTRAINT chk_hh_tenhh CHECK (TenHH <> ''),
    CONSTRAINT chk_hh_gia CHECK (Gia >= 0)
);

-- Thêm comment cho bảng và cột
COMMENT ON TABLE HH IS 'Bảng thông tin hàng hóa';
COMMENT ON COLUMN HH.MaHH IS 'Mã hàng hóa - Khóa chính';
COMMENT ON COLUMN HH.TenHH IS 'Tên hàng hóa';
COMMENT ON COLUMN HH.Nuocsx IS 'Nước sản xuất';
COMMENT ON COLUMN HH.Gia IS 'Giá bán (VND)';

-- =====================================================
-- 3. TẠO BẢNG BAN (GIAO DỊCH BÁN HÀNG)
-- =====================================================
CREATE TABLE BAN (
    MaKH VARCHAR(10),
    MaHH VARCHAR(10),
    Soluong INT DEFAULT 1,
    ThanhTien DECIMAL(15,2) DEFAULT 0,
    NgayBan DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- Khóa chính kết hợp
    PRIMARY KEY (MaKH, MaHH),
    
    -- Khóa ngoại
    FOREIGN KEY (MaKH) REFERENCES KH(MaKH) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (MaHH) REFERENCES HH(MaHH) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Ràng buộc bổ sung
    CONSTRAINT chk_ban_soluong CHECK (Soluong > 0),
    CONSTRAINT chk_ban_thanhtien CHECK (ThanhTien >= 0)
);

-- Thêm comment cho bảng và cột
COMMENT ON TABLE BAN IS 'Bảng giao dịch bán hàng';
COMMENT ON COLUMN BAN.MaKH IS 'Mã khách hàng - Khóa ngoại';
COMMENT ON COLUMN BAN.MaHH IS 'Mã hàng hóa - Khóa ngoại';
COMMENT ON COLUMN BAN.Soluong IS 'Số lượng mua';
COMMENT ON COLUMN BAN.ThanhTien IS 'Thành tiền (VND)';
COMMENT ON COLUMN BAN.NgayBan IS 'Ngày bán';

-- =====================================================
-- 4. TẠO INDEX ĐỂ TỐI ƯU HÓA TRUY VẤN
-- =====================================================

-- Index cho tìm kiếm theo địa chỉ khách hàng
CREATE INDEX idx_kh_diachi ON KH(DiaChi);

-- Index cho tìm kiếm theo nước sản xuất
CREATE INDEX idx_hh_nuocsx ON HH(Nuocsx);

-- Index cho tìm kiếm theo giá
CREATE INDEX idx_hh_gia ON HH(Gia);

-- Index kết hợp cho tìm kiếm theo nước sản xuất và giá
CREATE INDEX idx_hh_nuocsx_gia ON HH(Nuocsx, Gia);

-- Index cho tìm kiếm theo số lượng
CREATE INDEX idx_ban_soluong ON BAN(Soluong);

-- Index cho tìm kiếm theo thành tiền
CREATE INDEX idx_ban_thanhtien ON BAN(ThanhTien);

-- Index cho tìm kiếm theo ngày bán
CREATE INDEX idx_ban_ngayban ON BAN(NgayBan);

-- =====================================================
-- 5. THÊM DỮ LIỆU MẪU
-- =====================================================

-- Thêm dữ liệu bảng KH (Khách hàng)
INSERT INTO KH (MaKH, TenKH, DiaChi) VALUES
('KH001', N'Nguyễn Văn An', N'Hà Nội'),
('KH002', N'Trần Thị Bình', N'TP.HCM'),
('KH003', N'Lê Văn Cường', N'Hà Nội'),
('KH004', N'Phạm Thị Dung', N'Đà Nẵng'),
('KH005', N'Hoàng Văn Em', N'Hà Nội'),
('KH006', N'Vũ Thị Phương', N'Hải Phòng'),
('KH007', N'Đặng Văn Giang', N'Hà Nội'),
('KH008', N'Bùi Thị Hương', N'TP.HCM'),
('KH009', N'Ngô Văn Ích', N'Cần Thơ'),
('KH010', N'Tô Thị Kim', N'Hà Nội');

-- Thêm dữ liệu bảng HH (Hàng hóa)
INSERT INTO HH (MaHH, TenHH, Nuocsx, Gia) VALUES
('HH001', N'Áo sơ mi nam', N'Việt nam', 150.00),
('HH002', N'Quần jean nữ', N'Thái Lan', 250.00),
('HH003', N'Giày thể thao', N'Trung Quốc', 180.00),
('HH004', N'Túi xách da', N'Việt nam', 120.00),
('HH005', N'Đồng hồ đeo tay', N'Nhật Bản', 500.00),
('HH006', N'Điện thoại', N'Hàn Quốc', 800.00),
('HH007', N'Laptop', N'Việt nam', 1500.00),
('HH008', N'Máy tính bảng', N'Mỹ', 600.00),
('HH009', N'Tai nghe Bluetooth', N'Việt nam', 80.00),
('HH010', N'Kem dưỡng da', N'Pháp', 90.00),
('HH011', N'Nước hoa', N'Việt nam', 75.00),
('HH012', N'Kính mát', N'Ý', 200.00);

-- Thêm dữ liệu bảng BAN (Giao dịch)
INSERT INTO BAN (MaKH, MaHH, Soluong, ThanhTien) VALUES
-- Khách hàng KH001 - Tổng: 11.400.000
('KH001', 'HH001', 60, 9000.00),   -- 60 * 150 = 9.000
('KH001', 'HH004', 20, 2400.00),   -- 20 * 120 = 2.400

-- Khách hàng KH002 - Tổng: 5.000.000
('KH002', 'HH002', 10, 2500.00),   -- 10 * 250 = 2.500
('KH002', 'HH005', 5, 2500.00),    -- 5 * 500 = 2.500

-- Khách hàng KH003 - Tổng: 9.000.000
('KH003', 'HH001', 30, 4500.00),   -- 30 * 150 = 4.500
('KH003', 'HH003', 25, 4500.00),   -- 25 * 180 = 4.500

-- Khách hàng KH004 - Tổng: 2.400.000
('KH004', 'HH006', 3, 2400.00),    -- 3 * 800 = 2.400

-- Khách hàng KH005 - Tổng: 3.000.000
('KH005', 'HH007', 2, 3000.00),    -- 2 * 1500 = 3.000

-- Thêm dữ liệu để test các trường hợp khác
('KH006', 'HH009', 50, 4000.00),   -- 50 * 80 = 4.000
('KH007', 'HH011', 60, 4500.00),   -- 60 * 75 = 4.500
('KH008', 'HH010', 25, 2250.00),   -- 25 * 90 = 2.250
('KH009', 'HH012', 15, 3000.00),   -- 15 * 200 = 3.000
('KH010', 'HH008', 10, 6000.00);   -- 10 * 600 = 6.000

-- =====================================================
-- 6. TẠO VIEW ĐỂ THUẬN TIỆN TRUY VẤN
-- =====================================================

-- View chi tiết giao dịch bán hàng
CREATE VIEW v_ChiTietBanHang AS
SELECT 
    k.MaKH,
    k.TenKH,
    k.DiaChi,
    h.MaHH,
    h.TenHH,
    h.Nuocsx,
    h.Gia AS GiaDonVi,
    b.Soluong,
    b.ThanhTien,
    (b.Soluong * h.Gia) AS TinhToan_ThanhTien,
    CASE 
        WHEN b.ThanhTien = (b.Soluong * h.Gia) THEN N'Chính xác'
        ELSE N'Sai lệch'
    END AS KiemTra_ThanhTien
FROM KH k
JOIN BAN b ON k.MaKH = b.MaKH
JOIN HH h ON b.MaHH = h.MaHH;

-- View thống kê theo khách hàng
CREATE VIEW v_ThongKeKhachHang AS
SELECT 
    k.MaKH,
    k.TenKH,
    k.DiaChi,
    COUNT(b.MaHH) AS SoLoaiHangMua,
    SUM(b.Soluong) AS TongSoLuong,
    SUM(b.ThanhTien) AS TongThanhTien,
    AVG(b.ThanhTien) AS TrungBinhThanhTien
FROM KH k
LEFT JOIN BAN b ON k.MaKH = b.MaKH
GROUP BY k.MaKH, k.TenKH, k.DiaChi;

-- View thống kê theo hàng hóa
CREATE VIEW v_ThongKeHangHoa AS
SELECT 
    h.MaHH,
    h.TenHH,
    h.Nuocsx,
    h.Gia,
    COALESCE(SUM(b.Soluong), 0) AS TongSoLuongBan,
    COALESCE(SUM(b.ThanhTien), 0) AS TongDoanhThu,
    COUNT(DISTINCT b.MaKH) AS SoKhachHangMua
FROM HH h
LEFT JOIN BAN b ON h.MaHH = b.MaHH
GROUP BY h.MaHH, h.TenHH, h.Nuocsx, h.Gia;

-- View thống kê theo địa chỉ
CREATE VIEW v_ThongKeTheoDiaChi AS
SELECT 
    k.DiaChi,
    COUNT(DISTINCT k.MaKH) AS SoKhachHang,
    COALESCE(SUM(b.Soluong), 0) AS TongSoLuongMua,
    COALESCE(SUM(b.ThanhTien), 0) AS TongDoanhThu
FROM KH k
LEFT JOIN BAN b ON k.MaKH = b.MaKH
GROUP BY k.DiaChi
ORDER BY TongDoanhThu DESC;

-- =====================================================
-- 7. TẠO STORED PROCEDURE
-- =====================================================

-- Procedure tìm khách hàng theo địa chỉ
DELIMITER //
CREATE PROCEDURE sp_TimKhachHangTheoDiaChi(
    IN p_DiaChi NVARCHAR(200)
)
BEGIN
    SELECT 
        MaKH,
        TenKH,
        DiaChi
    FROM KH 
    WHERE DiaChi LIKE CONCAT('%', p_DiaChi, '%');
END //
DELIMITER ;

-- Procedure tìm hàng hóa theo khoảng giá
DELIMITER //
CREATE PROCEDURE sp_TimHangHoaTheoGia(
    IN p_GiaMin DECIMAL(15,2),
    IN p_GiaMax DECIMAL(15,2),
    IN p_Nuocsx NVARCHAR(50) DEFAULT NULL
)
BEGIN
    SELECT 
        MaHH,
        TenHH,
        Nuocsx,
        Gia
    FROM HH 
    WHERE Gia BETWEEN p_GiaMin AND p_GiaMax
    AND (p_Nuocsx IS NULL OR Nuocsx = p_Nuocsx)
    ORDER BY Gia;
END //
DELIMITER ;

-- =====================================================
-- 8. TẠO TRIGGER
-- =====================================================

-- Trigger kiểm tra thành tiền khi insert/update bảng BAN
DELIMITER //
CREATE TRIGGER tr_KiemTraThanhTien
BEFORE INSERT ON BAN
FOR EACH ROW
BEGIN
    DECLARE v_Gia DECIMAL(15,2);
    
    -- Lấy giá từ bảng HH
    SELECT Gia INTO v_Gia 
    FROM HH 
    WHERE MaHH = NEW.MaHH;
    
    -- Kiểm tra và điều chỉnh thành tiền nếu cần
    IF NEW.ThanhTien != (NEW.Soluong * v_Gia) THEN
        SET NEW.ThanhTien = NEW.Soluong * v_Gia;
    END IF;
END //
DELIMITER ;

-- =====================================================
-- 9. KIỂM TRA DỮ LIỆU
-- =====================================================

-- Kiểm tra số lượng bản ghi
SELECT 'KH' AS Bang, COUNT(*) AS SoBanGhi FROM KH
UNION ALL
SELECT 'HH' AS Bang, COUNT(*) AS SoBanGhi FROM HH
UNION ALL
SELECT 'BAN' AS Bang, COUNT(*) AS SoBanGhi FROM BAN;

-- Kiểm tra tính toàn vẹn dữ liệu
SELECT 
    'Sai lệch thành tiền' AS VanDe,
    COUNT(*) AS SoLuong
FROM v_ChiTietBanHang 
WHERE KiemTra_ThanhTien = N'Sai lệch';

-- =====================================================
-- 10. CÁC TRUY VẤN KIỂM TRA TÍNH NĂNG
-- =====================================================

-- Test câu a1: Hàng hóa Việt Nam giá 50-200
SELECT MaHH, TenHH, Gia 
FROM HH 
WHERE Gia BETWEEN 50 AND 200 
  AND Nuocsx = N'Việt nam';

-- Test câu a2: Khách hàng mua >2.000.000
SELECT K.MaKH, K.TenKH, K.DiaChi, SUM(B.ThanhTien) as TongTien
FROM KH K
JOIN BAN B ON K.MaKH = B.MaKH
GROUP BY K.MaKH, K.TenKH, K.DiaChi
HAVING SUM(B.ThanhTien) > 2000000;

-- Test View
SELECT * FROM v_ThongKeTheoDiaChi;

PRINT 'Cấu trúc CSDL đã được tạo thành công!';

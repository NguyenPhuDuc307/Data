-- =====================================================
-- HỆ THỐNG QUẢN LÝ ĐIỂM SINH VIÊN - CẤU TRÚC CSDL
-- =====================================================
-- Tác giả: Generated for Database Management Course
-- Ngày tạo: 31/05/2025
-- Mô tả: Script tạo cấu trúc CSDL cho hệ thống quản lý điểm sinh viên
-- =====================================================

-- Xóa các bảng nếu đã tồn tại (để có thể chạy lại script)
DROP TABLE IF EXISTS DIEMTHI;
DROP TABLE IF EXISTS LopHP;
DROP TABLE IF EXISTS SINHVIEN;

-- =====================================================
-- 1. TẠO BẢNG SINHVIEN (SINH VIÊN)
-- =====================================================
CREATE TABLE SINHVIEN (
    MaSV VARCHAR(10) PRIMARY KEY,
    TenSV NVARCHAR(100) NOT NULL,
    LopHC VARCHAR(20),
    
    -- Ràng buộc bổ sung
    CONSTRAINT chk_sv_masv CHECK (MaSV <> ''),
    CONSTRAINT chk_sv_tensv CHECK (TenSV <> '')
);

-- Thêm comment cho bảng và cột
COMMENT ON TABLE SINHVIEN IS 'Bảng thông tin sinh viên';
COMMENT ON COLUMN SINHVIEN.MaSV IS 'Mã sinh viên - Khóa chính';
COMMENT ON COLUMN SINHVIEN.TenSV IS 'Tên sinh viên';
COMMENT ON COLUMN SINHVIEN.LopHC IS 'Lớp hành chính';

-- =====================================================
-- 2. TẠO BẢNG LopHP (LỚP HỌC PHẦN)
-- =====================================================
CREATE TABLE LopHP (
    MaLopHP VARCHAR(15) PRIMARY KEY,
    TenHP NVARCHAR(100) NOT NULL,
    SoTC INT DEFAULT 1,
    
    -- Ràng buộc bổ sung
    CONSTRAINT chk_lhp_malophp CHECK (MaLopHP <> ''),
    CONSTRAINT chk_lhp_tenhp CHECK (TenHP <> ''),
    CONSTRAINT chk_lhp_sotc CHECK (SoTC > 0 AND SoTC <= 10)
);

-- Thêm comment cho bảng và cột
COMMENT ON TABLE LopHP IS 'Bảng thông tin lớp học phần';
COMMENT ON COLUMN LopHP.MaLopHP IS 'Mã lớp học phần - Khóa chính';
COMMENT ON COLUMN LopHP.TenHP IS 'Tên học phần';
COMMENT ON COLUMN LopHP.SoTC IS 'Số tín chỉ';

-- =====================================================
-- 3. TẠO BẢNG DIEMTHI (ĐIỂM THI)
-- =====================================================
CREATE TABLE DIEMTHI (
    MaSV VARCHAR(10),
    MaLopHP VARCHAR(15),
    DiemThi DECIMAL(4,2) DEFAULT 0,
    NgayThi DATE,
    
    -- Khóa chính kết hợp
    PRIMARY KEY (MaSV, MaLopHP),
    
    -- Khóa ngoại
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (MaLopHP) REFERENCES LopHP(MaLopHP) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Ràng buộc bổ sung
    CONSTRAINT chk_dt_diemthi CHECK (DiemThi >= 0 AND DiemThi <= 10)
);

-- Thêm comment cho bảng và cột
COMMENT ON TABLE DIEMTHI IS 'Bảng điểm thi của sinh viên';
COMMENT ON COLUMN DIEMTHI.MaSV IS 'Mã sinh viên - Khóa ngoại';
COMMENT ON COLUMN DIEMTHI.MaLopHP IS 'Mã lớp học phần - Khóa ngoại';
COMMENT ON COLUMN DIEMTHI.DiemThi IS 'Điểm thi (0-10)';
COMMENT ON COLUMN DIEMTHI.NgayThi IS 'Ngày thi';

-- =====================================================
-- 4. TẠO INDEX ĐỂ TỐI ƯU HÓA TRUY VẤN
-- =====================================================

-- Index cho tìm kiếm theo lớp hành chính
CREATE INDEX idx_sv_lophc ON SINHVIEN(LopHC);

-- Index cho tìm kiếm theo tên sinh viên
CREATE INDEX idx_sv_tensv ON SINHVIEN(TenSV);

-- Index cho tìm kiếm theo số tín chỉ
CREATE INDEX idx_lhp_sotc ON LopHP(SoTC);

-- Index cho tìm kiếm theo tên học phần
CREATE INDEX idx_lhp_tenhp ON LopHP(TenHP);

-- Index cho tìm kiếm theo điểm thi
CREATE INDEX idx_dt_diemthi ON DIEMTHI(DiemThi);

-- Index cho tìm kiếm theo ngày thi
CREATE INDEX idx_dt_ngaythi ON DIEMTHI(NgayThi);

-- =====================================================
-- 5. THÊM DỮ LIỆU MẪU
-- =====================================================

-- Thêm dữ liệu bảng SINHVIEN
INSERT INTO SINHVIEN (MaSV, TenSV, LopHC) VALUES
('SV001', N'Nguyễn Văn An', 'K60S1'),
('SV002', N'Trần Thị Bình', 'K60S1'),
('SV003', N'Lê Văn Cường', 'K60S2'),
('SV004', N'Phạm Thị Dung', 'K60S1'),
('SV005', N'Hoàng Văn Em', 'K60S2'),
('SV006', N'Vũ Thị Phương', 'K60S1'),
('SV007', N'Đặng Văn Giang', 'K60S3'),
('SV008', N'Bùi Thị Hương', 'K60S2'),
('SV009', N'Ngô Văn Ích', 'K60S3'),
('SV010', N'Tô Thị Kim', 'K60S1'),
('SV011', N'Lý Văn Long', 'K60S2'),
('SV012', N'Đinh Thị Mai', 'K60S3');

-- Thêm dữ liệu bảng LopHP
INSERT INTO LopHP (MaLopHP, TenHP, SoTC) VALUES
('LHP001', N'Cơ sở dữ liệu', 3),
('LHP002', N'Lập trình Java', 4),
('LHP003', N'Toán cao cấp', 3),
('LHP004', N'Tiếng Anh chuyên ngành', 2),
('LHP005', N'Mạng máy tính', 3),
('LHP006', N'Hệ điều hành', 3),
('LHP007', N'Phân tích thiết kế hệ thống', 4),
('LHP008', N'Kỹ thuật phần mềm', 3),
('LHP009', N'Trí tuệ nhân tạo', 3),
('LHP010', N'An toàn thông tin', 2),
('LHP011', N'Phát triển ứng dụng web', 4),
('LHP012', N'Học máy', 3);

-- Thêm dữ liệu bảng DIEMTHI
INSERT INTO DIEMTHI (MaSV, MaLopHP, DiemThi, NgayThi) VALUES
-- Sinh viên SV001
('SV001', 'LHP001', 7.5, '2024-01-15'),
('SV001', 'LHP002', 8.0, '2024-01-20'),
('SV001', 'LHP003', 6.5, '2024-01-25'),

-- Sinh viên SV002  
('SV002', 'LHP001', 9.0, '2024-01-15'),
('SV002', 'LHP004', 7.0, '2024-02-01'),
('SV002', 'LHP005', 8.5, '2024-02-10'),

-- Sinh viên SV003
('SV003', 'LHP001', 5.5, '2024-01-15'),
('SV003', 'LHP002', 6.0, '2024-01-20'),
('SV003', 'LHP006', 7.5, '2024-02-15'),

-- Sinh viên SV004
('SV004', 'LHP001', 8.5, '2024-01-15'),
('SV004', 'LHP003', 7.0, '2024-01-25'),
('SV004', 'LHP007', 9.0, '2024-03-01'),

-- Sinh viên SV005
('SV005', 'LHP002', 6.5, '2024-01-20'),
('SV005', 'LHP005', 7.5, '2024-02-10'),
('SV005', 'LHP008', 8.0, '2024-03-05'),

-- Sinh viên SV006
('SV006', 'LHP001', 9.5, '2024-01-15'),
('SV006', 'LHP004', 8.0, '2024-02-01'),
('SV006', 'LHP009', 7.0, '2024-03-10'),

-- Sinh viên SV007
('SV007', 'LHP003', 6.0, '2024-01-25'),
('SV007', 'LHP006', 5.5, '2024-02-15'),
('SV007', 'LHP010', 7.5, '2024-03-20'),

-- Sinh viên SV008
('SV008', 'LHP002', 7.5, '2024-01-20'),
('SV008', 'LHP005', 8.5, '2024-02-10'),
('SV008', 'LHP011', 9.0, '2024-04-01'),

-- Sinh viên SV009
('SV009', 'LHP007', 6.5, '2024-03-01'),
('SV009', 'LHP008', 7.0, '2024-03-05'),
('SV009', 'LHP012', 8.5, '2024-04-10'),

-- Sinh viên SV010
('SV010', 'LHP001', 8.0, '2024-01-15'),
('SV010', 'LHP004', 9.0, '2024-02-01'),
('SV010', 'LHP009', 7.5, '2024-03-10');

-- =====================================================
-- 6. TẠO VIEW ĐỂ THUẬN TIỆN TRUY VẤN
-- =====================================================

-- View chi tiết điểm thi
CREATE VIEW v_ChiTietDiemThi AS
SELECT 
    sv.MaSV,
    sv.TenSV,
    sv.LopHC,
    lhp.MaLopHP,
    lhp.TenHP,
    lhp.SoTC,
    dt.DiemThi,
    dt.NgayThi,
    CASE 
        WHEN dt.DiemThi >= 8.5 THEN N'Giỏi'
        WHEN dt.DiemThi >= 7.0 THEN N'Khá'
        WHEN dt.DiemThi >= 5.5 THEN N'Trung bình'
        WHEN dt.DiemThi >= 4.0 THEN N'Yếu'
        ELSE N'Kém'
    END AS XepLoai
FROM SINHVIEN sv
JOIN DIEMTHI dt ON sv.MaSV = dt.MaSV
JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP;

-- View thống kê theo sinh viên
CREATE VIEW v_ThongKeSinhVien AS
SELECT 
    sv.MaSV,
    sv.TenSV,
    sv.LopHC,
    COUNT(dt.MaLopHP) AS SoMonHoc,
    SUM(lhp.SoTC) AS TongSoTC,
    AVG(dt.DiemThi) AS DiemTrungBinh,
    MAX(dt.DiemThi) AS DiemCaoNhat,
    MIN(dt.DiemThi) AS DiemThapNhat
FROM SINHVIEN sv
LEFT JOIN DIEMTHI dt ON sv.MaSV = dt.MaSV
LEFT JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP
GROUP BY sv.MaSV, sv.TenSV, sv.LopHC;

-- View thống kê theo lớp học phần
CREATE VIEW v_ThongKeLopHP AS
SELECT 
    lhp.MaLopHP,
    lhp.TenHP,
    lhp.SoTC,
    COUNT(dt.MaSV) AS SoSinhVien,
    AVG(dt.DiemThi) AS DiemTrungBinh,
    MAX(dt.DiemThi) AS DiemCaoNhat,
    MIN(dt.DiemThi) AS DiemThapNhat,
    COUNT(CASE WHEN dt.DiemThi >= 5.0 THEN 1 END) AS SoSVDau,
    COUNT(CASE WHEN dt.DiemThi < 5.0 THEN 1 END) AS SoSVRot
FROM LopHP lhp
LEFT JOIN DIEMTHI dt ON lhp.MaLopHP = dt.MaLopHP
GROUP BY lhp.MaLopHP, lhp.TenHP, lhp.SoTC;

-- View thống kê theo lớp hành chính
CREATE VIEW v_ThongKeLopHC AS
SELECT 
    sv.LopHC,
    COUNT(DISTINCT sv.MaSV) AS SoSinhVien,
    AVG(sub.DiemTrungBinh) AS DiemTBLop,
    SUM(sub.TongSoTC) AS TongTCLop
FROM SINHVIEN sv
LEFT JOIN (
    SELECT 
        MaSV,
        AVG(DiemThi) AS DiemTrungBinh,
        SUM(lhp.SoTC) AS TongSoTC
    FROM DIEMTHI dt
    JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP
    GROUP BY MaSV
) sub ON sv.MaSV = sub.MaSV
GROUP BY sv.LopHC
ORDER BY DiemTBLop DESC;

-- =====================================================
-- 7. TẠO STORED PROCEDURE
-- =====================================================

-- Procedure tìm sinh viên theo lớp hành chính
DELIMITER //
CREATE PROCEDURE sp_TimSinhVienTheoLop(
    IN p_LopHC VARCHAR(20)
)
BEGIN
    SELECT 
        MaSV,
        TenSV,
        LopHC
    FROM SINHVIEN 
    WHERE LopHC = p_LopHC
    ORDER BY TenSV;
END //
DELIMITER ;

-- Procedure tìm lớp học phần có điểm trung bình > X
DELIMITER //
CREATE PROCEDURE sp_LopHPDiemTBCao(
    IN p_DiemTB DECIMAL(4,2)
)
BEGIN
    SELECT 
        lhp.MaLopHP,
        lhp.TenHP,
        lhp.SoTC,
        AVG(dt.DiemThi) AS DiemTrungBinh
    FROM LopHP lhp
    JOIN DIEMTHI dt ON lhp.MaLopHP = dt.MaLopHP
    GROUP BY lhp.MaLopHP, lhp.TenHP, lhp.SoTC
    HAVING AVG(dt.DiemThi) > p_DiemTB
    ORDER BY DiemTrungBinh DESC;
END //
DELIMITER ;

-- Procedure tìm học phần theo số tín chỉ
DELIMITER //
CREATE PROCEDURE sp_HocPhanTheoSoTC(
    IN p_SoTC INT
)
BEGIN
    SELECT 
        MaLopHP,
        TenHP,
        SoTC
    FROM LopHP 
    WHERE SoTC = p_SoTC
    ORDER BY TenHP;
END //
DELIMITER ;

-- =====================================================
-- 8. TẠO FUNCTION
-- =====================================================

-- Function tính điểm trung bình của sinh viên
DELIMITER //
CREATE FUNCTION fn_DiemTrungBinhSV(p_MaSV VARCHAR(10))
RETURNS DECIMAL(4,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_DiemTB DECIMAL(4,2) DEFAULT 0;
    
    SELECT AVG(DiemThi) INTO v_DiemTB
    FROM DIEMTHI
    WHERE MaSV = p_MaSV;
    
    RETURN COALESCE(v_DiemTB, 0);
END //
DELIMITER ;

-- Function xếp loại sinh viên
DELIMITER //
CREATE FUNCTION fn_XepLoaiSinhVien(p_MaSV VARCHAR(10))
RETURNS VARCHAR(20)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_DiemTB DECIMAL(4,2);
    DECLARE v_XepLoai VARCHAR(20);
    
    SELECT fn_DiemTrungBinhSV(p_MaSV) INTO v_DiemTB;
    
    IF v_DiemTB >= 8.5 THEN
        SET v_XepLoai = 'Giỏi';
    ELSEIF v_DiemTB >= 7.0 THEN
        SET v_XepLoai = 'Khá';
    ELSEIF v_DiemTB >= 5.5 THEN
        SET v_XepLoai = 'Trung bình';
    ELSEIF v_DiemTB >= 4.0 THEN
        SET v_XepLoai = 'Yếu';
    ELSE
        SET v_XepLoai = 'Kém';
    END IF;
    
    RETURN v_XepLoai;
END //
DELIMITER ;

-- =====================================================
-- 9. TẠO TRIGGER
-- =====================================================

-- Trigger kiểm tra điểm thi khi insert/update
DELIMITER //
CREATE TRIGGER tr_KiemTraDiemThi
BEFORE INSERT ON DIEMTHI
FOR EACH ROW
BEGIN
    -- Kiểm tra điểm thi trong khoảng 0-10
    IF NEW.DiemThi < 0 OR NEW.DiemThi > 10 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Điểm thi phải trong khoảng 0-10';
    END IF;
    
    -- Tự động set ngày thi nếu NULL
    IF NEW.NgayThi IS NULL THEN
        SET NEW.NgayThi = CURDATE();
    END IF;
END //
DELIMITER ;

-- =====================================================
-- 10. KIỂM TRA DỮ LIỆU
-- =====================================================

-- Kiểm tra số lượng bản ghi
SELECT 'SINHVIEN' AS Bang, COUNT(*) AS SoBanGhi FROM SINHVIEN
UNION ALL
SELECT 'LopHP' AS Bang, COUNT(*) AS SoBanGhi FROM LopHP
UNION ALL
SELECT 'DIEMTHI' AS Bang, COUNT(*) AS SoBanGhi FROM DIEMTHI;

-- Kiểm tra tính toàn vẹn dữ liệu
SELECT 
    'Điểm thi ngoài khoảng 0-10' AS VanDe,
    COUNT(*) AS SoLuong
FROM DIEMTHI 
WHERE DiemThi < 0 OR DiemThi > 10;

-- =====================================================
-- 11. CÁC TRUY VẤN KIỂM TRA TÍNH NĂNG (THEO ĐỀ BÀI)
-- =====================================================

-- a1. Tên sinh viên thuộc LopHC = 'K60S1'
SELECT TenSV 
FROM SINHVIEN 
WHERE LopHC = 'K60S1';

-- a2. Thông tin lớp học phần có điểm thi trung bình > 6.5
SELECT L.MaLopHP, L.TenHP, L.SoTC, AVG(D.DiemThi) as DiemTrungBinh
FROM LopHP L
JOIN DIEMTHI D ON L.MaLopHP = D.MaLopHP
GROUP BY L.MaLopHP, L.TenHP, L.SoTC
HAVING AVG(D.DiemThi) > 6.5;

-- b1. Tên các học phần có SoTC = 3 (Đại số quan hệ)
-- π TenHP (σ SoTC=3 (LopHP))
SELECT TenHP 
FROM LopHP 
WHERE SoTC = 3;

-- b2. Danh sách MaSV, TenSV, MaLopHP, TenHP, SoTC, DiemThi
-- π MaSV,TenSV,MaLopHP,TenHP,SoTC,DiemThi (SINHVIEN ⨝ DIEMTHI ⨝ LopHP)
SELECT sv.MaSV, sv.TenSV, lhp.MaLopHP, lhp.TenHP, lhp.SoTC, dt.DiemThi
FROM SINHVIEN sv
JOIN DIEMTHI dt ON sv.MaSV = dt.MaSV
JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP;

-- b3. Tổng số tín chỉ mà mỗi sinh viên đã học
-- γ MaSV,TenSV; SUM(SoTC) (SINHVIEN ⨝ DIEMTHI ⨝ LopHP)
SELECT sv.MaSV, sv.TenSV, SUM(lhp.SoTC) AS TongSoTC
FROM SINHVIEN sv
JOIN DIEMTHI dt ON sv.MaSV = dt.MaSV
JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP
GROUP BY sv.MaSV, sv.TenSV;

-- Kiểm tra các View
SELECT * FROM v_ThongKeLopHC;

PRINT 'Cấu trúc CSDL Quản lý điểm sinh viên đã được tạo thành công!';

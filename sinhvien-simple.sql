-- =====================================================
-- HỆ THỐNG QUẢN LÝ ĐIỂM SINH VIÊN - CẤU TRÚC ĐỠN GIẢN
-- =====================================================

-- Xóa các bảng nếu đã tồn tại
DROP TABLE IF EXISTS DIEMTHI;
DROP TABLE IF EXISTS LopHP;
DROP TABLE IF EXISTS SINHVIEN;

-- =====================================================
-- 1. TẠO BẢNG SINHVIEN
-- =====================================================
CREATE TABLE SINHVIEN (
    MaSV VARCHAR(10) PRIMARY KEY,
    TenSV VARCHAR(50) NOT NULL,
    LopHC VARCHAR(10)
);

-- =====================================================
-- 2. TẠO BẢNG LopHP (LỚP HỌC PHẦN)
-- =====================================================
CREATE TABLE LopHP (
    MaLopHP VARCHAR(10) PRIMARY KEY,
    TenHP VARCHAR(50) NOT NULL,
    SoTC INT
);

-- =====================================================
-- 3. TẠO BẢNG DIEMTHI
-- =====================================================
CREATE TABLE DIEMTHI (
    MaSV VARCHAR(10),
    MaLopHP VARCHAR(10),
    DiemThi DECIMAL(4,2),
    PRIMARY KEY (MaSV, MaLopHP),
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV),
    FOREIGN KEY (MaLopHP) REFERENCES LopHP(MaLopHP)
);

-- =====================================================
-- 4. THÊM DỮ LIỆU MẪU
-- =====================================================

-- Thêm sinh viên
INSERT INTO SINHVIEN VALUES
('SV001', 'Nguyen Van A', 'K60S1'),
('SV002', 'Tran Thi B', 'K60S1'),
('SV003', 'Le Van C', 'K60S2'),
('SV004', 'Pham Thi D', 'K60S1'),
('SV005', 'Hoang Van E', 'K60S2');

-- Thêm lớp học phần
INSERT INTO LopHP VALUES
('LHP001', 'Co so du lieu', 3),
('LHP002', 'Lap trinh Java', 4),
('LHP003', 'Toan cao cap', 3),
('LHP004', 'Tieng Anh', 2),
('LHP005', 'Mang may tinh', 3);

-- Thêm điểm thi
INSERT INTO DIEMTHI VALUES
('SV001', 'LHP001', 7.5),
('SV001', 'LHP002', 8.0),
('SV002', 'LHP001', 9.0),
('SV002', 'LHP003', 7.0),
('SV003', 'LHP001', 5.5),
('SV003', 'LHP002', 6.0),
('SV004', 'LHP001', 8.5),
('SV004', 'LHP004', 9.0),
('SV005', 'LHP002', 6.5),
('SV005', 'LHP005', 7.5);

-- =====================================================
-- 5. CÁC TRUY VẤN THEO ĐỀ BÀI
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

-- b1. Tên các học phần có SoTC = 3
SELECT TenHP 
FROM LopHP 
WHERE SoTC = 3;

-- b2. Danh sách MaSV, TenSV, MaLopHP, TenHP, SoTC, DiemThi
SELECT sv.MaSV, sv.TenSV, lhp.MaLopHP, lhp.TenHP, lhp.SoTC, dt.DiemThi
FROM SINHVIEN sv
JOIN DIEMTHI dt ON sv.MaSV = dt.MaSV
JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP;

-- b3. Tổng số tín chỉ mà mỗi sinh viên đã học
SELECT sv.MaSV, sv.TenSV, SUM(lhp.SoTC) AS TongSoTC
FROM SINHVIEN sv
JOIN DIEMTHI dt ON sv.MaSV = dt.MaSV
JOIN LopHP lhp ON dt.MaLopHP = lhp.MaLopHP
GROUP BY sv.MaSV, sv.TenSV;

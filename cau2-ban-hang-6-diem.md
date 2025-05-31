# Câu 2: Quản lý bán hàng (6 điểm)

## Mô tả bài toán

Cho lược đồ CSDL quản lý bán hàng bao gồm 3 bảng (KH: Khách hàng, HH: hàng hóa, BAN: bán) sau:

### Lược đồ quan hệ:
- **KH**(MaKH, TenKH, DiaChi)
- **HH**(MaHH, TenHH, Nuocsx, Gia)  
- **BAN**(MaKH, MaHH, Soluong, ThanhTien)

## Tạo cấu trúc SQL (DDL - Data Definition Language)

### 1. Tạo bảng KH (Khách hàng)
```sql
CREATE TABLE KH (
    MaKH VARCHAR(10) PRIMARY KEY,
    TenKH NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200)
);
```

### 2. Tạo bảng HH (Hàng hóa)
```sql
CREATE TABLE HH (
    MaHH VARCHAR(10) PRIMARY KEY,
    TenHH NVARCHAR(100) NOT NULL,
    Nuocsx NVARCHAR(50),
    Gia DECIMAL(15,2) CHECK (Gia >= 0)
);
```

### 3. Tạo bảng BAN (Giao dịch bán hàng)
```sql
CREATE TABLE BAN (
    MaKH VARCHAR(10),
    MaHH VARCHAR(10),
    Soluong INT CHECK (Soluong > 0),
    ThanhTien DECIMAL(15,2) CHECK (ThanhTien >= 0),
    PRIMARY KEY (MaKH, MaHH),
    FOREIGN KEY (MaKH) REFERENCES KH(MaKH),
    FOREIGN KEY (MaHH) REFERENCES HH(MaHH)
);
```

### 4. Thêm dữ liệu mẫu (DML - Data Manipulation Language)

#### Thêm dữ liệu bảng KH:
```sql
INSERT INTO KH (MaKH, TenKH, DiaChi) VALUES
('KH001', N'Nguyễn Văn An', N'Hà Nội'),
('KH002', N'Trần Thị Bình', N'TP.HCM'),
('KH003', N'Lê Văn Cường', N'Hà Nội'),
('KH004', N'Phạm Thị Dung', N'Đà Nẵng'),
('KH005', N'Hoàng Văn Em', N'Hà Nội');
```

#### Thêm dữ liệu bảng HH:
```sql
INSERT INTO HH (MaHH, TenHH, Nuocsx, Gia) VALUES
('HH001', N'Áo sơ mi nam', N'Việt nam', 150.00),
('HH002', N'Quần jean nữ', N'Thái Lan', 250.00),
('HH003', N'Giày thể thao', N'Trung Quốc', 180.00),
('HH004', N'Túi xách da', N'Việt nam', 120.00),
('HH005', N'Đồng hồ đeo tay', N'Nhật Bản', 500.00),
('HH006', N'Điện thoại', N'Hàn Quốc', 800.00),
('HH007', N'Laptop', N'Việt nam', 1500.00);
```

#### Thêm dữ liệu bảng BAN:
```sql
INSERT INTO BAN (MaKH, MaHH, Soluong, ThanhTien) VALUES
('KH001', 'HH001', 60, 9000.00),   -- 60 * 150
('KH001', 'HH004', 20, 2400.00),   -- 20 * 120
('KH002', 'HH002', 10, 2500.00),   -- 10 * 250
('KH002', 'HH005', 5, 2500.00),    -- 5 * 500
('KH003', 'HH001', 30, 4500.00),   -- 30 * 150
('KH003', 'HH003', 25, 4500.00),   -- 25 * 180
('KH004', 'HH006', 3, 2400.00),    -- 3 * 800
('KH005', 'HH007', 2, 3000.00);    -- 2 * 1500
```

### 5. Tạo Index để tối ưu hóa truy vấn
```sql
-- Index cho tìm kiếm theo địa chỉ khách hàng
CREATE INDEX idx_kh_diachi ON KH(DiaChi);

-- Index cho tìm kiếm theo nước sản xuất và giá
CREATE INDEX idx_hh_nuocsx_gia ON HH(Nuocsx, Gia);

-- Index cho tìm kiếm theo số lượng
CREATE INDEX idx_ban_soluong ON BAN(Soluong);
```

### 6. Tạo View để thuận tiện truy vấn
```sql
-- View chi tiết giao dịch bán hàng
CREATE VIEW v_ChiTietBanHang AS
SELECT 
    k.MaKH,
    k.TenKH,
    k.DiaChi,
    h.MaHH,
    h.TenHH,
    h.Nuocsx,
    h.Gia,
    b.Soluong,
    b.ThanhTien,
    (b.Soluong * h.Gia) AS TinhToan_ThanhTien
FROM KH k
JOIN BAN b ON k.MaKH = b.MaKH
JOIN HH h ON b.MaHH = h.MaHH;
```

### Mối quan hệ giữa các bảng:
- KH và BAN: liên kết qua khóa ngoại MaKH
- BAN và HH: liên kết qua khóa ngoại MaHH
- Mỗi khách hàng có thể mua nhiều loại hàng hóa
- Mỗi loại hàng hóa có thể được nhiều khách hàng mua

## Phần a) Sử dụng ngôn ngữ SQL

### 1. Đưa ra mã hàng hóa, tên hàng hóa, giá của các sản phẩm có giá từ 50 đến 200 và có xuất xứ (Nuocsx) là 'Việt nam'

**Câu truy vấn:**
```sql
SELECT MaHH, TenHH, Gia 
FROM HH 
WHERE Gia BETWEEN 50 AND 200 
  AND Nuocsx = 'Việt nam';
```

**Giải thích:**
- SELECT MaHH, TenHH, Gia: Chọn các cột cần thiết
- FROM HH: Từ bảng hàng hóa
- WHERE Gia BETWEEN 50 AND 200: Lọc sản phẩm có giá từ 50 đến 200
- AND Nuocsx = 'Việt nam': Và có xuất xứ từ Việt Nam

### 2. Đưa ra đầy đủ thông tin về các khách hàng đã mua hàng hóa có tổng tiền >2.000.000

**Câu truy vấn:**
```sql
SELECT K.MaKH, K.TenKH, K.DiaChi
FROM KH K
JOIN BAN B ON K.MaKH = B.MaKH
GROUP BY K.MaKH, K.TenKH, K.DiaChi
HAVING SUM(B.ThanhTien) > 2000000;
```

**Giải thích:**
- JOIN bảng KH và BAN qua MaKH
- GROUP BY để nhóm theo từng khách hàng
- SUM(B.ThanhTien) để tính tổng tiền mua hàng
- HAVING để lọc khách hàng có tổng tiền > 2.000.000

## Phần b) Sử dụng ngôn ngữ đại số quan hệ

### 1. Đưa ra danh sách các khách hàng có địa chỉ ở Hà Nội và mua với Soluong>=50

**Biểu thức đại số quan hệ:**
```
π MaKH,TenKH,DiaChi (σ DiaChi='Hà Nội' (KH) ⨝ σ Soluong>=50 (BAN))
```

**Giải thích:**
- σ DiaChi='Hà Nội' (KH): Chọn khách hàng ở Hà Nội
- σ Soluong>=50 (BAN): Chọn các giao dịch có số lượng >= 50
- ⨝: Kết nối hai kết quả trên qua MaKH
- π MaKH,TenKH,DiaChi: Chiếu các cột cần thiết

### 2. Đưa ra một danh sách bao gồm: MaKH, TenKH, MaHH, TenHH, Soluong, ThanhTien, trong đó ThanhTien=Soluong*Gia

**Biểu thức đại số quan hệ:**
```
π MaKH,TenKH,MaHH,TenHH,Soluong,ThanhTien (KH ⨝ BAN ⨝ HH)
```

**Giải thích:**
- KH ⨝ BAN: Kết nối bảng khách hàng và bán hàng qua MaKH
- (KH ⨝ BAN) ⨝ HH: Tiếp tục kết nối với bảng hàng hóa qua MaHH
- π MaKH,TenKH,MaHH,TenHH,Soluong,ThanhTien: Chiếu các cột cần thiết
- ThanhTien đã được tính sẵn trong bảng BAN (= Soluong * Gia)

### 3. Thống kê tổng số lượng của các hàng hóa đã được bán theo DiaChi

**Biểu thức đại số quan hệ:**
```
γ DiaChi; SUM(Soluong) (KH ⨝ BAN ⨝ HH)
```

**Giải thích:**
- KH ⨝ BAN ⨝ HH: Kết nối ba bảng để có thông tin đầy đủ
- γ DiaChi; SUM(Soluong): Nhóm theo địa chỉ và tính tổng số lượng bán
- Kết quả cho biết tổng số lượng hàng hóa đã bán ở mỗi địa chỉ

## Ghi chú về ký hiệu đại số quan hệ

- **π** (pi): Phép chiếu (projection) - lấy ra các cột cần thiết
- **σ** (sigma): Phép chọn (selection) - lọc các hàng thỏa mãn điều kiện
- **⨝** (bowtie): Phép kết nối tự nhiên (natural join) - kết nối các bảng
- **γ** (gamma): Phép nhóm và tính toán tổng hợp (group by và aggregate)
- **SUM()**: Hàm tổng
- **BETWEEN**: Toán tử khoảng giá trị

## Lưu ý quan trọng

### Về SQL:
- BETWEEN bao gồm cả hai giá trị biên (50 và 200)
- Sử dụng JOIN để kết nối các bảng
- GROUP BY khi sử dụng hàm tổng hợp
- HAVING để lọc sau khi nhóm (thay vì WHERE)
- So sánh chuỗi cần chính xác về dấu cách và viết hoa/thường

### Về đại số quan hệ:
- Thứ tự thực hiện: từ trong ra ngoài
- Có thể kết hợp nhiều điều kiện selection
- KH và BAN kết nối qua MaKH
- BAN và HH kết nối qua MaHH
- ThanhTien = Soluong * Gia (đã được tính sẵn trong bảng BAN)

## Kết quả mong đợi

### Câu a1: Hàng hóa Việt Nam giá 50-200
Kết quả sẽ bao gồm: Mã HH, Tên HH, Giá của những sản phẩm Việt Nam có giá từ 50 đến 200.

### Câu a2: Khách hàng mua >2 triệu
Kết quả là thông tin đầy đủ của khách hàng có tổng giá trị mua hàng > 2.000.000.

### Câu b1: Khách HN mua số lượng lớn
Kết quả là danh sách khách hàng ở Hà Nội và có giao dịch mua ít nhất 50 sản phẩm.

### Câu b2: Thông tin chi tiết giao dịch
Kết quả là bảng tổng hợp thông tin từ cả 3 bảng với ThanhTien = Soluong * Gia.

### Câu b3: Thống kê theo địa chỉ
Kết quả cho biết tổng số lượng hàng hóa đã bán ở mỗi địa chỉ.

## Ví dụ dữ liệu mẫu

### Bảng KH (Khách hàng):
| MaKH | TenKH        | DiaChi |
| ---- | ------------ | ------ |
| KH01 | Nguyễn Văn A | Hà Nội |
| KH02 | Trần Thị B   | TP.HCM |

### Bảng HH (Hàng hóa):
| MaHH | TenHH     | Nuocsx   | Gia |
| ---- | --------- | -------- | --- |
| HH01 | Áo sơ mi  | Việt nam | 150 |
| HH02 | Quần jean | Thái Lan | 300 |

### Bảng BAN:
| MaKH | MaHH | Soluong | ThanhTien |
| ---- | ---- | ------- | --------- |
| KH01 | HH01 | 60      | 9000      |
| KH02 | HH02 | 10      | 3000      |

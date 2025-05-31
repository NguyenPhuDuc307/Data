# Câu 2: Quản lý điểm sinh viên (6 điểm)

## Mô tả bài toán

Cho lược đồ CSDL quản lý điểm của sinh viên bao gồm 3 bảng: SINHVIEN, LopHP (lớp học phần), DIEMTHI sau:

### Lược đồ quan hệ:
- **SINHVIEN**(MaSV, TenSV, LopHC)
- **LopHP**(MaLopHP, TenHP, SoTC)  
- **DIEMTHI**(MaSV, MaLopHP, DiemThi)

### Mối quan hệ giữa các bảng:
- SINHVIEN và DIEMTHI: liên kết qua khóa ngoại MaSV
- DIEMTHI và LopHP: liên kết qua khóa ngoại MaLopHP
- Mỗi sinh viên có thể thi nhiều lớp học phần
- Mỗi lớp học phần có thể có nhiều sinh viên thi

## Phần a) Sử dụng ngôn ngữ SQL

### 1. Đưa ra danh sách tên sinh viên thuộc LopHC = 'K60S1'

**Câu truy vấn:**
```sql
SELECT TenSV 
FROM SINHVIEN 
WHERE LopHC = 'K60S1';
```

**Giải thích:**
- Sử dụng câu lệnh SELECT để chọn cột TenSV
- FROM SINHVIEN để xác định bảng nguồn
- WHERE LopHC = 'K60S1' để lọc sinh viên thuộc lớp hành chính K60S1

### 2. Đưa ra thông tin về lớp học phần có điểm thi trung bình > 6.5

**Câu truy vấn:**
```sql
SELECT L.MaLopHP, L.TenHP, L.SoTC, AVG(D.DiemThi) as DiemTrungBinh
FROM LopHP L
JOIN DIEMTHI D ON L.MaLopHP = D.MaLopHP
GROUP BY L.MaLopHP, L.TenHP, L.SoTC
HAVING AVG(D.DiemThi) > 6.5;
```

**Giải thích:**
- JOIN hai bảng LopHP và DIEMTHI qua MaLopHP
- GROUP BY để nhóm theo từng lớp học phần
- AVG(D.DiemThi) để tính điểm trung bình
- HAVING để lọc các nhóm có điểm trung bình > 6.5
- Alias L và D để viết gọn hơn

## Phần b) Sử dụng ngôn ngữ đại số quan hệ

### 1. Đưa ra danh sách tên các học phần có SoTC = 3

**Biểu thức đại số quan hệ:**
```
π TenHP (σ SoTC=3 (LopHP))
```

**Giải thích:**
- σ SoTC=3 (LopHP): Chọn các bản ghi từ bảng LopHP có SoTC = 3
- π TenHP: Chiếu (lấy) cột TenHP từ kết quả trên

### 2. Đưa ra một danh sách bao gồm: MaSV, TenSV, MaLopHP, TenHP, SoTC, DiemThi

**Biểu thức đại số quan hệ:**
```
π MaSV,TenSV,MaLopHP,TenHP,SoTC,DiemThi (SINHVIEN ⨝ DIEMTHI ⨝ LopHP)
```

**Giải thích:**
- SINHVIEN ⨝ DIEMTHI: Kết nối tự nhiên hai bảng qua MaSV
- (SINHVIEN ⨝ DIEMTHI) ⨝ LopHP: Tiếp tục kết nối với bảng LopHP qua MaLopHP
- π MaSV,TenSV,MaLopHP,TenHP,SoTC,DiemThi: Chiếu các cột cần thiết

### 3. Thống kê tổng số tín chỉ mà mỗi sinh viên đã học

**Biểu thức đại số quan hệ:**
```
γ MaSV,TenSV; SUM(SoTC) (SINHVIEN ⨝ DIEMTHI ⨝ LopHP)
```

**Giải thích:**
- SINHVIEN ⨝ DIEMTHI ⨝ LopHP: Kết nối ba bảng để có đầy đủ thông tin
- γ MaSV,TenSV; SUM(SoTC): Nhóm theo MaSV, TenSV và tính tổng SoTC
- Kết quả sẽ cho biết tổng số tín chỉ mỗi sinh viên đã học

## Ghi chú về ký hiệu đại số quan hệ

- **π** (pi): Phép chiếu (projection) - lấy ra các cột cần thiết
- **σ** (sigma): Phép chọn (selection) - lọc các hàng thỏa mãn điều kiện
- **⨝** (bowtie): Phép kết nối tự nhiên (natural join) - kết nối các bảng
- **γ** (gamma): Phép nhóm và tính toán tổng hợp (group by và aggregate)
- **SUM()**: Hàm tổng
- **AVG()**: Hàm trung bình

## Lưu ý quan trọng

### Về SQL:
- Sử dụng JOIN để kết nối các bảng
- GROUP BY khi sử dụng hàm tổng hợp
- HAVING để lọc sau khi nhóm (thay vì WHERE)
- Alias giúp viết câu truy vấn gọn hơn

### Về đại số quan hệ:
- Thứ tự thực hiện: từ trong ra ngoài
- Kết nối tự nhiên tự động dựa trên tên cột giống nhau
- SINHVIEN và DIEMTHI kết nối qua MaSV
- DIEMTHI và LopHP kết nối qua MaLopHP
- Phép chiếu π luôn thực hiện cuối cùng để lấy kết quả mong muốn

## Kết quả mong đợi

### Câu a1: Danh sách tên sinh viên lớp K60S1
Kết quả sẽ là một cột chứa tên các sinh viên thuộc lớp hành chính K60S1.

### Câu a2: Thông tin lớp học phần có điểm TB > 6.5
Kết quả sẽ bao gồm: Mã lớp HP, Tên HP, Số TC, Điểm trung bình của những lớp có điểm TB > 6.5.

### Câu b1: Tên học phần có 3 tín chỉ
Kết quả là danh sách tên các học phần có đúng 3 tín chỉ.

### Câu b2: Thông tin chi tiết sinh viên-học phần
Kết quả là bảng tổng hợp thông tin từ cả 3 bảng với các cột đã chỉ định.

### Câu b3: Tổng tín chỉ mỗi sinh viên
Kết quả cho biết mỗi sinh viên đã học tổng cộng bao nhiêu tín chỉ.

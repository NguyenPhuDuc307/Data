# Kiến thức về Đại số Quan hệ (Relational Algebra)

## Tổng quan

Đại số quan hệ là ngôn ngữ truy vấn hình thức được sử dụng để thao tác với cơ sở dữ liệu quan hệ. Nó bao gồm một tập hợp các phép toán được áp dụng lên các quan hệ (bảng) để tạo ra các quan hệ mới.

## 1. Các phép toán cơ bản (Basic Operations)

### 1.1. Phép chọn (Selection) - σ (sigma)

**Ký hiệu:** σ

**Mục đích:** Lọc các hàng (tuple) thỏa mãn điều kiện từ một quan hệ

**Cú pháp:** σ<sub>điều_kiện</sub>(Quan_hệ)

**Ví dụ:**
```
σ Gia>100 (HangHoa)
σ DiaChi='Hà Nội' (KhachHang)
σ Gia>=50 AND Gia<=200 (HangHoa)
σ Nuocsx='Việt nam' OR Nuocsx='Thái Lan' (HangHoa)
```

**Các toán tử điều kiện:**
- `=`, `≠`, `<`, `>`, `≤`, `≥`
- `AND` (∧), `OR` (∨), `NOT` (¬)

### 1.2. Phép chiếu (Projection) - π (pi)

**Ký hiệu:** π

**Mục đích:** Lấy ra các cột cụ thể từ một quan hệ

**Cú pháp:** π<sub>danh_sách_cột</sub>(Quan_hệ)

**Ví dụ:**
```
π MaKH,TenKH (KhachHang)
π TenHH,Gia (HangHoa)
π MaKH (BanHang)
```

**Lưu ý:** Phép chiếu tự động loại bỏ các hàng trùng lặp

### 1.3. Phép kết nối tự nhiên (Natural Join) - ⨝

**Ký hiệu:** ⨝ (bowtie)

**Mục đích:** Kết nối hai quan hệ dựa trên các cột có tên giống nhau

**Cú pháp:** Quan_hệ_1 ⨝ Quan_hệ_2

**Ví dụ:**
```
KhachHang ⨝ BanHang
BanHang ⨝ HangHoa
KhachHang ⨝ BanHang ⨝ HangHoa
```

### 1.4. Phép hợp (Union) - ∪

**Ký hiệu:** ∪

**Mục đích:** Kết hợp hai quan hệ có cùng lược đồ

**Cú pháp:** Quan_hệ_1 ∪ Quan_hệ_2

**Ví dụ:**
```
KhachHangHN ∪ KhachHangHCM
```

**Điều kiện:** Hai quan hệ phải có cùng số cột và kiểu dữ liệu tương ứng

### 1.5. Phép hiệu (Difference) - −

**Ký hiệu:** − hoặc \

**Mục đích:** Lấy các hàng có trong quan hệ thứ nhất nhưng không có trong quan hệ thứ hai

**Cú pháp:** Quan_hệ_1 − Quan_hệ_2

**Ví dụ:**
```
TatCaKhachHang − KhachHangDaMua
```

### 1.6. Phép giao (Intersection) - ∩

**Ký hiệu:** ∩

**Mục đích:** Lấy các hàng có trong cả hai quan hệ

**Cú pháp:** Quan_hệ_1 ∩ Quan_hệ_2

**Ví dụ:**
```
KhachHangHN ∩ KhachHangVIP
```

### 1.7. Phép tích Cartesian (Cartesian Product) - ×

**Ký hiệu:** ×

**Mục đích:** Kết hợp mọi hàng của quan hệ thứ nhất với mọi hàng của quan hệ thứ hai

**Cú pháp:** Quan_hệ_1 × Quan_hệ_2

**Ví dụ:**
```
KhachHang × HangHoa
```

## 2. Các phép toán mở rộng (Extended Operations)

### 2.1. Phép đổi tên (Rename) - ρ (rho)

**Ký hiệu:** ρ

**Mục đích:** Đổi tên quan hệ hoặc thuộc tính

**Cú pháp:** 
- ρ<sub>tên_mới</sub>(Quan_hệ)
- ρ<sub>tên_mới(danh_sách_cột)</sub>(Quan_hệ)

**Ví dụ:**
```
ρ KH(KhachHang)
ρ KH(MaKH,Ten,Dia_Chi)(KhachHang)
```

### 2.2. Phép gán (Assignment) - ←

**Ký hiệu:** ←

**Mục đích:** Gán kết quả của một biểu thức cho một biến

**Cú pháp:** Biến ← Biểu_thức

**Ví dụ:**
```
KH_HN ← σ DiaChi='Hà Nội' (KhachHang)
ChiTiet ← KhachHang ⨝ BanHang ⨝ HangHoa
```

### 2.3. Phép nhóm và tổng hợp (Grouping) - γ (gamma)

**Ký hiệu:** γ

**Mục đích:** Nhóm các hàng theo một hoặc nhiều cột và thực hiện các hàm tổng hợp

**Cú pháp:** γ<sub>cột_nhóm; hàm_tổng_hợp(cột)</sub>(Quan_hệ)

**Các hàm tổng hợp:**
- `SUM()`: Tổng
- `COUNT()`: Đếm
- `AVG()`: Trung bình
- `MAX()`: Giá trị lớn nhất
- `MIN()`: Giá trị nhỏ nhất

**Ví dụ:**
```
γ DiaChi; COUNT(*) (KhachHang)
γ MaKH; SUM(ThanhTien) (BanHang)
γ Nuocsx; COUNT(*),AVG(Gia) (HangHoa)
```

### 2.4. Phép kết nối có điều kiện (Theta Join) - ⨝<sub>θ</sub>

**Ký hiệu:** ⨝<sub>θ</sub>

**Mục đích:** Kết nối hai quan hệ với điều kiện tùy chỉnh

**Cú pháp:** Quan_hệ_1 ⨝<sub>điều_kiện</sub> Quan_hệ_2

**Ví dụ:**
```
KhachHang ⨝ KhachHang.MaKH=BanHang.MaKH BanHang
HangHoa ⨝ HangHoa.Gia>100 BanHang
```

### 2.5. Phép kết nối ngoài (Outer Join)

**Ký hiệu:** 
- ⟕ (Left Outer Join)
- ⟖ (Right Outer Join)  
- ⟗ (Full Outer Join)

**Mục đích:** Giữ lại các hàng không có cặp trong phép kết nối

**Ví dụ:**
```
KhachHang ⟕ BanHang    // Giữ tất cả khách hàng
BanHang ⟖ HangHoa      // Giữ tất cả hàng hóa
KhachHang ⟗ BanHang    // Giữ tất cả
```

## 3. Thứ tự ưu tiên các phép toán

1. **Phép chọn σ và phép chiếu π** (ưu tiên cao nhất)
2. **Phép tích Cartesian ×, phép kết nối ⨝**
3. **Phép giao ∩**
4. **Phép hợp ∪, phép hiệu −**

## 4. Ví dụ thực tế với CSDL bán hàng

Cho 3 bảng:
- **KH**(MaKH, TenKH, DiaChi)
- **HH**(MaHH, TenHH, Nuocsx, Gia)
- **BAN**(MaKH, MaHH, Soluong, ThanhTien)

### Ví dụ 1: Tìm tên khách hàng ở Hà Nội
```
π TenKH (σ DiaChi='Hà Nội' (KH))
```

### Ví dụ 2: Tìm hàng hóa Việt Nam có giá từ 50-200
```
π MaHH,TenHH,Gia (σ Nuocsx='Việt nam' AND Gia>=50 AND Gia<=200 (HH))
```

### Ví dụ 3: Thông tin chi tiết giao dịch
```
π MaKH,TenKH,MaHH,TenHH,Soluong,ThanhTien (KH ⨝ BAN ⨝ HH)
```

### Ví dụ 4: Khách hàng Hà Nội mua số lượng >= 50
```
π MaKH,TenKH,DiaChi (σ DiaChi='Hà Nội' (KH) ⨝ σ Soluong>=50 (BAN))
```

### Ví dụ 5: Thống kê tổng số lượng theo địa chỉ
```
γ DiaChi; SUM(Soluong) (KH ⨝ BAN ⨝ HH)
```

### Ví dụ 6: Khách hàng có tổng tiền mua > 2.000.000
```
π MaKH,TenKH,DiaChi (σ TongTien>2000000 (γ MaKH,TenKH,DiaChi; SUM(ThanhTien) AS TongTien (KH ⨝ BAN)))
```

## 5. So sánh với SQL

| Đại số quan hệ | SQL          | Mô tả            |
| -------------- | ------------ | ---------------- |
| σ              | WHERE        | Lọc dữ liệu      |
| π              | SELECT       | Chọn cột         |
| ⨝              | JOIN         | Kết nối bảng     |
| ∪              | UNION        | Hợp              |
| −              | EXCEPT/MINUS | Hiệu             |
| ∩              | INTERSECT    | Giao             |
| γ              | GROUP BY     | Nhóm và tổng hợp |
| ρ              | AS           | Đổi tên          |

## 6. Quy tắc viết đại số quan hệ

### 6.1. Quy tắc cơ bản:
- Viết từ trong ra ngoài (theo thứ tự thực hiện)
- Sử dụng dấu ngoặc để rõ ràng về thứ tự
- Tên quan hệ viết hoa
- Tên thuộc tính viết thường hoặc theo quy ước

### 6.2. Ví dụ về thứ tự thực hiện:
```
π TenKH (σ DiaChi='Hà Nội' (KH))
```
Thực hiện:
1. σ DiaChi='Hà Nội' (KH) - Lọc khách hàng Hà Nội
2. π TenKH - Lấy tên khách hàng

### 6.3. Biểu thức phức tạp:
```
π MaKH,TenKH (σ TongTien>2000000 (γ MaKH,TenKH; SUM(ThanhTien) AS TongTien (KH ⨝ BAN)))
```
Thực hiện:
1. KH ⨝ BAN - Kết nối bảng
2. γ MaKH,TenKH; SUM(ThanhTien) - Nhóm và tính tổng
3. σ TongTien>2000000 - Lọc theo điều kiện
4. π MaKH,TenKH - Chọn cột kết quả

## 7. Các lưu ý quan trọng

### 7.1. Tính chất của các phép toán:
- **Phép chọn σ**: Có thể hoán vị σ<sub>c1</sub>(σ<sub>c2</sub>(R)) = σ<sub>c2</sub>(σ<sub>c1</sub>(R))
- **Phép chiếu π**: Không có tính chất hoán vị
- **Phép kết nối ⨝**: Có tính chất hoán vị và kết hợp

### 7.2. Tối ưu hóa:
- Thực hiện phép chọn σ càng sớm càng tốt
- Thực hiện phép chiếu π sau các phép khác
- Kết hợp các phép chọn: σ<sub>c1 AND c2</sub>(R) = σ<sub>c1</sub>(σ<sub>c2</sub>(R))

### 7.3. Xử lý giá trị NULL:
- Các phép so sánh với NULL cho kết quả UNKNOWN
- Cần xử lý đặc biệt trong các phép toán

## 8. Bài tập thực hành

### Cho lược đồ:
- **SINHVIEN**(MaSV, TenSV, Lop, Tuoi)
- **MONHOC**(MaMH, TenMH, SoTC)
- **DIEM**(MaSV, MaMH, Diem)

### Câu hỏi:
1. Tìm tên sinh viên lớp "K60"
2. Tìm môn học có 3 tín chỉ
3. Tìm sinh viên có điểm > 8
4. Thông tin chi tiết điểm của sinh viên
5. Thống kê số sinh viên theo lớp

### Lời giải:
```
1. π TenSV (σ Lop='K60' (SINHVIEN))

2. π TenMH (σ SoTC=3 (MONHOC))

3. π MaSV,TenSV (SINHVIEN ⨝ σ Diem>8 (DIEM))

4. π MaSV,TenSV,MaMH,TenMH,Diem (SINHVIEN ⨝ DIEM ⨝ MONHOC)

5. γ Lop; COUNT(*) (SINHVIEN)
```

## Kết luận

Đại số quan hệ là nền tảng lý thuyết quan trọng của cơ sở dữ liệu quan hệ. Hiểu rõ các ký hiệu và phép toán sẽ giúp:
- Thiết kế truy vấn hiệu quả
- Tối ưu hóa câu lệnh SQL
- Phân tích và giải quyết các bài toán cơ sở dữ liệu phức tạp

Đại số quan hệ cung cấp cách tiếp cận hình thức và chính xác để thao tác với dữ liệu, là kiến thức cơ bản mà mọi người học cơ sở dữ liệu cần nắm vững.

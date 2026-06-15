# FreshMart — E-Commerce với Chữ Ký Số

Web bán hàng thực phẩm tươi sống tích hợp cơ chế **ký số RSA** để xác thực tính toàn vẹn đơn hàng. Người dùng ký đơn bằng private key trên máy, admin xác nhận qua public key được lưu trên server. Kèm theo **Tool ký số desktop** (.exe) chạy độc lập để thực hiện việc ký.

---

## Yêu cầu hệ thống

| Thành phần | Phiên bản |
|------------|-----------|
| JDK | 21 |
| Apache Tomcat | 10+ |
| MySQL / MariaDB | 10.4+ |

---

## Cấu trúc chức năng

### 🛒 Web thương mại điện tử
- Đăng ký / đăng nhập tài khoản
- Xem danh sách sản phẩm theo danh mục
- Giỏ hàng và thanh toán
- Xem chi tiết sản phẩm

### 🔑 Quản lý khoá số (người dùng)
- Tạo cặp khoá RSA 2048-bit — private key tải về máy, public key lưu server
- Xem khoá đang hoạt động
- Thu hồi khoá khi bị mất
- Lịch sử các khoá đã tạo

### ✍️ Ký đơn hàng (người dùng)
- Sau khi đặt hàng, hệ thống tạo **Canonical JSON** chuẩn hoá dữ liệu đơn
- Người dùng dùng **Tool ký số** để ký bằng private key
- Paste chữ ký (Base64) lên web để hoàn tất

### 🛡️ Quản trị admin
- Quản lý sản phẩm: thêm, sửa, xoá, tồn kho
- Quản lý danh mục và đơn vị tính
- Quản lý người dùng: phân quyền, khoá tài khoản
- Quản lý đơn hàng: cập nhật trạng thái, xem chi tiết chữ ký (JSON + public key + signature), chấp nhận đơn

---

## Tool ký số (Desktop)

Tool chạy độc lập trên Windows, không cần cài đặt thêm (yêu cầu JRE 21).

**Chức năng:**
- Nhận Canonical JSON từ web
- Ký bằng file private key (`.pem`)
- Xuất chữ ký Base64 để paste lên web
- Xác minh chữ ký bằng public key

**Tải về:** [SignTool.exe](https://drive.google.com/file/d/1va-PY5UD5vOUjkzxlKWiq1Y2ZqKme7Oa/view?usp=sharing)

---

## Cài đặt

1. Import database từ file `ecommerceweb.sql`
2. Cấu hình kết nối DB trong `JdbiConnector.java`
3. Deploy project lên Tomcat
4. Truy cập `http://localhost:8080/ecommerceweb`

---

## Thuật toán

| | |
|-|--|
| Khoá | RSA 2048-bit |
| Chữ ký | SHA256withRSA |
| Encoding | Base64 |

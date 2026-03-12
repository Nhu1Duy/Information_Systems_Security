<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cập nhật thành viên - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
        }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--text-color); }
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background: var(--bg-color);
            color: var(--text-color);
        }
        .checkbox-group { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 10px 0; }
        .checkbox-group input { width: 20px; height: 20px; accent-color: var(--primary-green); }

        .btn-submit {
            width: 100%;
            background: var(--primary-green);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-submit:hover { opacity: 0.9; transform: translateY(-2px); }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<div class="form-container">
    <h2 style="margin-bottom: 20px; color: var(--primary-green); text-align: center;">
        <i class="fas fa-user-cog"></i> Chỉnh sửa thành viên
    </h2>
    <form action="adminUser" method="POST">
        <input type="hidden" name="id" value="${userEdit.id}">

        <div class="form-group">
            <label>Tên đăng nhập:</label>
            <input type="text" class="form-control" value="${userEdit.username}" disabled style="opacity: 0.7;">
            <small>(Không thể thay đổi tên đăng nhập)</small>
        </div>

        <div class="form-group">
            <label>Phân quyền hệ thống:</label>
            <select name="role" class="form-control">
                <option value="user" ${userEdit.role == 'user' ? 'selected' : ''}>Khách hàng (User)</option>
                <option value="admin" ${userEdit.role == 'admin' ? 'selected' : ''}>Quản trị viên (Admin)</option>
            </select>
        </div>

        <div class="form-group">
            <label class="checkbox-group">
                <input type="checkbox" name="active" ${userEdit.active ? 'checked' : ''}>
                <span>Kích hoạt tài khoản (Cho phép đăng nhập)</span>
            </label>
        </div>

        <button type="submit" class="btn-submit">Lưu thay đổi</button>
        <a href="adminUser" style="display:block; text-align:center; margin-top:15px; color: var(--earthy-brown); text-decoration: none;">
            <i class="fas fa-times"></i> Hủy bỏ
        </a>
    </form>
</div>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
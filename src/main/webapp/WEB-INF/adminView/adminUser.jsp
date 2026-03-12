<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Quản lý người dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>

    <style>
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: var(--card-bg);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }
        .admin-table th, .admin-table td { padding: 15px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .admin-table th { background-color: var(--primary-green); color: white; }
        .badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .badge-admin { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .badge-user { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }

        .status-active { color: var(--primary-green); }
        .status-locked { color: #f44336; }

        .action-btns { display: flex; gap: 5px; }
        .btn-edit { background: #2196F3; color: white; padding: 5px 10px; border-radius: 4px; }
        .btn-delete { background: #f44336; color: white; padding: 5px 10px; border-radius: 4px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<main class="container">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 2rem;">
        <h1 class="product-detail-name">Quản lý người dùng</h1>
        <p style="color: var(--earthy-brown);">Tổng số: <strong>${users.size()}</strong> thành viên</p>
    </div>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên đăng nhập</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="u">
            <tr>
                <td>#${u.id}</td>
                <td>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <i class="fas fa-user-circle" style="font-size: 1.5rem; color: var(--earthy-brown);"></i>
                        <strong>${u.username}</strong>
                    </div>
                </td>
                <td>
                    <span class="badge ${u.role == 'admin' ? 'badge-admin' : 'badge-user'}">
                        <i class="fas ${u.role == 'admin' ? 'fa-user-shield' : 'fa-user'}"></i> ${u.role.toUpperCase()}
                    </span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${u.active}">
                            <span class="status-active"><i class="fas fa-check-circle"></i> Hoạt động</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-locked"><i class="fas fa-lock"></i> Đã khóa</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="action-btns">
                    <a href="adminUser?action=edit&id=${u.id}" class="btn-edit" title="Sửa quyền/Trạng thái">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="adminUser?action=delete&id=${u.id}" class="btn-delete"
                       onclick="return confirm('Xóa người dùng này? Thao tác này không thể hoàn tác!')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
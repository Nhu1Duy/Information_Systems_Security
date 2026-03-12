<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Quản lý sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
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

        .admin-table th, .admin-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .admin-table th {
            background-color: var(--primary-green);
            color: white;
        }

        .product-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }

        .action-btns {
            display: flex;
            gap: 5px;
        }

        .btn-edit {
            background: #2196F3;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
        }

        .btn-delete {
            background: #f44336;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<main class="container">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 2rem;">
        <h1>Quản lý Sản phẩm</h1>
        <a href="adminProduct?action=add" class="btn btn-primary">Thêm sản phẩm mới</a>
    </div>

    <table class="admin-table">
        <thead>
        <tr>
            <th>Ảnh</th>
            <th>Tên sản phẩm</th>
            <th>Danh mục</th>
            <th>Giá</th>
            <th>Đơn vị</th>
            <th>Tồn kho</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${products}" var="p">
            <tr>
                <td><img src="${p.image}" class="product-thumb"></td>
                <td><strong>${p.name}</strong></td>
                <td>${p.category.name}</td>
                <td> <fmt:formatNumber value="${p.price}" type="currency" maxFractionDigits="0"
                                       currencySymbol="VND"/></td>
                <td>${p.unit.name}</td>
                <td>${p.stock}</td>
                <td class="action-btns">
                    <a href="adminProduct?action=edit&id=${p.id}" class="btn-edit"><i class="fas fa-edit"></i></a>
                    <a href="adminProduct?action=delete&id=${p.id}" class="btn-delete"
                       onclick="return confirm('Xóa sản phẩm này?')"><i class="fas fa-trash"></i></a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
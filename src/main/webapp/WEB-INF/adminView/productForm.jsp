<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${product != null ? 'Sửa' : 'Thêm'} Sản Phẩm - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .form-container { max-width: 600px; margin: 50px auto; padding: 30px; background: var(--card-bg); border-radius: 12px; box-shadow: var(--shadow); }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 600; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid var(--border-color); border-radius: 6px; }
        .btn-submit { width: 100%; background: var(--primary-green); color: white; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 1rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<div class="container">
    <div class="form-container">
        <h2>${product != null ? 'Chỉnh sửa sản phẩm' : 'Thêm sản phẩm mới'}</h2>
        <form action="adminProduct" method="POST">
            <input type="hidden" name="id" value="${product != null ? product.id : ''}">

            <div class="form-group">
                <label>Tên sản phẩm:</label>
                <input type="text" name="name" value="${product.name}" required>
            </div>

            <div class="form-group">
                <label>Giá (VND):</label>
                <input type="number" name="price" value="${product.price}" required>
            </div>

            <div class="form-group">
                <label>Danh mục:</label>
                <select name="categoryId">
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}" ${product.category.id == c.id ? 'selected' : ''}>${c.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>Đơn vị:</label>
                <select name="unitId">
                    <c:forEach items="${units}" var="u">
                        <option value="${u.id}" ${product.unit.id == u.id ? 'selected' : ''}>${u.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>Đường dẫn ảnh (URL):</label>
                <input type="text" name="image" value="${product.image}">
            </div>

            <div class="form-group">
                <label>Mô tả:</label>
                <textarea name="description" rows="4">${product.description}</textarea>
            </div>
            <div class="form-group">
                <label>Số lượng tồn kho:</label>
                <input type="number" name="stock" value="${product.stock}" min="0" required>
            </div>

            <button type="submit" class="btn-submit">Lưu sản phẩm</button>
            <a href="adminProduct" style="display:block; text-align:center; margin-top:10px; color: var(--earthy-brown);">Hủy bỏ</a>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
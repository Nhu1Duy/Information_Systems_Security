<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Admin - Quản lý danh vị</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .admin-container { display: grid; grid-template-columns: 1fr 2fr; gap: 20px; margin-top: 2rem; }
    .form-card { background: var(--card-bg); padding: 20px; border-radius: 8px; box-shadow: var(--shadow); height: fit-content; }
    .admin-table { width: 100%; border-collapse: collapse; background: var(--card-bg); border-radius: 8px; overflow: hidden; box-shadow: var(--shadow); }
    .admin-table th, .admin-table td { padding: 12px; text-align: left; border-bottom: 1px solid var(--border-color); }
    .admin-table th { background: var(--primary-green); color: white; }
    .input-group { margin-bottom: 15px; }
    .input-group label { display: block; margin-bottom: 5px; font-weight: bold; }
    .input-group input { width: 100%; padding: 8px; border: 1px solid var(--border-color); border-radius: 4px; }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<main class="container">
  <h1>Quản lý Danh mục sản phẩm</h1>

  <div class="admin-container">
    <div class="form-card">
      <h3>Thêm danh mục mới</h3>
      <form action="adminOther" method="post">
        <input type="hidden" name="type" value="category"> <div class="input-group">
        <label>Tên danh mục:</label>
        <input type="text" name="name" required>
      </div>
        <div class="input-group">
          <label>Đường dẫn ảnh:</label>
          <input type="text" name="image">
        </div>
        <button type="submit" class="btn btn-primary">Thêm mới</button>
      </form>
    </div>

    <table class="admin-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Hình ảnh</th>
        <th>Tên danh mục</th>
        <th>Thao tác</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${categories}" var="cat">
        <tr>
          <td>#${cat.id}</td>
          <td><img src="${cat.image}" style="width: 40px; height: 40px; object-fit: cover; border-radius: 4px;"></td>
          <td><strong>${cat.name}</strong></td>
          <td>
            <a href="adminOther?action=deleteCat&id=${cat.id}"
               class="btn-delete" onclick="return confirm('Xóa danh mục này sẽ ảnh hưởng đến sản phẩm liên quan. Tiếp tục?')">
              <i class="fas fa-trash"></i>
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
  <h1>Quản lý Đơn vị tính</h1>

  <div class="admin-container">
    <div class="form-card">
      <h3>Thêm đơn vị mới</h3>
      <form action="adminOther" method="post">
        <input type="hidden" name="type" value="unit">
        <div class="input-group">
          <label>Tên đơn vị:</label>
          <input type="text" name="name" required>
        </div>
        <button type="submit" class="btn btn-primary">Lưu đơn vị</button>
      </form>
    </div>

    <table class="admin-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Tên đơn vị</th>
        <th>Thao tác</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${units}" var="u">
        <tr>
          <td>#${u.id}</td>
          <td><strong>${u.name}</strong></td>
          <td>
            <a href="adminOther?action=deleteUnit&id=${u.id}"
               style="color: #f44336;" onclick="return confirm('Xóa đơn vị này?')">
              <i class="fas fa-trash-alt"></i> Xóa
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
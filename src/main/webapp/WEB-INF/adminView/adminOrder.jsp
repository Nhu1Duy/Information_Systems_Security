<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Admin - Quản lý đơn hàng</title>
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
    .admin-table th, .admin-table td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid var(--border-color);
    }
    .admin-table th {
      background-color: var(--primary-green);
      color: white;
    }
    .action-btns {
      display: flex;
      gap: 5px;
      align-items: center;
    }
    .status-badge {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 600;
      display: inline-block;
    }
    .status-pending   { background: #fff3cd; color: #856404; }
    .status-shipping  { background: #cce5ff; color: #004085; }
    .status-completed { background: #d4edda; color: #155724; }
    .status-cancelled { background: #f8d7da; color: #721c24; }

    .sig-VERIFIED { background: #d4edda; color: #155724; }
    .sig-TAMPERED { background: #f8d7da; color: #721c24; }
    .sig-REJECTED { background: #f8d7da; color: #721c24; }
    .sig-SIGNED   { background: #cce5ff; color: #004085; }
    .sig-UNSIGNED { background: #e2e3e5; color: #383d41; }

    .btn-delete {
      background: #f44336;
      color: white;
      padding: 5px 10px;
      border-radius: 4px;
      border: none;
      cursor: pointer;
      text-decoration: none;
    }
    .btn-verify {
      background: #2563eb;
      color: #fff;
      border: none;
      padding: 5px 12px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 13px;
      text-decoration: none;
      white-space: nowrap;
    }
    select[name="status"] {
      padding: 5px;
      border-radius: 4px;
      border: 1px solid var(--border-color);
      outline: none;
    }
    .alert-danger {
      background: #f8d7da;
      border: 1px solid #f5c6cb;
      color: #721c24;
      padding: 1rem;
      border-radius: 6px;
      margin-bottom: 1.5rem;
      font-weight: 600;
      font-size: 15px;
    }
    .alert-success {
      background: #d4edda;
      border: 1px solid #c3e6cb;
      color: #155724;
      padding: 1rem;
      border-radius: 6px;
      margin-bottom: 1.5rem;
      font-weight: 600;
      font-size: 15px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<main class="container" style="margin-top: 2rem; margin-bottom: 5rem;">

  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
    <h1>Quản lý Đơn hàng</h1>
  </div>

  <%-- Alert verify kết quả — nằm trong main, trên bảng --%>
  <c:if test="${not empty param.verifyResult}">
    <c:choose>
      <c:when test="${param.verifyResult == 'VERIFIED'}">
        <div class="alert-success">
          ✅ Đơn hàng #${param.orderId} — Chữ ký hợp lệ, dữ liệu nguyên vẹn.
        </div>
      </c:when>
      <c:otherwise>
        <div class="alert-danger">
          ⚠️ CẢNH BÁO: Đơn hàng #${param.orderId} —
          <c:choose>
            <c:when test="${param.verifyResult == 'TAMPERED'}">Dữ liệu đã bị thay đổi trái phép!</c:when>
            <c:when test="${param.verifyResult == 'REJECTED'}">Đơn ký sau khi khóa bị thu hồi!</c:when>
            <c:when test="${param.verifyResult == 'UNSIGNED'}">Đơn hàng chưa được ký!</c:when>
            <c:otherwise>Xác minh thất bại!</c:otherwise>
          </c:choose>
        </div>
      </c:otherwise>
    </c:choose>
  </c:if>

  <table class="admin-table">
    <thead>
    <tr>
      <th>Mã ĐH</th>
      <th>Khách hàng</th>
      <th>Ngày đặt</th>
      <th>Tổng tiền</th>
      <th>Trạng thái</th>
      <th>Chữ ký</th>
      <th style="text-align: center;">Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${orders}" var="o">
      <tr>
        <td><strong>#${o.id}</strong></td>
        <td>${o.customerName}</td>
        <td>
          <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
        </td>
        <td>
          <strong style="color: var(--primary-green);">
            <fmt:formatNumber value="${o.total}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
          </strong>
        </td>
        <td>
          <span class="status-badge status-${o.status.toLowerCase()}">${o.status}</span>
        </td>
        <td>
          <span class="status-badge sig-${o.sigStatus}">${o.sigStatus}</span>
        </td>
        <td class="action-btns" style="justify-content: center;">

            <%-- Dropdown đổi trạng thái đơn --%>
          <form action="adminOrder" method="GET" style="display:inline-flex; align-items:center;">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="id" value="${o.id}">
            <select name="status" onchange="this.form.submit()">
              <option value="PENDING"   ${o.status == 'PENDING'   ? 'selected' : ''}>Chờ</option>
              <option value="SHIPPING"  ${o.status == 'SHIPPING'  ? 'selected' : ''}>Giao</option>
              <option value="COMPLETED" ${o.status == 'COMPLETED' ? 'selected' : ''}>Xong</option>
              <option value="CANCELLED" ${o.status == 'CANCELLED' ? 'selected' : ''}>Hủy</option>
            </select>
          </form>

            <%-- Nút Verify — chỉ hiện khi đã ký --%>
          <c:if test="${o.sigStatus == 'SIGNED' or o.sigStatus == 'VERIFIED' or o.sigStatus == 'TAMPERED' or o.sigStatus == 'REJECTED'}">
            <a href="adminOrder?action=verify&id=${o.id}" class="btn-verify">🔍 Verify</a>
            <a href="adminOrder?action=detail&id=${o.id}" class="btn-verify" style="background:#6366f1;">📄 Chi tiết</a>
          </c:if>

            <%-- Nút Xóa --%>
          <a href="adminOrder?action=delete&id=${o.id}"
             class="btn-delete"
             onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng này?')"
             title="Xóa">
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
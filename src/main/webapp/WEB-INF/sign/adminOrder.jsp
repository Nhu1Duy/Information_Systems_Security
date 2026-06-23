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
    .orders-table { width:100%; border-collapse:collapse; margin-top:20px;
            background: var(--card-bg); border-radius:8px; overflow:hidden; box-shadow: var(--shadow); }
        .orders-table th, .orders-table td { padding:14px; text-align:left;
            border-bottom:1px solid var(--border-color); font-size:14px; }
        .orders-table th { background-color: var(--primary-green); color:#fff; }
        
    .status-badge { padding:5px 10px; border-radius:20px; font-size:.85rem; font-weight:600; display:inline-block; }
    .status-pending   { background: #fff3cd; color: #856404; }
    .status-shipping  { background: #cce5ff; color: #004085; }
    .status-completed { background: #d4edda; color: #155724; }
    .status-cancelled { background: #f8d7da; color: #721c24; }
    .status-confirmed { background: #ffe5d0; color: #cc5500; }

    .sig-UNSIGNED { background:#e2e3e5; color:#383d41; }
    .sig-SIGNED   { background:#d4edda; color:#155724; }
    .sig-MISMATCH { background:#f8d7da; color:#721c24; }
    .sig-KEY_REVOKED { background: #ffe5d0; color: #cc5500; }
    
    .action-btns {
      display: flex;
      gap: 5px;
      align-items: center;
    }
    
    .btn-detail, .btn-verify {
		padding: 5px 12px;
		border-radius: 6px;
		font-size: 12px;
		font-weight: 600;
		text-decoration: none;
		cursor: pointer;
		white-space: nowrap;
		transition: all 0.2s ease;
    }
		
    .btn-detail {
		background: #fffbeb;
		color: #b45309;
		border: 1px solid #fcd34d;
    }
		
    .btn-detail:hover {
		background: #fef3c7;
    }
		
    .btn-verify {
		background: #ecfdf5;
		color: #15803d;
		border: 1px solid #86efac;
    }
		
    .btn-verify:hover {
		background: #d1fae5;
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

  <c:if test="${not empty param.verifyResult}">
    <c:choose>
      <c:when test="${param.verifyResult == 'SIGNED'}">
        <div class="alert-success">Đơn hàng #${param.orderId} — Chữ ký hợp lệ.</div>
      </c:when>
      <c:when test="${param.verifyResult == 'MISMATCH'}">
        <div class="alert-danger">Đơn hàng #${param.orderId} — Chữ ký không khớp!</div>
      </c:when>
      <c:otherwise>
        <div class="alert-danger">Đơn hàng #${param.orderId} — Đơn hàng chưa được ký hoặc khoá đã bị thu hồi!</div>
      </c:otherwise>
    </c:choose>
  </c:if>

  <table class="orders-table">
    <thead>
    <tr>
      <th width=8%>Mã ĐH</th>
      <th width=13%>Khách hàng</th>
      <th width=15%>Ngày đặt</th>
      <th width=10%>Tổng tiền</th>
      <th width=14%>Trạng thái đơn</th>
      <th width=17%>Trạng thái chữ ký</th>
      <th style="justify-content: center;">Thao tác</th>
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
          <strong>
            <fmt:formatNumber value="${o.total}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
          </strong>
        </td>
        <td>
          <span class="status-badge status-${o.status.name().toLowerCase()}">${o.status.label}</span>
        </td>
        <td>
          <span class="status-badge sig-${o.sigStatus}">${o.sigStatusLabel}</span>
        </td>
        <td class="action-btns">

            <%-- Dropdown đổi trạng thái đơn --%>
          <form action="adminOrder" method="GET" style="display:inline-flex; align-items:center;">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="id" value="${o.id}">
            <select name="status" onchange="this.form.submit()">
              <option value="PENDING"   ${o.status.name() == 'PENDING'   ? 'selected' : ''}>Chờ xác nhận</option>
              <option value="CONFIRMED" ${o.status.name() == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
              <option value="CANCELLED" ${o.status.name() == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
              <c:if test="${o.sigStatus == 'SIGNED' && o.status.name() != 'PENDING' && o.status.name() != 'CANCELLED'}">
                <option value="SHIPPING"  ${o.status.name() == 'SHIPPING'  ? 'selected' : ''}>Đang giao</option>
                <option value="COMPLETED" ${o.status.name() == 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
              </c:if>
            </select>
          </form>
              <c:if test="${o.status.name() == 'PENDING' 
              		&& (o.sigStatus == 'SIGNED' || o.sigStatus == 'MISMATCH')}">
                <a href="adminOrder?action=verify&id=${o.id}" class="btn-verify">Verify chữ ký</a>
              </c:if>
              <a href="adminOrder?action=detail&id=${o.id}" class="btn-detail">Chi tiết chữ ký</a>
            

        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
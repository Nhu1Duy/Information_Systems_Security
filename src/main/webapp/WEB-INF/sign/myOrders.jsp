<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <style>
        .orders-table { width:100%; border-collapse:collapse; margin-top:20px;
            background: var(--card-bg); border-radius:8px; overflow:hidden; box-shadow: var(--shadow); }
        .orders-table th, .orders-table td { padding:14px; text-align:left;
            border-bottom:1px solid var(--border-color); font-size:14px; }
        .orders-table th { background-color: var(--primary-green); color:#fff; }

        .status-badge { padding:5px 10px; border-radius:20px; font-size:.85rem; font-weight:600; display:inline-block; }
        .status-pending   { background:#fff3cd; color:#856404; }
        .status-shipping  { background:#cce5ff; color:#004085; }
        .status-completed { background:#d4edda; color:#155724; }
        .status-cancelled { background:#f8d7da; color:#721c24; }
        .status-confirmed { background: #ffe5d0; color: #cc5500; }

        .sig-UNSIGNED { background:#e2e3e5; color:#383d41; }
        .sig-SIGNED   { background:#d4edda; color:#155724; }
        .sig-MISMATCH { background:#f8d7da; color:#721c24; }
        .sig-KEY_REVOKED { background: #ffe5d0; color: #cc5500; }

        
        .detail-box { font-family:monospace; font-size:11px; background:#1e1e1e; color:#d4d4d4;
            padding:.75rem; border-radius:6px; white-space:pre-wrap; word-break:break-all;
            max-height:140px; overflow-y:auto; margin-top:6px; }
        .verify-msg { font-size:13px; margin-top:6px; }
        .verify-ok   { color:#155724; }
        .verify-bad  { color:#721c24; font-weight:600; }
        .verify-warn { color:#856404; }
        
		.btn-detail, .btn-sign {
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
		
		.btn-sign {
		    background: #ecfdf5;
		    color: #15803d;
		    border: 1px solid #86efac;
		}
		
		.btn-sign:hover {
		    background: #d1fae5;
		}
        details > summary { cursor:pointer; color:#2563eb; font-size:13px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main class="container" style="margin-top:2rem; margin-bottom:4rem;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
    	<h1>Đơn hàng của tôi</h1>
  	</div>

    <c:if test="${empty orders}">
        <p style="margin-top:1rem; color:#666;">Bạn chưa có đơn hàng nào.</p>
    </c:if>

    <c:if test="${not empty orders}">
        <table class="orders-table">
            <thead>
            <tr>
                <th width=8%>Mã ĐH</th>
                <th width=15%>Ngày đặt</th>
                <th width=13%>Tổng tiền</th>
                <th width=20%>Trạng thái đơn</th>
                <th width=20%>Trạng thái chữ ký</th>
                <th style="justify-content: center;">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orders}" var="o">
                <tr>
                    <td><strong>#${o.id}</strong></td>
                    <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td>
                        <strong>
                            <fmt:formatNumber value="${o.total}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
                        </strong>
                    </td>
                    <td><span class="status-badge status-${o.status.name().toLowerCase()}">${o.status.label}</span></td>
                    <td><span class="status-badge sig-${o.sigStatus}">${o.sigStatusLabel}</span></td>
                    <td>
                        <c:if test="${(o.sigStatus != 'SIGNED' && o.sigStatus != 'KEY_REVOKED') && o.status.name() == 'PENDING'}">
                            <a href="${pageContext.request.contextPath}/sign-order?orderId=${o.id}" class="btn-sign">Ký đơn hàng</a>
                        </c:if>
                        <c:if test="${o.sigStatus != 'UNSIGNED'}">
                            <a href="${pageContext.request.contextPath}/myOrders?action=detail&id=${o.id}"
                               class="btn-detail">
                                Chi tiết chữ ký
                            </a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
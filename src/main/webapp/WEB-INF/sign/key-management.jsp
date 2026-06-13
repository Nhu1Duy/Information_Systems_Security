<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý khóa - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .key-card { background:#fff; border-radius:10px; padding:2rem;
            box-shadow:0 2px 8px rgba(0,0,0,0.1); margin-bottom:1.5rem; }
        .key-status-active  { color:#16a34a; font-weight:700; }
        .key-status-revoked { color:#dc2626; font-weight:700; }
        .key-pem { font-family:monospace; font-size:11px; background:#f5f5f5;
            padding:1rem; border-radius:6px; word-break:break-all;
            max-height:120px; overflow-y:auto; }
        .btn-danger  { background:#dc2626; color:#fff; border:none; padding:10px 20px;
            border-radius:6px; cursor:pointer; font-size:14px; }
        .btn-primary { background:#16a34a; color:#fff; border:none; padding:10px 20px;
            border-radius:6px; cursor:pointer; font-size:14px; }
        .alert-warn { background:#fff3cd; border:1px solid #ffc107;
            padding:1rem; border-radius:6px; margin-bottom:1rem; }
        .history-table { width:100%; border-collapse:collapse; margin-top:1rem; }
        .history-table th, .history-table td { padding:10px; border:1px solid #ddd; font-size:13px; }
        .history-table th { background:#16a34a; color:#fff; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>
<main class="container" style="margin-top:2rem; margin-bottom:4rem;">
    <h1>Quản lý Khóa Số</h1>

    <c:if test="${not empty keyMessage}">
        <div class="alert-warn">${keyMessage}</div>
    </c:if>

    <!-- Khóa hiện tại -->
    <div class="key-card">
        <h2>Khóa đang hoạt động</h2>
        <c:choose>
            <c:when test="${activeKey != null}">
                <p>Trạng thái: <span class="key-status-active">ACTIVE</span></p>
                <p>Tạo lúc: <fmt:formatDate value="${activeKey.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                <div class="key-pem">${activeKey.publicKey}</div>
                <br/>
                <form action="key" method="POST" style="display:inline;"
                      onsubmit="return confirm('Báo mất khóa sẽ thu hồi khóa hiện tại. Bạn cần tạo khóa mới. Tiếp tục?')">
                    <input type="hidden" name="action" value="revoke"/>
                    <button type="submit" class="btn-danger">⚠️ Báo mất khóa / Thu hồi</button>
                </form>
            </c:when>
            <c:otherwise>
                <p style="color:#666;">Bạn chưa có khóa nào. Hãy tạo khóa để có thể ký đơn hàng.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Tạo khóa mới -->
    <div class="key-card">
        <h2>Tạo khóa mới</h2>
        <p style="color:#555;">File Private Key sẽ tự động tải về máy. <strong>Lưu giữ cẩn thận — không chia sẻ với ai.</strong></p>
        <form action="key" method="POST">
            <input type="hidden" name="action" value="generate"/>
            <button type="submit" class="btn-primary">🔑 Tạo cặp khóa RSA 2048-bit</button>
        </form>
    </div>

    <!-- Lịch sử khóa -->
    <div class="key-card">
        <h2>Lịch sử khóa</h2>
        <table class="history-table">
            <thead><tr><th>#</th><th>Trạng thái</th><th>Tạo lúc</th><th>Thu hồi lúc</th></tr></thead>
            <tbody>
            <c:forEach items="${keyHistory}" var="k">
                <tr>
                    <td>${k.id}</td>
                    <td>
                        <c:choose>
                            <c:when test="${k.status == 'ACTIVE'}">
                                <span class="key-status-active">ACTIVE</span>
                            </c:when>
                            <c:otherwise>
                                <span class="key-status-revoked">REVOKED</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${k.createdAt}</td>
                    <td>${k.revokedAt != null ? k.revokedAt : '—'}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
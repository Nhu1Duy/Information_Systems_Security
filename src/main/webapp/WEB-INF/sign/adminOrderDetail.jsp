<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết chữ ký - Đơn hàng #${detailOrder.id}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <style>
        .detail-card {
            background: #fff;
            border-radius: 10px;
            padding: 1.5rem 2rem;
            box-shadow: 0 2px 8px rgba(0,0,0,.08);
            margin-bottom: 1.5rem;
        }
        .detail-card h3 {
            margin: 0 0 1rem 0;
            font-size: 15px;
            color: #374151;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .code-box {
            font-family: monospace;
            font-size: 12px;
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 1rem;
            border-radius: 6px;
            white-space: pre-wrap;
            word-break: break-all;
            max-height: 220px;
            overflow-y: auto;
        }
        .btn-copy {
            background: #2563eb;
            color: #fff;
            border: none;
            padding: 7px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            margin-top: 10px;
        }
        .btn-copy:hover { background: #1d4ed8; }
        .btn-back {
            display: inline-block;
            background: #6b7280;
            color: #fff;
            padding: 9px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 1.5rem;
        }
        .btn-back:hover { background: #4b5563; }
        .meta-row {
            display: flex;
            gap: 2rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        .meta-item { font-size: 14px; color: #374151; }
        .meta-item strong { color: #111827; }
        .sig-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
        }
        .sig-UNSIGNED { background:#e2e3e5; color:#383d41; }
        .sig-SIGNED   { background:#d4edda; color:#155724; }
        .sig-MISMATCH { background:#f8d7da; color:#721c24; }
        .no-data { color: #9ca3af; font-style: italic; font-size: 13px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/adminHeader.jsp"/>

<main class="container" style="margin-top:2rem; margin-bottom:4rem; max-width:860px;">

    <a href="adminOrder" class="btn-back">← Quay lại danh sách</a>

    <h2 style="margin-bottom:1rem;">📋 Chi tiết chữ ký — Đơn hàng #${detailOrder.id}</h2>

    <div class="meta-row">
        <div class="meta-item">Khách hàng: <strong>${detailOrder.userId}</strong></div>
        <div class="meta-item">
            Ngày đặt: <strong><fmt:formatDate value="${detailOrder.orderDate}" pattern="dd/MM/yyyy HH:mm"/></strong>
        </div>
        <div class="meta-item">
            Trạng thái chữ ký:
            <span class="sig-badge sig-${detailOrder.sigStatus}">${detailOrder.sigStatus}</span>
        </div>
    </div>

    <%-- 1. Canonical JSON --%>
    <div class="detail-card">
        <h3>📄 1. Canonical JSON (dữ liệu đã ký)</h3>
        <c:choose>
            <c:when test="${not empty detailOrder.canonicalJson}">
                <div class="code-box" id="jsonBox">${detailOrder.canonicalJson}</div>
                <button class="btn-copy" onclick="copyText('jsonBox', this)">📋 Copy JSON</button>
            </c:when>
            <c:otherwise>
                <p class="no-data">Đơn hàng chưa có canonical JSON.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 2. Public Key --%>
    <div class="detail-card">
        <h3>🔑 2. Khoá công khai (Public Key)</h3>
        <c:choose>
            <c:when test="${not empty detailKey}">
                <div class="code-box" id="pubkeyBox">${detailKey.publicKey}</div>
                <button class="btn-copy" onclick="copyText('pubkeyBox', this)">📋 Copy Public Key</button>
                <p style="font-size:12px; color:#6b7280; margin-top:8px;">
                    Key ID: #${detailKey.id} &nbsp;|&nbsp;
                    Trạng thái: <strong>${detailKey.status}</strong>
                    <c:if test="${not empty detailKey.revokedAt}">
                        &nbsp;|&nbsp; Thu hồi lúc: <fmt:formatDate value="${detailKey.revokedAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </c:if>
                </p>
            </c:when>
            <c:otherwise>
                <p class="no-data">Không tìm thấy khoá công khai cho đơn hàng này.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 3. Chữ ký --%>
    <div class="detail-card">
        <h3>✍️ 3. Chữ ký số (Signature - Base64)</h3>
        <c:choose>
            <c:when test="${not empty detailOrder.signature}">
                <div class="code-box" id="sigBox">${detailOrder.signature}</div>
                <button class="btn-copy" onclick="copyText('sigBox', this)">📋 Copy Signature</button>
            </c:when>
            <c:otherwise>
                <p class="no-data">Đơn hàng chưa được ký.</p>
            </c:otherwise>
        </c:choose>
    </div>

</main>

<script>
    function copyText(id, btn) {
        const text = document.getElementById(id).innerText;
        navigator.clipboard.writeText(text).then(() => {
            const orig = btn.textContent;
            btn.textContent = '✅ Đã copy!';
            setTimeout(() => btn.textContent = orig, 2000);
        });
    }
</script>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>

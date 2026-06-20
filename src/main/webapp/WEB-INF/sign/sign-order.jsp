<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Ký đơn hàng - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .sign-section { max-width: 800px; margin: 2rem auto 4rem; }
        .sign-card    { border: 1px solid var(--border-color); border-radius: 8px;
            padding: 1.5rem; margin-bottom: 1.5rem;
            background-color: var(--card-bg); }
        .sign-card h3 { margin-bottom: 0.75rem; font-size: 1rem; }
        .json-box     { font-family: monospace; font-size: 12px;
            background: #1e1e1e; color: #d4d4d4;
            padding: 1rem; border-radius: 6px;
            white-space: pre-wrap; max-height: 200px; overflow-y: auto; }
        .sig-input    { width: 100%; height: 100px; font-family: monospace;
            font-size: 12px; padding: 10px;
            border: 1px solid var(--border-color); border-radius: 6px;
            resize: vertical; background: var(--bg-color); color: var(--text-color); }
        .alert        { padding: 0.75rem 1rem; border-radius: 6px;
            margin-bottom: 1rem; font-size: 14px; }
        .alert-warn   { background: #fef3c7; border: 1px solid #f59e0b; }
        .alert-error  { background: #fee2e2; border: 1px solid #ef4444; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main class="container sign-section">
    <h1 style="margin-bottom: 1.5rem;">Ký số đơn hàng #${order.id}</h1>

    <c:if test="${activeKey == null}">
        <div class="alert alert-warn">
            Bạn chưa có khóa. <a href="key">Tạo khóa tại đây</a> trước khi ký.
        </div>
    </c:if>

    <div class="alert alert-warn">
        <strong>Hướng dẫn:</strong> Copy JSON → Mở <strong>Tool Ký Số</strong> →
        Paste JSON + chọn file Private Key → Ký → Copy chữ ký → Paste vào ô bên dưới → Gửi.<br>
        <a href="https://drive.google.com/file/d/1va-PY5UD5vOUjkzxlKWiq1Y2ZqKme7Oa/view?usp=sharing"
           target="_blank">Tải Tool Ký Số</a>
    </div>

    <div class="sign-card">
        <h3>1. Dữ liệu đơn hàng (JSON)</h3>
        <div class="json-box" id="jsonBox">${order.canonicalJson}</div>
        <button class="btn btn-primary" style="margin-top: 0.75rem; padding: 0.5rem 1.2rem;"
                onclick="copyJson()">Copy JSON</button>
    </div>

    <div class="sign-card">
        <h3>2. Paste chữ ký số</h3>
        <form action="sign-order" method="POST">
            <input type="hidden" name="orderId"       value="${order.id}"/>
            <input type="hidden" name="canonicalJson" value="${fn:escapeXml(order.canonicalJson)}"/>
            <textarea class="sig-input" name="signature"
                      placeholder="Paste chuỗi chữ ký từ Tool ký số vào đây..." required></textarea>
            <br/><br/>
            <c:if test="${activeKey != null}">
                <button type="submit" class="btn btn-primary">Xác nhận</button>
            </c:if>
        </form>
    </div>
</main>

<script>
    function copyJson() {
        navigator.clipboard.writeText(document.getElementById('jsonBox').innerText)
            .then(() => alert('Đã copy JSON!'));
    }
</script>
<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
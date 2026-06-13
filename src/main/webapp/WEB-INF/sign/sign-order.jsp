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
        .sign-card   { background:#fff; border-radius:10px; padding:2rem;
            box-shadow:0 2px 8px rgba(0,0,0,.1); margin-bottom:1.5rem; }
        .json-box    { font-family:monospace; font-size:12px; background:#1e1e1e; color:#d4d4d4;
            padding:1rem; border-radius:6px; white-space:pre-wrap;
            max-height:200px; overflow-y:auto; }
        .step-badge  { display:inline-block; background:#16a34a; color:#fff;
            border-radius:50%; width:28px; height:28px; text-align:center;
            line-height:28px; font-weight:700; margin-right:8px; }
        .btn-copy    { background:#2563eb; color:#fff; border:none; padding:8px 16px;
            border-radius:6px; cursor:pointer; font-size:13px; margin-top:8px; }
        .btn-submit  { background:#16a34a; color:#fff; border:none; padding:12px 28px;
            border-radius:6px; cursor:pointer; font-size:15px; font-weight:700; }
        textarea.sig-input { width:100%; height:100px; font-family:monospace; font-size:12px;
            padding:10px; border:2px solid #d1fae5; border-radius:6px;
            resize:vertical; }
        .warn-box { background:#fef3c7; border:1px solid #f59e0b;
            padding:1rem; border-radius:6px; margin-bottom:1rem; font-size:14px; }
        .no-key-alert { background:#fee2e2; border:1px solid #ef4444;
            padding:1rem; border-radius:6px; margin-bottom:1rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>
<main class="container" style="margin-top:2rem; margin-bottom:4rem; max-width:800px;">
    <h1>Ký số đơn hàng #${order.id}</h1>

    <c:if test="${activeKey == null}">
        <div class="no-key-alert">
            ⚠️ Bạn chưa có khóa. <a href="key">Tạo khóa tại đây</a> trước khi ký.
        </div>
    </c:if>

    <div class="warn-box">
        📋 <strong>Hướng dẫn:</strong> Copy JSON bên dưới → Mở <strong>Tool Ký Số</strong> trên máy →
        Paste JSON + chọn file Private Key → Ký → Copy chữ ký → Paste vào ô bên dưới → Gửi đơn.
    </div>

    <!-- Bước 1: Canonical JSON -->
    <div class="sign-card">
        <h3><span class="step-badge">1</span>Dữ liệu đơn hàng cần ký (Canonical JSON)</h3>
        <p style="color:#555; font-size:13px;">Đây là dữ liệu sẽ được băm và ký. Không được thay đổi.</p>
        <div class="json-box" id="jsonBox">${order.canonicalJson}</div>
        <button class="btn-copy" onclick="copyJson()">📋 Copy JSON</button>
    </div>

    <!-- Bước 2: Nhắc mở Tool -->
    <div class="sign-card">
        <h3><span class="step-badge">2</span>Mở Tool Ký Số trên máy tính</h3>
        <p style="color:#555;">Paste JSON vào Tool → Chọn file <code>private_key_*.pem</code> → Nhấn <strong>KÝ ĐƠN HÀNG</strong> → Copy chữ ký.</p>
    </div>

    <!-- Bước 3: Paste chữ ký -->
    <div class="sign-card">
        <h3><span class="step-badge">3</span>Paste chữ ký số vào đây</h3>
        <form action="sign-order" method="POST">
            <input type="hidden" name="orderId" value="${order.id}"/>
            <input type="hidden" name="canonicalJson" value="${fn:escapeXml(order.canonicalJson)}"/>
            <textarea class="sig-input" name="signature"
                      placeholder="Paste chuỗi chữ ký hex từ Tool ký số vào đây..." required></textarea>
            <br/><br/>
            <c:if test="${activeKey != null}">
                <button type="submit" class="btn-submit">✅ Xác nhận & Gửi đơn hàng</button>
            </c:if>
        </form>
    </div>
</main>

<script>
    function copyJson() {
        const text = document.getElementById('jsonBox').innerText;
        navigator.clipboard.writeText(text).then(() => alert('Đã copy JSON!'));
    }
</script>
<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>
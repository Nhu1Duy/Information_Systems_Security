<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        .btn-secondary { background:#374151; color:#fff; border:none; padding:10px 20px;
            border-radius:6px; cursor:pointer; font-size:14px; }
        .btn-muted { background:#e5e7eb; color:#374151; border:none; padding:10px 20px;
            border-radius:6px; cursor:not-allowed; font-size:14px; }
        .alert-warn { background:#fff3cd; border:1px solid #ffc107;
            padding:1rem; border-radius:6px; margin-bottom:1rem; }
        .history-table { width:100%; border-collapse:collapse; margin-top:1rem; }
        .history-table th, .history-table td { padding:10px; border:1px solid #ddd; font-size:13px; }
        .history-table th { background:#16a34a; color:#fff; }
        .key-choice-overlay { position:fixed; inset:0; background:rgba(17,24,39,0.55);
            display:flex; align-items:center; justify-content:center; padding:1rem; z-index:999; }
        .key-choice-dialog { background:#fff; border-radius:8px; width:min(620px, 100%);
            padding:1.5rem; box-shadow:0 20px 40px rgba(0,0,0,0.25); }
        .key-choice-grid { display:grid; grid-template-columns:1fr 1fr; gap:1rem; margin-top:1rem; }
        .key-choice-box { border:1px solid #ddd; border-radius:8px; padding:1rem; }
        .key-choice-box h3 { margin-top:0; font-size:18px; }
        .gmail-row { display:flex; gap:8px; margin-top:10px; }
        .gmail-row input { flex:1; padding:10px; border:1px solid #ccc; border-radius:6px; }
        .own-key-layout { display:grid; grid-template-columns:1.1fr .9fr; gap:1.25rem; align-items:start; }
        .own-key-note { background:#f0fdf4; border:1px solid #bbf7d0; border-radius:8px; padding:1rem; color:#166534; }
        .own-public-key-input { width:100%; min-height:160px; font-family:monospace; font-size:12px;
            padding:12px; border:1px solid #d1d5db; border-radius:8px; resize:vertical; box-sizing:border-box; }
        .own-key-action-row { display:flex; align-items:center; justify-content:space-between; gap:12px; flex-wrap:wrap; margin-top:1rem; }
        .own-key-import-row { display:flex; align-items:center; gap:10px; flex-wrap:wrap; }
        .own-key-file-name { color:#555; font-size:13px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; max-width:100%; }
        .own-key-file-input { display:none; }
        .key-choice-error { color:#dc2626; font-size:13px; margin-top:8px; min-height:18px; }
        .key-choice-actions { display:flex; justify-content:flex-end; margin-top:1.25rem; }
        .private-key-source { display:none; }
        @media (max-width: 680px) {
            .key-choice-grid { grid-template-columns:1fr; }
            .own-key-layout { grid-template-columns:1fr; }
            .gmail-row { flex-direction:column; }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>
<main class="container" style="margin-top:2rem; margin-bottom:4rem;">
    <h1>Quản lý Khóa Số</h1>

    <c:if test="${not empty keyMessage}">
        <div class="alert-warn">${keyMessage}</div>
    </c:if>

    <div class="key-card">
        <h2>Khóa đang hoạt động</h2>
        <c:choose>
            <c:when test="${activeKey != null}">
                <p>Trạng thái: <span class="key-status-active">ACTIVE</span></p>
                <p>Tạo lúc: ${activeKey.createdAt.dayOfMonth}/${activeKey.createdAt.monthValue}/${activeKey.createdAt.year} ${activeKey.createdAt.hour}:${activeKey.createdAt.minute}</p>
                <div class="key-pem">${activeKey.publicKey}</div>
                <br/>
                <form action="key" method="POST" style="display:inline;"
                      onsubmit="return confirm('Báo mất khóa sẽ thu hồi khóa hiện tại. Bạn cần tạo khóa mới. Tiếp tục?')">
                    <input type="hidden" name="action" value="revoke"/>
                    <button type="submit" class="btn-danger">Báo mất khóa / Thu hồi</button>
                </form>
            </c:when>
            <c:otherwise>
                <p style="color:#666;">Bạn chưa có khóa nào. Hãy tạo khóa hoặc dùng public key cá nhân để có thể ký đơn hàng.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="key-card">
        <h2>Tạo khóa mới từ hệ thống</h2>
        <p style="color:#555;">Hệ thống sẽ tạo cặp khóa RSA mới và cho bạn chọn cách lưu private key. <strong>Lưu giữ cẩn thận và không chia sẻ với ai.</strong></p>
        <c:choose>
            <c:when test="${activeKey != null}">
                <p style="color:#555;">Bạn cần báo mất/thu hồi khóa hiện tại trước khi tạo khóa mới.</p>
                <button type="button" class="btn-muted" disabled>Cặp khóa RSA 2048-bit của bạn đang còn hoạt động</button>
            </c:when>
            <c:otherwise>
                <form action="key" method="POST">
                    <input type="hidden" name="action" value="generate"/>
                    <button type="submit" class="btn-primary">Tạo cặp khóa RSA 2048-bit</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="key-card">
        <h2>Dùng public key của bạn</h2>
        <div class="own-key-layout">
            <div>
                <p style="color:#555;">Nếu bạn đã có cặp khóa riêng, hãy dán public key RSA vào đây. Khi ký đơn, bạn vẫn dùng private key tương ứng của mình.</p>
                <c:choose>
                    <c:when test="${activeKey != null}">
                        <p style="color:#555;">Bạn cần báo mất/thu hồi khóa hiện tại trước khi thay bằng public key cá nhân.</p>
                        <button type="button" class="btn-muted" disabled>Public key hiện tại đang hoạt động</button>
                    </c:when>
                    <c:otherwise>
                        <form action="key" method="POST">
                            <input type="hidden" name="action" value="use-own-public-key"/>
                            <textarea id="ownPublicKeyInput" class="own-public-key-input" name="ownPublicKey"
                                      placeholder="Dán public key RSA của bạn tại đây. Hỗ trợ Base64 hoặc PEM public key." required></textarea>
                            <div class="own-key-action-row">
                                <button type="submit" class="btn-secondary">Sử dụng public key này</button>
                                <div class="own-key-import-row">
                                    <span id="ownPublicKeyFileName" class="own-key-file-name"></span>
                                    <button type="button" class="btn-secondary" onclick="document.getElementById('ownPublicKeyFile').click()">
                                        Import file public key
                                    </button>
                                    <input id="ownPublicKeyFile" class="own-key-file-input" type="file"
                                           accept=".pem,.pub,.txt,text/plain,application/x-pem-file"
                                           onchange="importOwnPublicKeyFile(this)"/>
                                </div>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="own-key-note">
                <strong>Lưu ý:</strong>
                <p style="margin-bottom:0;">Hệ thống chỉ lưu public key để xác minh chữ ký. Private key vẫn do bạn giữ và không cần gửi lên website.</p>
            </div>
        </div>
    </div>

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
                    <td>${k.revokedAt != null ? k.revokedAt : '-'}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<c:if test="${not empty generatedPrivateKey}">
    <div class="key-choice-overlay" role="dialog" aria-modal="true" aria-labelledby="keyChoiceTitle">
        <div class="key-choice-dialog">
            <h2 id="keyChoiceTitle">Chọn cách lưu private key</h2>
            <p>Hãy lưu private key bằng các cách thức sau.</p>

            <div class="key-choice-grid">
                <div class="key-choice-box">
                    <h3>Lưu file khóa</h3>
                    <p>Tải private key về máy.</p>
                    <form action="key" method="POST">
                        <input type="hidden" name="action" value="download-generated-key"/>
                        <button type="submit" class="btn-primary">Lưu file khóa</button>
                    </form>
                </div>

                <div class="key-choice-box">
                    <h3>Gửi mail</h3>
                    <p>Nhập địa chỉ Gmail để nhận private key.</p>
                    <div class="gmail-row">
                        <input id="gmailAddress" type="email" placeholder="ten@gmail.com" autocomplete="email"/>
                        <button type="button" class="btn-secondary" onclick="openGmailDraft()">Gửi mail</button>
                    </div>
                    <div id="gmailError" class="key-choice-error"></div>
                </div>
            </div>

            <form action="key" method="POST" class="key-choice-actions">
                <input type="hidden" name="action" value="clear-generated-key"/>
                <button type="submit" class="btn-secondary">Đóng</button>
            </form>

            <textarea id="privateKeyValue" class="private-key-source"><c:out value="${generatedPrivateKey}"/></textarea>
            <input id="privateKeyFileName" type="hidden" value="<c:out value='${generatedPrivateKeyFileName}'/>"/>
        </div>
    </div>
</c:if>

<script>
    function importOwnPublicKeyFile(pubKey) {
        const file = pubKey.files && pubKey.files[0];
        const fileNameBox = document.getElementById('ownPublicKeyFileName');
        const publicKeyInput = document.getElementById('ownPublicKeyInput');

        if (!file) {
            return;
        }

        const reader = new FileReader();
        reader.onload = function () {
            publicKeyInput.value = String(reader.result || '').trim();
            fileNameBox.textContent = file.name;
        };
        reader.onerror = function () {
            fileNameBox.textContent = 'Không đọc được file public key.';
            input.value = '';
        };
        reader.readAsText(file);
    }

    function openGmailDraft() {
        const gmailInput = document.getElementById('gmailAddress');
        const errorBox = document.getElementById('gmailError');
        const email = gmailInput.value.trim();

        if (!/^[^\s@]+@gmail\.com$/i.test(email)) {
            errorBox.textContent = 'Hãy nhập địa chỉ Gmail hợp lệ.';
            return;
        }

        const privateKey = document.getElementById('privateKeyValue').textContent;
        const fileName = document.getElementById('privateKeyFileName').value || 'private_key.pem';
        const subject = 'Private key ' + fileName;
        const body = 'Private key cua ban:\n\n' + privateKey;
        const gmailUrl = 'https://mail.google.com/mail/?view=cm&fs=1' + '&to=' + encodeURIComponent(email) + '&su=' + encodeURIComponent(subject) + '&body=' + encodeURIComponent(body);

        errorBox.textContent = '';
        window.open(gmailUrl, '_blank', 'noopener');
    }
</script>
<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>

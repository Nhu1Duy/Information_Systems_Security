<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="vi">
<head>
    <title>Đăng ký - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .auth-container { max-width: 450px; margin: 3rem auto; padding: 2.5rem; background: var(--card-bg); border-radius: 12px; box-shadow: var(--shadow); border: 1px solid var(--border-color); }
        .auth-header { text-align: center; margin-bottom: 2rem; }
        .auth-form { display: flex; flex-direction: column; gap: 1rem; }
        .form-group { display: flex; flex-direction: column; gap: 0.4rem; }
        .form-group label { font-family: var(--font-primary); font-weight: 600; font-size: 0.85rem; }
        .form-group input { padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 8px; background: var(--bg-color); color: var(--text-color); }
        .auth-footer { text-align: center; margin-top: 1.5rem; font-size: 0.9rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main class="container">
    <div class="auth-container">
        <div class="auth-header">
            <h2>Tạo tài khoản</h2>
            <p>Tham gia FreshMart để nhận thực phẩm tươi mỗi ngày!</p>
        </div>

        <form action="${pageContext.request.contextPath}/signup" method="post" class="auth-form">

            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" placeholder="Chọn tên đăng nhập" required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Tối thiểu 8 ký tự" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Tạo tài khoản</button>
        </form>

        <div class="auth-footer">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập tại đây</a>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng nhập - FreshMart</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .auth-container { max-width: 400px; margin: 4rem auto; padding: 2rem; background: var(--card-bg); border-radius: 12px; box-shadow: var(--shadow); border: 1px solid var(--border-color); }
        .auth-header { text-align: center; margin-bottom: 2rem; }
        .auth-form { display: flex; flex-direction: column; gap: 1.2rem; }
        .form-group { display: flex; flex-direction: column; gap: 0.5rem; }
        .form-group label { font-family: var(--font-primary); font-weight: 600; font-size: 0.9rem; }
        .form-group input { padding: 0.8rem; border: 1px solid var(--border-color); border-radius: 8px; background: var(--bg-color); color: var(--text-color); font-family: var(--font-secondary); }
        .auth-footer { text-align: center; margin-top: 1.5rem; font-size: 0.9rem; }
        .auth-footer a { font-weight: 700; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main class="container">
    <div class="auth-container">
        <div class="auth-header">
            <h2>Nhông xê ô!</h2>
            <p>Vui lòng nhập thông tin để đăng nhập.</p>
        </div>

        <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập của bạn" required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%;">Đăng nhập</button>
        </form>

        <div class="auth-footer">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/signup">Đăng ký</a>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>

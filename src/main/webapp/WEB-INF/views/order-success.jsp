<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="vi">
<head>
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>

<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>
<div style="text-align:center; margin-top:100px;">

    <h1>🎉 Đặt hàng thành công!</h1>

    <p>Đơn hàng của bạn đã được đặt thành công.</p>

    <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
        Tiếp tục mua sắm
    </a>

</div>
<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>

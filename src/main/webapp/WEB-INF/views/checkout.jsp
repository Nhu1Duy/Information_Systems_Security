<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thanh toán - FreshMart</title>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/cart.css">
</head>

<body>

<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main class="container cart-page">

    <h1 class="shop-page h1">Thanh toán</h1>

    <table class="cart-table">
        <thead>
        <tr>
            <th>Sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Tạm tính</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${cartItems}" var="item">
            <tr>

                <td>
                    <div style="display:flex; align-items:center; gap:1rem;">
                        <img src="${item.product.image}" class="cart-img">
                        <div>
                            <strong>${item.product.name}</strong><br>
                            <small>${item.product.category.name}</small>
                        </div>
                    </div>
                </td>

                <td>
                    <fmt:formatNumber
                            value="${item.product.price}"
                            type="currency"
                            currencySymbol="VND"
                            maxFractionDigits="0"/>
                </td>

                <td>${item.quantity}</td>

                <td>
                    <fmt:formatNumber
                            value="${item.product.price * item.quantity}"
                            type="currency"
                            currencySymbol="VND"
                            maxFractionDigits="0"/>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="cart-summary-box">

        <div class="summary-row">
            <span>Tổng thanh toán:</span>
            <span class="total-price">
        <fmt:formatNumber
                value="${cartTotal}"
                type="currency"
                currencySymbol="VND"
                maxFractionDigits="0"/>
      </span>
        </div>

        <form action="checkout" method="POST">
            <button type="submit" class="btn btn-primary checkout-btn">
                Thanh toán ngay
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/cart"
           style="display:block;text-align:center;margin-top:1rem;">
            Quay lại giỏ hàng
        </a>

    </div>

</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>

</body>
</html>

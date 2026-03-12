<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/static/css/cart.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/productDetail.css" />
</head>

<body>

<jsp:include page="/WEB-INF/layout/header.jsp"/>

<section class="product-detail">
    <div class="container">

        <div class="detail-grid">

            <div class="detail-image">
                <img src="${product.image}" alt="Sản phẩm">
            </div>

            <div class="detail-info">

                <h1>${product.name}</h1>

                <p class="product-detail-category">
                    Danh mục: ${product.category.toString()}
                </p>
                <p class="product-detail-category">
                    Còn lại: ${product.stock}
                </p>
                <p class="price">
                    <fmt:formatNumber value="${product.price}" type="currency" maxFractionDigits="0"
                                      currencySymbol="VND"/> / ${product.unit.name}
                </p>

                <p class="description">
                    ${product.description}
                </p>

                <div class="quantity-box">
                    <label>Số lượng</label>

                    <div class="quantity-control">
                        <button type="button" class="qty-btn minus">-</button>

                        <input type="number"name="quantity" id="quantity" value="1" min="1">

                        <button type="button" class="qty-btn plus">+</button>
                    </div>
                </div>

                <form class="cart-action-form" action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" class="real-quantity" value="1">
                    <button type="submit" class="btn btn-add-cart">Bỏ vào giỏ</button>
                </form>
                <form class="cart-action-form" action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="hidden" name="action" value="buynow">
                    <input type="hidden" name="quantity" class="real-quantity" value="1">
                    <button class="btn btn-primary add-to-cart-btn">Lụm</button>
                </form>

            </div>

        </div>

    </div>
</section>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {

        const qtyInput = document.getElementById('quantity');
        const btnMinus = document.querySelector('.qty-btn.minus');
        const btnPlus = document.querySelector('.qty-btn.plus');
        const forms = document.querySelectorAll('.cart-action-form');

        btnPlus.addEventListener('click', function() {
            qtyInput.value = parseInt(qtyInput.value) + 1;
        });

        btnMinus.addEventListener('click', function() {
            let value = parseInt(qtyInput.value);
            if (value > 1) qtyInput.value = value - 1;
        });

        forms.forEach(form => {
            form.addEventListener('submit', function() {
                const hiddenInput = this.querySelector('.real-quantity');
                hiddenInput.value = qtyInput.value;
            });
        });

    });
</script>
</html>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>FreshMart - Thực phẩm tươi mỗi ngày</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/static/css/cart.css"/>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>
<main>
    <!-- Hero Section -->
    <section id="home" class="hero-section">
        <div class="container hero-content">
            <h1>Thực phẩm tươi giao hàng mỗi ngày</h1>
            <p>
                Nhận sản phẩm chất lượng nhất: rau củ, sữa và nhu yếu phẩm ngay tại nhà bạn.
            </p>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua ngay</a>
        </div>
    </section>

    <!-- Category Section -->
    <section class="category-section container">
        <h2>Mua theo danh mục</h2>
        <div class="category-grid">
            <c:forEach items="${categories}" var="cat">
                <div class="category-card">
                    <a href="shop?categoryId=${cat.id}" class="category-link">
                        <img src="${cat.image}" alt="${cat.name}"/>
                        <h3>${cat.name}</h3>
                    </a>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Promotional Section -->
    <section class="promotional-section">
        <div class="container promo-content">
            <h2>Khuyến mãi đặc biệt 0%!</h2>
            <p>HÉ HÉ HÉ.</p>
        </div>
    </section>

    <!-- Featured Products -->
    <section id="featured" class="featured-products container">
        <h2>Sản phẩm bán chạy</h2>
        <div id="bestseller-grid" class="product-grid">
            <c:forEach items="${products}" var="p">

                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="product-link">
                        <div class="product-image">
                            <img src="${p.image}" alt="${p.name}">
                        </div>
                        <div class="product-info">
                            <span class="category-tag">${p.category.name}</span>
                            <h3>${p.name}</h3>
                            <p class="price">
                                <fmt:formatNumber value="${p.price}" type="currency" maxFractionDigits="0"
                                                  currencySymbol="VND"/>
                                / ${p.unit.name}
                            </p>
                        </div>
                    </a>
                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="productId" value="${p.id}">
                        <input type="hidden" name="action" value="add">
                        <button type="submit" class="btn btn-add-cart">Thêm vào giỏ</button>
                    </form>
                </div>

            </c:forEach>
        </div>
    </section>

</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>

<!-- Scroll to top -->
<button class="scroll-top-btn" aria-label="Cuộn lên đầu trang">
    <i class="fas fa-arrow-up"></i>
</button>
</body>
<script>
    const scrollTopBtn = document.querySelector('.scroll-top-btn');
    if (scrollTopBtn) {
        window.addEventListener('scroll', () => {
            scrollTopBtn.classList.toggle('visible', window.scrollY > 300);
        });
        scrollTopBtn.addEventListener('click', () => {
            window.scrollTo({top: 0, behavior: 'smooth'});
        });
    }
</script>
</html>

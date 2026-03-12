<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Mua tất cả sản phẩm - FreshMart</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link
          href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap"
          rel="stylesheet"
  />
  <link rel="stylesheet"  href="${pageContext.request.contextPath}/static/css/style.css"/>
  <link rel="stylesheet"  href="${pageContext.request.contextPath}/static/css/cart.css"/>
</head>
<body>

<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main>
  <section class="shop-page container">
    <h1>Sản phẩm của chúng tôi</h1>

    <div class="shop-controls">
      <div class="filter-control">
        <label for="category-filter">Lọc theo danh mục:</label>
        <select id="category-filter" name="category" onchange="applyFilters()">
          <option value="all">Tất cả danh mục</option>
          <c:forEach items="${categories}" var="cat">
            <option value="${cat.id}" ${param.categoryId.toString() == cat.id.toString() ? 'selected' : ''}>
                ${cat.name}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="sort-control">
        <label for="sort-options">Sắp xếp theo:</label>
        <select id="sort-options" name="sort" onchange="applyFilters()">
          <option value="default" ${param.sort == 'default' || empty param.sort ? 'selected' : ''}>Mặc định</option>
          <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
          <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
          <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Tên: A-Z</option>
          <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Tên: Z-A</option>
        </select>
      </div>
    </div>
    <main class="container"><c:if test="${not empty searchTitle}">
      <h2 style="margin-top: 2rem;">${searchTitle}</h2>
    </c:if></main>
    <div id="product-grid-shop" class="product-grid">


      <c:forEach items="${products}" var="p">

        <div class="product-card" data-id="${p.id}">
          <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="product-link">
            <div class="product-image">
              <img src="${p.image}" alt="${p.name}">
            </div>
            <div class="product-info">
              <span class="category-tag">${p.category.name}</span>
              <h3>${p.name}</h3>
              <p class="price">
                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
                <span>/ ${p.unit.name}</span>
              </p>
            </div>
          </a>

          <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="productId" value="${p.id}">
            <input type="hidden" name="action" value="add">
            <button type="submit" class="btn btn-add-cart">Thêm vào giỏ</button>
          </form>
          <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="productId" value="${p.id}">
            <input type="hidden" name="action" value="buynow">
            <button class="btn btn-primary add-to-cart-btn">Mua ngay</button>
          </form>
        </div>

      </c:forEach>
    </div>
  </section>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>

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
  function applyFilters(){
    const categoryId = document.getElementById('category-filter').value;
    const sort = document.getElementById('sort-options').value;
    const urlParams = new URLSearchParams(window.location.search);
    urlParams.set('categoryId', categoryId);
    urlParams.set('sort',sort);
    window.location.search = urlParams.toString();
    }
</script>
</html>

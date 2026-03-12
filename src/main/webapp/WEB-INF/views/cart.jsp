<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Giỏ hàng của bạn - FreshMart</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/cart.css">
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>

<main class="container cart-page">
  <h1 class="shop-page h1">Giỏ hàng của bạn</h1>

  <c:choose>
    <c:when test="${not empty cartItems}">
      <table class="cart-table">
        <thead>
        <tr>
          <th>Sản phẩm</th>
          <th>Giá</th>
          <th>Số lượng</th>
          <th>Tạm tính</th>
          <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${cartItems}" var="item">
          <tr>
            <td>
              <div style="display: flex; align-items: center; gap: 1rem;">
                <img src="${item.product.image}" class="cart-img" alt="${item.product.name}">
                <div>
                  <strong style="display: block;">${item.product.name}</strong>
                  <small style="opacity: 0.7;">${item.product.category.name}</small>
                </div>
              </div>
            </td>
            <td>
              <fmt:formatNumber value="${item.product.price}"
                                type="currency"
                                currencySymbol="VND"
                                maxFractionDigits="0"/>
            </td>
            <td>
              <div class="qty-control">
                <form action="cart" method="POST" style="display:inline;">
                  <input type="hidden" name="productId" value="${item.product.id}">
                  <input type="hidden" name="action" value="decrease">
                  <button type="submit" class="qty-btn">-</button>
                </form>
                <span style="min-width: 30px; text-align: center;">${item.quantity}</span>
                <form action="cart" method="POST" style="display:inline;">
                  <input type="hidden" name="productId" value="${item.product.id}">
                  <input type="hidden" name="action" value="increase">
                  <button type="submit" class="qty-btn">+</button>
                </form>
              </div>
            </td>
            <td>
              <fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
            </td>
            <td>
              <a href="cart?action=remove&productId=${item.product.id}"><i class="fas fa-trash"></i> Xóa</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>

      <div class="cart-summary-box">
        <div class="summary-row">
          <span>Tổng cộng:</span>
          <span class="total-price">
            <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
          </span>
        </div>
        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary checkout-btn">Tiến hành thanh toán</a>
        <a href="${pageContext.request.contextPath}/shop" style="display: block; text-align: center; margin-top: 1rem; font-size: 0.9rem;">Tiếp tục mua sắm</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="empty-cart-msg">
        <i class="fas fa-shopping-basket" style="font-size: 4rem; color: var(--border-color); margin-bottom: 1rem;"></i>
        <h2>Giỏ hàng của bạn đang trống!</h2>
        <p>Có vẻ như bạn chưa thêm sản phẩm nào vào giỏ.</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary" style="margin-top: 1.5rem;">Bắt đầu mua sắm</a>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>

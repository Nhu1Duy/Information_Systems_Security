<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="header">
    <nav class="navbar container">
        <a href="${pageContext.request.contextPath}/home" class="logo">FreshMart</a>
        <form action="${pageContext.request.contextPath}/shop" method="get" class="search-bar">
            <input type="text" placeholder="Tìm kiếm sản phẩm..."name="search"   value="${param.search}"/>
            <button type="submit"><i class="fas fa-search"></i></button>
        </form>
        <ul class="nav-links">
            <li>
                <a href="${pageContext.request.contextPath}/home"
                   class="${currentPage == 'home' ? 'active' : ''}">Trang chủ</a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/shop"
                   class="${currentPage == 'shop' ? 'active' : ''}">Cửa hàng</a>
            </li>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'admin'}">
                <li>
                    <a href="${pageContext.request.contextPath}/adminProduct"
                       style="color: var(--primary-green); font-weight: bold;">
                        <i class="fas fa-user-shield"></i> Quản trị
                    </a>
                </li>
            </c:if>
            <li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/logout">(Đăng xuất)</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </li>
        </ul>
        <div class="nav-icons">
            <a href="${pageContext.request.contextPath}/cart" class="cart-icon" aria-label="Giỏ hàng">
                <i class="fas fa-shopping-cart"></i>
            </a>
        </div>
    </nav>
</header>

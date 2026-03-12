<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="header">
    <nav class="navbar container">
        <a href="${pageContext.request.contextPath}/home" class="logo">FreshMart</a>
        <ul class="nav-links">

            <li>
                <a href="${pageContext.request.contextPath}/adminProduct"
                   class="${currentPage == 'shop' ? 'active' : ''}">Sản Phẩm</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/adminUser"
                   class="${currentPage == 'shop' ? 'active' : ''}">Người Dùng</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/adminOrder"
                   class="${currentPage == 'shop' ? 'active' : ''}">Đơn Hàng</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/adminOther"
                   class="${currentPage == 'shop' ? 'active' : ''}">Đơn vị</a>
            </li>
            <li>
                        <a href="${pageContext.request.contextPath}/logout">(Đăng xuất)</a>
            </li>
            <li>
            <a href="${pageContext.request.contextPath}/shop"
               class="${currentPage == 'shop' ? 'active' : ''}">Cửa hàng</a>
        </li>
        </ul>
    </nav>
</header>

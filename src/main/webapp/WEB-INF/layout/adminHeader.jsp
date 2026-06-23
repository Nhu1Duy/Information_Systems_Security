<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="header">
    <nav class="navbar container">
        <a href="${pageContext.request.contextPath}/home" class="logo">FreshMart</a>
        <ul class="nav-links">

            <li>
                <a href="${pageContext.request.contextPath}/adminProduct"
                   class="${currentPage == 'shop' ? 'active' : ''}">Sản phẩm</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/adminUser"
                   class="${currentPage == 'shop' ? 'active' : ''}">Người dùng</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/adminOrder"
                   class="${currentPage == 'shop' ? 'active' : ''}">Đơn hàng</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/adminOther"
                   class="${currentPage == 'shop' ? 'active' : ''}">Đơn vị</a>
            </li>
            <li>
	            <a href="${pageContext.request.contextPath}/shop"
	               class="${currentPage == 'shop' ? 'active' : ''}">Cửa hàng</a>
        	</li>
            <li>
                 <a href="${pageContext.request.contextPath}/logout">(Đăng xuất)</a>
            </li>
            
        </ul>
    </nav>
</header>

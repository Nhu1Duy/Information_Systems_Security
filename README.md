Ecommerce Web Application

Đây là một ứng dụng web bán hàng (E-commerce) được xây dựng bằng Java Servlet, JSP và Maven.
Dự án mô phỏng các chức năng cơ bản của một website bán hàng như xem sản phẩm, thêm vào giỏ hàng, đặt hàng và quản lý sản phẩm ở trang admin.

== SQL == 

link full SQL: https://drive.google.com/file/d/1Kw5zzqfW2pw_1CmOtNSe6tQLJsUQjP-u/view?usp=drive_link

Setting tại JdbiConnector: 

                String url = "jdbc:mysql://localhost:3306/ecommerceweb?useSSL=false&serverTimezone=UTC";

                String user = "root";
                
                String password = "";
                
== Requirement ==

JDK 21, MySQL, Tomcat 10, Maven, có thể sử dụng IntelliJ IDEA.


++ Cần: chưa có validation, thông báo khi thay đổi (hoàn thành 50%), chưa băm mật khẩu, chưa áp dụng ajax, chưa phân trang, bắt exeption(50%)

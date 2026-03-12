package com.example.ecommerceweb.DAO;

import com.example.ecommerceweb.DAO.JdbiConnector;
import com.example.ecommerceweb.mapper.ProductMapper;
import com.example.ecommerceweb.model.Category;
import com.example.ecommerceweb.model.Product;
import com.example.ecommerceweb.model.Unit;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ProductDAO {

    //    public static List<Product> getAllProducts(String sortType) {
//        String orderBy = getOrderByClause(sortType);
//        Jdbi jdbi = JdbiConnector.get();
//        try (Handle handle = jdbi.open()) {
//            String sql = "SELECT p.*, " +
//                    "c.id AS c_id, c.name AS c_name, c.image AS c_image, " +
//                    "u.id AS u_id, u.name AS u_name " +
//                    "FROM products p " +
//                    "JOIN categories c ON p.category_id = c.id " +
//                    "JOIN units u ON p.unit_id = u.id" +
//                    orderBy;
//            return handle.createQuery(sql).map(new ProductMapper()).list();
//        }
//    }
    public static List<Product> getFilteredProducts(String search, String catId, String sort) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            StringBuilder sql = new StringBuilder(
                    "SELECT p.*, c.id AS c_id, c.name AS c_name, c.image AS c_image, u.id AS u_id, u.name AS u_name " +
                            "FROM products p JOIN categories c ON p.category_id = c.id JOIN units u ON p.unit_id = u.id WHERE 1=1"
            );
            if (search != null && !search.isEmpty()) sql.append(" AND p.name LIKE :search");
            if (catId != null && !catId.equals("all")) sql.append(" AND p.category_id = :catId");
            sql.append(getOrderByClause(sort));
            org.jdbi.v3.core.statement.Query query = handle.createQuery(sql.toString());
            if (search != null && !search.isEmpty()) query.bind("search", "%" + search + "%");
            if (catId != null && !catId.equals("all")) query.bind("catId", catId);

            return query.map(new ProductMapper()).list();
        }
    }

    public static List<Product> getAllProductsForHome() {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT p.*, " +
                    "c.id AS c_id, c.name AS c_name, c.image AS c_image, " +
                    "u.id AS u_id, u.name AS u_name " +
                    "FROM products p " +
                    "JOIN categories c ON p.category_id = c.id " +
                    "JOIN units u ON p.unit_id = u.id";
            return handle.createQuery(sql).map(new ProductMapper()).list();
        }
    }

    public static Product getProductById(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT p.*, " +
                    "c.id AS c_id, c.name AS c_name, c.image AS c_image, " +
                    "u.id AS u_id, u.name AS u_name " +
                    "FROM products p " +
                    "JOIN categories c ON p.category_id = c.id " +
                    "JOIN units u ON p.unit_id = u.id " +
                    "WHERE p.id = :id";

            RowMapper<Product> mapper = new RowMapper<Product>() {
                @Override
                public Product map(ResultSet rs, StatementContext ctx) throws SQLException {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setStock(rs.getInt("stock"));

                    Category cat = new Category();
                    cat.setId(rs.getInt("c_id"));
                    cat.setName(rs.getString("c_name"));
                    cat.setImage(rs.getString("c_image"));
                    p.setCategory(cat);

                    Unit unit = new Unit();
                    unit.setId(rs.getInt("u_id"));
                    unit.setName(rs.getString("u_name"));
                    p.setUnit(unit);

                    return p;
                }
            };

            return handle.createQuery(sql)
                    .bind("id", id)
                    .map(mapper)
                    .findOne()
                    .orElse(null);
        }
    }

    public static List<Product> getByCategory(int categoryId, String sortType) {
        String orderBy = getOrderByClause(sortType);
        String sql = "SELECT p.* FROM products p WHERE p.category_id = :cid" + orderBy;

        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(sql)
                    .bind("cid", categoryId)
                    .mapToBean(Product.class)
                    .list();
        }
    }

    public static List<Product> searchProduct(String query, String sortType) {
        String orderBy = getOrderByClause(sortType);
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT p.*, " +
                    "c.id AS c_id, c.name AS c_name, c.image AS c_image, " +
                    "u.id AS u_id, u.name AS u_name " +
                    "FROM products p " +
                    "JOIN categories c ON p.category_id = c.id " +
                    "JOIN units u ON p.unit_id = u.id " +
                    "WHERE p.name LIKE :query" +
                    orderBy;
            return handle.createQuery(sql)
                    .bind("query", "%" + query + "%")
                    .map(new ProductMapper())
                    .list();
        }
    }

    private static String getOrderByClause(String sortType) {
        if (sortType == null) return "";
        switch (sortType) {
            case "price-asc":
                return " ORDER BY p.price ASC";
            case "price-desc":
                return " ORDER BY p.price DESC";
            case "name-asc":
                return " ORDER BY p.name ASC";
            case "name-desc":
                return " ORDER BY p.name DESC";
            default:
                return " ORDER BY p.id DESC";
        }
    }

    ///  ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN -- ADMIN
    public static void insert(Product p) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("INSERT INTO products (name, description, price, image, category_id, unit_id, stock) " +
                            "VALUES (:name, :description, :price, :image, :catId, :unitId, :stock)")
                    .bind("name", p.getName())
                    .bind("description", p.getDescription())
                    .bind("price", p.getPrice())
                    .bind("image", p.getImage())
                    .bind("catId", p.getCategory().getId())
                    .bind("unitId", p.getUnit().getId())
                    .bind("stock", p.getStock())
                    .execute();
        }
    }

    public static void update(Product p) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("UPDATE products SET name=:name, description=:description, price=:price, " +
                            "image=:image, category_id=:catId, unit_id=:unitId, stock=:stock WHERE id=:id")
                    .bind("id", p.getId())
                    .bind("name", p.getName())
                    .bind("description", p.getDescription())
                    .bind("price", p.getPrice())
                    .bind("image", p.getImage())
                    .bind("catId", p.getCategory().getId())
                    .bind("unitId", p.getUnit().getId())
                    .bind("stock", p.getStock())
                    .execute();
        }
    }

    public static void delete(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("DELETE FROM products WHERE id = :id").bind("id", id).execute();
        }
    }
}
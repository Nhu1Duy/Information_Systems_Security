package com.example.ecommerceweb.mapper;

import com.example.ecommerceweb.model.Category;
import com.example.ecommerceweb.model.Product;
import com.example.ecommerceweb.model.Unit;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductMapper implements RowMapper {
    @Override
    public Object map(ResultSet rs, StatementContext ctx) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("c_id"));
        category.setName(rs.getString("c_name"));
        category.setImage(rs.getString("c_image"));

        Unit unit = new Unit();
        unit.setId(rs.getInt("u_id"));
        unit.setName(rs.getString("u_name"));

        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setImage(rs.getString("image"));
        product.setCategory(category);
        product.setUnit(unit);
        product.setStock(rs.getInt("stock"));

        return product;
    }
}

package com.LiquorHub.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dto.CategoryDTO;
import com.LiquorHub.utility.Connector;


public class CategoryDAOImpl implements com.LiquorHub.dao.CategoryDAO {

    private Connection con;

    public CategoryDAOImpl() {
        con = Connector.requestConnection();
    }

    @Override
    public boolean addCategory(CategoryDTO category) {

        String sql = "INSERT INTO Category(category_name) VALUES(?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, category.getCategoryName());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateCategory(CategoryDTO category) {

        String sql = "UPDATE Category SET category_name=? WHERE category_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, category.getCategoryName());
            ps.setInt(2, category.getCategoryId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteCategory(int categoryId) {

        String sql = "DELETE FROM Category WHERE category_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, categoryId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public CategoryDTO getCategoryById(int categoryId) {

        String sql = "SELECT * FROM Category WHERE category_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                CategoryDTO category = new CategoryDTO();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));

                return category;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<CategoryDTO> getAllCategories() {

        List<CategoryDTO> categories = new ArrayList<>();

        String sql = "SELECT * FROM Category";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CategoryDTO category = new CategoryDTO();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));

                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
}
package com.liqourhub.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.liqourhub.dao.ProductDAO;
import com.liqourhub.dto.Product;
import com.liqourhub.utility.Connector;

public class ProductDAOImpl implements ProductDAO {

    private Connection con;

    public ProductDAOImpl() {
        con = Connector.getConnection();
    }

    @Override
    public boolean addProduct(Product product) {

        String sql = "INSERT INTO Product(category_id, product_name, brand, price, stock) VALUES(?,?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getBrand());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateProduct(Product product) {

        String sql = "UPDATE Product SET category_id=?, product_name=?, brand=?, price=?, stock=? WHERE product_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getBrand());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setInt(6, product.getProductId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteProduct(int productId) {

        String sql = "DELETE FROM Product WHERE product_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, productId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Product getProductById(int productId) {

        String sql = "SELECT * FROM Product WHERE product_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));

                return product;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Product";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));

                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Product WHERE category_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));

                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
}
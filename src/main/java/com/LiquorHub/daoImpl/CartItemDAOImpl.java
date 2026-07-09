package com.liqourhub.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.liqourhub.dao.CartItemDAO;
import com.liqourhub.dto.CartItem;
import com.liqourhub.utility.Connector;

public class CartItemDAOImpl implements CartItemDAO {

    private Connection con;

    public CartItemDAOImpl() {
        con = Connector.getConnection();
    }

    @Override
    public boolean addItem(CartItem cartItem) {

        String sql = "INSERT INTO CartItem(cart_id, product_id, quantity) VALUES(?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartItem.getCartId());
            ps.setInt(2, cartItem.getProductId());
            ps.setInt(3, cartItem.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateQuantity(int cartItemId, int quantity) {

        String sql = "UPDATE CartItem SET quantity=? WHERE cart_item_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean removeItem(int cartItemId) {

        String sql = "DELETE FROM CartItem WHERE cart_item_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<CartItem> getCartItems(int cartId) {

        List<CartItem> items = new ArrayList<>();

        String sql = "SELECT * FROM CartItem WHERE cart_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItem item = new CartItem();

                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setCartId(rs.getInt("cart_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));

                items.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }
}
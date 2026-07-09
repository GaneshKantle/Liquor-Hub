package com.liqourhub.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.liqourhub.dao.CartDAO;
import com.liqourhub.dto.Cart;
import com.liqourhub.utility.Connector;

public class CartDAOImpl implements CartDAO {

    private Connection con;

    public CartDAOImpl() {
        con = Connector.getConnection();
    }

    @Override
    public boolean createCart(Cart cart) {

        String sql = "INSERT INTO Cart(customer_id) VALUES(?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cart.getCustomerId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Cart getCartByCustomerId(int customerId) {

        String sql = "SELECT * FROM Cart WHERE customer_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, customerId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Cart cart = new Cart();

                cart.setCartId(rs.getInt("cart_id"));
                cart.setCustomerId(rs.getInt("customer_id"));

                return cart;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean deleteCart(int cartId) {

        String sql = "DELETE FROM Cart WHERE cart_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
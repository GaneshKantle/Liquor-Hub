package com.LiquorHub.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dao.CartItemDAO;
import com.LiquorHub.dto.CartItemDTO;
import com.LiquorHub.utility.Connector;

public class CartItemDAOImpl implements CartItemDAO {

    private Connection con;

    public CartItemDAOImpl() {
        con = Connector.requestConnection();
    }

    @Override
    public boolean addItem(CartItemDTO cartItem) {

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
    public List<CartItemDTO> getCartItems(int cartId) {

        List<CartItemDTO> items = new ArrayList<>();

        String sql = "SELECT * FROM CartItem WHERE cart_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItemDTO item = new CartItemDTO();

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
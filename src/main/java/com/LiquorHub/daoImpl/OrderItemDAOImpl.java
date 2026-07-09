package com.LiquorHub.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dao.OrderItemDAO;
import com.LiquorHub.dto.OrderItemDTO;
import com.LiquorHub.utility.Connector;


public class OrderItemDAOImpl implements OrderItemDAO {

    private Connection con;

    public OrderItemDAOImpl() {
        con = Connector.requestConnection();
    }

    @Override
    public boolean addOrderItem(OrderItemDTO orderItem) { 

        String sql = "INSERT INTO OrderItem(order_id, product_id, quantity) VALUES(?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getProductId());
            ps.setInt(3, orderItem.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<OrderItemDTO> getOrderItems(int orderId) {

        List<OrderItemDTO> orderItems = new ArrayList<>();

        String sql = "SELECT * FROM OrderItem WHERE order_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItemDTO item = new OrderItemDTO();

                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));

                orderItems.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }


}
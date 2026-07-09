package com.liqourhub.dao;

import java.util.List;
import com.liqourhub.dto.Orders;

public interface OrdersDAO {

	boolean placeOrder(Orders order);

	boolean updateOrderStatus(int orderId, String status);

	Orders getOrderById(int orderId);

	List<Orders> getOrdersByCustomer(int customerId);

	List<Orders> getAllOrders();

}
package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.OrderDTO;

public interface OrdersDAO {

	boolean placeOrder(OrderDTO order);

	boolean updateOrderStatus(int orderId, String status);

	OrderDTO getOrderById(int orderId);

	List<OrderDTO> getOrdersByCustomer(int customerId);

	List<OrderDTO> getAllOrders();

}
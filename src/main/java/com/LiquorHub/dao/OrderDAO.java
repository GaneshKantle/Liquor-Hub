package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.OrderDTO;

public interface OrderDAO {
	public boolean placeOrder(OrderDTO order);
	
	public boolean updateOrderStatus(int orderId, String status);
	
	public OrderDTO getOrderById(int orderId);
	
	public List<OrderDTO> getOrdersByCustomer(int customerId);
	
	public List<OrderDTO> getAllOrders();
}

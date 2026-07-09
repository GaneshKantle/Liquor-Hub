package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.OrderItemDTO;

public interface OrderItemDAO {

	boolean addOrderItem(OrderItemDTO orderItem);

	List<OrderItemDTO> getOrderItems(int orderId);

}
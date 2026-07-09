package com.liqourhub.dao;

import java.util.List;
import com.liqourhub.dto.OrderItem;

public interface OrderItemDAO {

	boolean addOrderItem(OrderItem orderItem);

	List<OrderItem> getOrderItems(int orderId);

}
package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.CartItemDTO;

public interface CartItemDAO {

	boolean addItem(CartItemDTO cartItem);

	boolean updateQuantity(int cartItemId, int quantity);

	boolean removeItem(int cartItemId);

	List<CartItemDTO> getCartItems(int cartId);

}
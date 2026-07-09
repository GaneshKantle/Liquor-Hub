package com.liqourhub.dao;

import java.util.List;
import com.liqourhub.dto.CartItem;

public interface CartItemDAO {

	boolean addItem(CartItem cartItem);

	boolean updateQuantity(int cartItemId, int quantity);

	boolean removeItem(int cartItemId);

	List<CartItem> getCartItems(int cartId);

}
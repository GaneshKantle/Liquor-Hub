package com.liqourhub.dao;

import com.liqourhub.dto.Cart;

public interface CartDAO {

	boolean createCart(Cart cart);

	Cart getCartByCustomerId(int customerId);

	boolean deleteCart(int cartId);

}
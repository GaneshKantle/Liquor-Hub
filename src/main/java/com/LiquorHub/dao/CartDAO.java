package com.LiquorHub.dao;

import com.LiquorHub.dto.CartDTO;


public interface CartDAO {

	boolean createCart(CartDTO cart);

	CartDTO getCartByCustomerId(int customerId);

	boolean deleteCart(int cartId);

}
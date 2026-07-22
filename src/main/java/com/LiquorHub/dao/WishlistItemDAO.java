package com.LiquorHub.dao;

import java.util.List;
import java.util.Set;

import com.LiquorHub.dto.WishlistItemDTO;

public interface WishlistItemDAO {
	boolean addItem(WishlistItemDTO item);

	boolean removeItem(int wishlistItemId);

	boolean removeByCustomerAndProduct(int customerId, int productId);

	boolean isInWishlist(int customerId, int productId);

	List<WishlistItemDTO> getItemsByCustomer(int customerId);

	Set<Integer> getProductIdsByCustomer(int customerId);

	/** Toggle: returns true if now favourited, false if removed. */
	boolean toggle(int customerId, int productId);
}

package com.LiquorHub.dto;

public class CartDTO {
	private int cartId;
	private int customerId;
	
	@Override
	public String toString() {
		return "CartDTO [cartId=" + cartId + ", customerId=" + customerId + "]";
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	
	
}

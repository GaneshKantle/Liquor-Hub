package com.LiquorHub.dto;

public class CartItemDTO {
	private int cartItemId;
    private int cartId;
    private int productId;
    private int quantity;
    
    
    @Override
	public String toString() {
		return "CartItemDTO [cartItemId=" + cartItemId + ", cartId=" + cartId + ", productId=" + productId
				+ ", quantity=" + quantity + "]";
	}
    
    
	public int getCartItemId() {
		return cartItemId;
	}
	public void setCartItemId(int cartItemId) {
		this.cartItemId = cartItemId;
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
    

}

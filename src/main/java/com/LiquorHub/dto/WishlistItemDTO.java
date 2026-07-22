package com.LiquorHub.dto;

public class WishlistItemDTO {
	private int wishlistItemId;
	private int customerId;
	private int productId;

	@Override
	public String toString() {
		return "WishlistItemDTO [wishlistItemId=" + wishlistItemId + ", customerId=" + customerId + ", productId="
				+ productId + "]";
	}

	public int getWishlistItemId() {
		return wishlistItemId;
	}

	public void setWishlistItemId(int wishlistItemId) {
		this.wishlistItemId = wishlistItemId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}
}

   package com.LiquorHub.dto;

public class ProductDTO {
	private int productId;
    private int categoryId;
    private String productName;
    private String brand;
    private double price;
    private int stock;
    
    
	@Override
	public String toString() {
		return "ProductDTO [productId=" + productId + ", categoryId=" + categoryId + ", productName=" + productName
				+ ", brand=" + brand + ", price=" + price + ", stock=" + stock + "]";
	}
	
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	
    
}

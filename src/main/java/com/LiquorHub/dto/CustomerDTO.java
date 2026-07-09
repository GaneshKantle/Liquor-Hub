package com.LiquorHub.dto;

public class CustomerDTO {
	private int customerId;
	private String name;
	private String email;
	private String password;
	private String phone;
	private String address;
	
	
	@Override
	public String toString() {
		return "CustomerDTO [id= "+ customerId +"name=" + name + ", email=" + email + ", phone=" + phone + ", address=" + address + "]";
	} 
	
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) { 
		this.customerId = customerId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
}

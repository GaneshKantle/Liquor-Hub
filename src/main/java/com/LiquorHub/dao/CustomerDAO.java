package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.CustomerDTO;

public interface CustomerDAO {

	boolean insertCustomer(CustomerDTO customer);

	boolean updateCustomer(CustomerDTO customer);

	boolean deleteCustomer(int customerId);

	CustomerDTO getCustomerById(int customerId);

	CustomerDTO login(String email, String password);

	List<CustomerDTO> getAllCustomers(); 

}
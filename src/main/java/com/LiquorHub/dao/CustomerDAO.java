package com.liqourhub.dao;

import java.util.List;
import com.liqourhub.dto.Customer;

public interface CustomerDAO {

	boolean insertCustomer(Customer customer);

	boolean updateCustomer(Customer customer);

	boolean deleteCustomer(int customerId);

	Customer getCustomerById(int customerId);

	Customer login(String email, String password);

	List<Customer> getAllCustomers();

}

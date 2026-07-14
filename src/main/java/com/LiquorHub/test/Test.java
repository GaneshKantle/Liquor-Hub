package com.LiquorHub.test;

import java.util.List;
import java.util.Scanner;

import com.LiquorHub.dao.CustomerDAO;
import com.LiquorHub.daoImpl.CustomerDAOImpl;
import com.LiquorHub.dto.CustomerDTO;

public class Test {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		CustomerDAO customerDAO = new CustomerDAOImpl();

		System.out.println("=================================");
		System.out.println("   LiquorHub — Console Tester");
		System.out.println("   Rare liquor marketplace");
		System.out.println("=================================");
		System.out.println("1. Login");
		System.out.println("2. Register");
		System.out.print("Choose: ");
		int start = readInt(sc);

		CustomerDTO customer = null;

		if (start == 1) {
			customer = login(sc, customerDAO);
		} else if (start == 2) {
			customer = register(sc, customerDAO);
		} else {
			System.out.println("Invalid choice.");
			sc.close();
			return;
		}

		if (customer == null) {
			System.out.println("Could not continue. Exiting.");
			sc.close();
			return;
		}

		boolean running = true;
		while (running) {
			System.out.println();
			System.out.println("--- Logged in as " + customer.getName() + " ---");
			System.out.println("1. View profile");
			System.out.println("2. Update profile");
			System.out.println("3. Reset password");
			System.out.println("4. View all customers");
			System.out.println("5. Delete my account");
			System.out.println("6. Exit");
			System.out.print("Choose: ");
			int choice = readInt(sc);

			switch (choice) {
			case 1:
				customer = customerDAO.getCustomerById(customer.getCustomerId());
				printProfile(customer);
				break;
			case 2:
				customer = updateProfile(sc, customerDAO, customer);
				break;
			case 3:
				customer = resetPassword(sc, customerDAO, customer);
				break;
			case 4:
				List<CustomerDTO> all = customerDAO.getAllCustomers();
				if (all.isEmpty()) {
					System.out.println("No customers found.");
				} else {
					for (CustomerDTO c : all) {
						System.out.println(c);
					}
				}
				break;
			case 5:
				System.out.print("Type YES to delete account: ");
				if ("YES".equals(sc.nextLine().trim())) {
					if (customerDAO.deleteCustomer(customer.getCustomerId())) {
						System.out.println("Account deleted.");
						running = false;
					} else {
						System.out.println("Delete failed.");
					}
				} else {
					System.out.println("Cancelled.");
				}
				break;
			case 6:
				System.out.println("Goodbye.");
				running = false;
				break;
			default:
				System.out.println("Enter a valid option.");
			}
		}

		sc.close();
	}

	private static CustomerDTO login(Scanner sc, CustomerDAO customerDAO) {
		System.out.print("Email: ");
		String email = sc.nextLine().trim();
		System.out.print("Password: ");
		String password = sc.nextLine().trim();

		CustomerDTO customer = customerDAO.login(email, password);
		if (customer != null) {
			System.out.println("Login successful. Welcome, " + customer.getName() + "!");
		} else {
			System.out.println("Login failed. Check email/password.");
		}
		return customer;
	}

	private static CustomerDTO register(Scanner sc, CustomerDAO customerDAO) {
		CustomerDTO customer = new CustomerDTO();

		System.out.print("Name: ");
		customer.setName(sc.nextLine().trim());
		System.out.print("Email: ");
		customer.setEmail(sc.nextLine().trim());
		System.out.print("Password: ");
		customer.setPassword(sc.nextLine().trim());
		System.out.print("Phone: ");
		customer.setPhone(sc.nextLine().trim());
		System.out.print("Address: ");
		customer.setAddress(sc.nextLine().trim());

		if (customerDAO.insertCustomer(customer)) {
			System.out.println("Account created. Logging you in...");
			return customerDAO.login(customer.getEmail(), customer.getPassword());
		}
		System.out.println("Registration failed.");
		return null;
	}

	private static CustomerDTO updateProfile(Scanner sc, CustomerDAO customerDAO, CustomerDTO customer) {
		CustomerDTO latest = customerDAO.getCustomerById(customer.getCustomerId());
		if (latest == null) {
			System.out.println("Customer not found.");
			return customer;
		}

		System.out.println("Leave blank to keep current value.");
		System.out.print("Name [" + latest.getName() + "]: ");
		String name = sc.nextLine().trim();
		if (!name.isEmpty()) {
			latest.setName(name);
		}

		System.out.print("Email [" + latest.getEmail() + "]: ");
		String email = sc.nextLine().trim();
		if (!email.isEmpty()) {
			latest.setEmail(email);
		}

		System.out.print("Phone [" + latest.getPhone() + "]: ");
		String phone = sc.nextLine().trim();
		if (!phone.isEmpty()) {
			latest.setPhone(phone);
		}

		System.out.print("Address [" + latest.getAddress() + "]: ");
		String address = sc.nextLine().trim();
		if (!address.isEmpty()) {
			latest.setAddress(address);
		}

		if (customerDAO.updateCustomer(latest)) {
			System.out.println("Profile updated.");
			printProfile(latest);
			return latest;
		}
		System.out.println("Update failed.");
		return customer;
	}

	private static CustomerDTO resetPassword(Scanner sc, CustomerDAO customerDAO, CustomerDTO customer) {
		CustomerDTO latest = customerDAO.getCustomerById(customer.getCustomerId());
		if (latest == null) {
			System.out.println("Customer not found.");
			return customer;
		}

		System.out.print("Current password: ");
		String current = sc.nextLine().trim();
		if (!current.equals(latest.getPassword())) {
			System.out.println("Current password is incorrect.");
			return customer;
		}

		System.out.print("New password: ");
		String next = sc.nextLine().trim();
		System.out.print("Confirm password: ");
		String confirm = sc.nextLine().trim();

		if (!next.equals(confirm)) {
			System.out.println("Passwords do not match.");
			return customer;
		}

		latest.setPassword(next);
		if (customerDAO.updateCustomer(latest)) {
			System.out.println("Password updated.");
			return latest;
		}
		System.out.println("Password update failed.");
		return customer;
	}

	private static void printProfile(CustomerDTO customer) {
		if (customer == null) {
			System.out.println("No profile data.");
			return;
		}
		System.out.println("ID      : CUST" + customer.getCustomerId());
		System.out.println("Name    : " + customer.getName());
		System.out.println("Email   : " + customer.getEmail());
		System.out.println("Phone   : " + customer.getPhone());
		System.out.println("Address : " + customer.getAddress());
	}

	private static int readInt(Scanner sc) {
		while (!sc.hasNextInt()) {
			sc.nextLine();
			System.out.print("Enter a number: ");
		}
		int value = sc.nextInt();
		sc.nextLine();
		return value;
	}
}

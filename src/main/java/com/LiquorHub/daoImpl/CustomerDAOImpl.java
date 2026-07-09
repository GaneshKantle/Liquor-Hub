package com.liqourhub.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.liqourhub.dao.CustomerDAO;
import com.liqourhub.dto.Customer;
import com.liqourhub.utility.Connector;

public class CustomerDAOImpl implements CustomerDAO {

    private Connection con;

    public CustomerDAOImpl() {
        con = Connector.getConnection();
    }

    @Override
    public boolean insertCustomer(Customer customer) {

        String sql = "INSERT INTO Customer(name,email,password,phone,address) VALUES(?,?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getPhone());
            ps.setString(5, customer.getAddress());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateCustomer(Customer customer) {

        String sql = "UPDATE Customer SET name=?,email=?,password=?,phone=?,address=? WHERE customer_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getPhone());
            ps.setString(5, customer.getAddress());
            ps.setInt(6, customer.getCustomerId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteCustomer(int customerId) {

        String sql = "DELETE FROM Customer WHERE customer_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, customerId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Customer getCustomerById(int customerId) {

        String sql = "SELECT * FROM Customer WHERE customer_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, customerId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Customer c = new Customer();

                c.setCustomerId(rs.getInt("customer_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPassword(rs.getString("password"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));

                return c;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Customer login(String email, String password) {

        String sql = "SELECT * FROM Customer WHERE email=? AND password=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Customer c = new Customer();

                c.setCustomerId(rs.getInt("customer_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPassword(rs.getString("password"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));

                return c;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Customer> getAllCustomers() {

        List<Customer> customers = new ArrayList<>();

        String sql = "SELECT * FROM Customer";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Customer c = new Customer();

                c.setCustomerId(rs.getInt("customer_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPassword(rs.getString("password"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));

                customers.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }

}
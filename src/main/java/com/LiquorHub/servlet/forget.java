package com.LiquorHub.servlet;

import java.io.IOException;

import com.LiquorHub.dao.CustomerDAO;
import com.LiquorHub.daoImpl.CustomerDAOImpl;
import com.LiquorHub.dto.CustomerDTO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgetPassword")
public class forget extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/forget.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CustomerDAO customerDAO = new CustomerDAOImpl();
		CustomerDTO customer = customerDAO.getCustomerByEmail(req.getParameter("email"));
		if (customer != null) {
			if (req.getParameter("password").equals(req.getParameter("cpassword"))) {
				customer.setPassword(req.getParameter("password"));
				customerDAO.updateCustomer(customer);
				req.setAttribute("success1", "Password updated Successfully");
				RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/login.jsp");
				rd.forward(req, resp);
			} else {
				req.setAttribute("error", "Password mismatch");
				RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/forget.jsp");
				rd.forward(req, resp);
			}
		} else {
			req.setAttribute("error", "user not found");
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/forget.jsp");
			rd.forward(req, resp);
		}
	}
}

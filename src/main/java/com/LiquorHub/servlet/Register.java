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
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class Register extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		if (customer != null) {
			resp.sendRedirect(req.getContextPath() + "/profile");
			return;
		}
		req.getRequestDispatcher("/register.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO existing = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		if (existing != null) {
			resp.sendRedirect(req.getContextPath() + "/profile");
			return;
		}

		CustomerDAO customerDAO = new CustomerDAOImpl();
		CustomerDTO customer = new CustomerDTO();
		customer.setName(req.getParameter("name"));
		customer.setEmail(req.getParameter("mail"));
		customer.setPassword(req.getParameter("password"));
		customer.setPhone(req.getParameter("phone"));
		customer.setAddress(req.getParameter("address"));
		customerDAO.insertCustomer(customer);
		req.setAttribute("success", "Account created. Sign in to continue.");
		String next = req.getParameter("next");
		if (next != null && !next.isBlank()) {
			req.setAttribute("next", next);
		}
		RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
		rd.forward(req, resp);
	}
}

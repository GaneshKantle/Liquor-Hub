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

@WebServlet("/resetPassword")
public class reset extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/reset.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CustomerDAO customerDAO = new CustomerDAOImpl();
		HttpSession session = req.getSession();
		CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
		if (customer != null && customer.getPassword().equals(req.getParameter("currentPassword"))) {
			if (req.getParameter("newPassword").equals(req.getParameter("confirmPassword"))) {
				customer.setPassword(req.getParameter("confirmPassword"));
				customerDAO.updateCustomer(customer);
				session.setAttribute("Customer", customer);
				req.setAttribute("success", "updated Successfully");
				RequestDispatcher rd = req.getRequestDispatcher("/dashboard.jsp");
				rd.forward(req, resp);
			} else {
				req.setAttribute("error", "Password mismatch");
				RequestDispatcher rd = req.getRequestDispatcher("/reset.jsp");
				rd.forward(req, resp);
			}
		} else {
			req.setAttribute("error", "Enter correct current Password");
			RequestDispatcher rd = req.getRequestDispatcher("/reset.jsp");
			rd.forward(req, resp);
		}
	}
}

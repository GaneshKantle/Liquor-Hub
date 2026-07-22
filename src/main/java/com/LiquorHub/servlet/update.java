package com.LiquorHub.servlet;

import java.io.IOException;

import com.LiquorHub.dao.CustomerDAO;
import com.LiquorHub.daoImpl.CustomerDAOImpl;
import com.LiquorHub.dto.CustomerDTO;
import com.LiquorHub.utility.PhoneValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update")
public class update extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CustomerDAO customerDAO = new CustomerDAOImpl();
		HttpSession session = req.getSession();
		CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
		if (customer == null) {
			req.setAttribute("error", "session Already Expired");
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
			return;
		}

		String phone = PhoneValidator.normalize(req.getParameter("phone"));
		if (!PhoneValidator.isValid(phone)) {
			resp.sendRedirect(req.getContextPath() + "/profile?err=phone#edit");
			return;
		}

		customer.setName(req.getParameter("name"));
		customer.setEmail(req.getParameter("mail"));
		customer.setPhone(phone);
		customer.setAddress(req.getParameter("address"));
		String password = req.getParameter("password");
		if (password != null && !password.isBlank()) {
			customer.setPassword(password);
		}
		customerDAO.updateCustomer(customer);
		session.setAttribute("Customer", customer);
		resp.sendRedirect(req.getContextPath() + "/profile?updated=1#edit");
	}
}

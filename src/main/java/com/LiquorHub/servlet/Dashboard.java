package com.LiquorHub.servlet;

import java.io.IOException;

import com.LiquorHub.dto.CustomerDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class Dashboard extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session == null ? null : (CustomerDTO) session.getAttribute("Customer");
		if (customer == null) {
			req.setAttribute("error", "session Already Expired");
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
			return;
		}
		req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
	}
}

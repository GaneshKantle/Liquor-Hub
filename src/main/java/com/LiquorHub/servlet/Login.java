package com.LiquorHub.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

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

@WebServlet("/login")
public class Login extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		if (customer != null) {
			resp.sendRedirect(safeNext(req, req.getContextPath() + "/profile"));
			return;
		}
		req.getRequestDispatcher("/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CustomerDAO customerDAO = new CustomerDAOImpl();
		CustomerDTO customer = customerDAO.login(
				req.getParameter("mail"),
				req.getParameter("password"));

		if (customer != null) {
			HttpSession session = req.getSession();
			session.setAttribute("Customer", customer);
			resp.sendRedirect(safeNext(req, req.getContextPath() + "/profile"));
			return;
		}

		req.setAttribute("error", "Account Not Found");
		RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
		rd.forward(req, resp);
	}

	/** Only allow same-app relative redirects (no open redirects). */
	static String safeNext(HttpServletRequest req, String fallback) {
		String next = req.getParameter("next");
		String ctx = req.getContextPath();
		if (next == null || next.isBlank()) {
			return fallback;
		}
		if (next.startsWith("//") || next.contains("://")) {
			return fallback;
		}
		if (next.startsWith(ctx + "/") || next.equals(ctx)) {
			return next;
		}
		if (next.startsWith("/")) {
			return ctx + next;
		}
		return fallback;
	}

	static String encodeNext(String path) {
		return URLEncoder.encode(path, StandardCharsets.UTF_8);
	}
}

package com.LiquorHub.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class Contact extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = trim(req.getParameter("name"));
		String email = trim(req.getParameter("email"));
		String message = trim(req.getParameter("message"));

		if (name.isEmpty() || email.isEmpty() || message.isEmpty()) {
			req.setAttribute("contactError", "Please fill in every field.");
		} else if (!email.contains("@")) {
			req.setAttribute("contactError", "Please enter a valid email.");
		} else {
			req.setAttribute("contactSuccess", "Thanks, " + name + ". We will get back to you soon.");
		}

		Home.loadHome(req);
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect(req.getContextPath() + "/home#contact");
	}

	private static String trim(String value) {
		return value == null ? "" : value.trim();
	}
}

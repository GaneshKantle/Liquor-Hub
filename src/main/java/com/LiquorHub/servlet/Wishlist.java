package com.LiquorHub.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.LiquorHub.dao.WishlistItemDAO;
import com.LiquorHub.daoImpl.WishlistItemDAOImpl;
import com.LiquorHub.dto.CustomerDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({ "/wishlist", "/favourite", "/favorite" })
public class Wishlist extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect(req.getContextPath() + "/profile#wishlist");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		String ctx = req.getContextPath();

		if (customer == null) {
			if ("1".equals(req.getParameter("ajax"))) {
				resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				resp.setContentType("application/json;charset=UTF-8");
				resp.getWriter().write("{\"ok\":false,\"login\":true}");
				return;
			}
			resp.sendRedirect(ctx + "/login?reason=wishlist&next=" + Login.encodeNext(ctx + "/profile#wishlist"));
			return;
		}

		String action = req.getParameter("action");
		if (action == null || action.isBlank()) {
			action = "toggle";
		}

		WishlistItemDAO dao = new WishlistItemDAOImpl();
		boolean favourited = false;
		boolean ok = true;

		try {
			if ("remove".equalsIgnoreCase(action)) {
				String wid = req.getParameter("wishlistItemId");
				String pid = req.getParameter("productId");
				if (wid != null && !wid.isBlank()) {
					ok = dao.removeItem(Integer.parseInt(wid));
				} else if (pid != null && !pid.isBlank()) {
					ok = dao.removeByCustomerAndProduct(customer.getCustomerId(), Integer.parseInt(pid));
				}
				favourited = false;
			} else {
				int productId = Integer.parseInt(req.getParameter("productId"));
				favourited = dao.toggle(customer.getCustomerId(), productId);
				ok = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ok = false;
		}

		if ("1".equals(req.getParameter("ajax"))) {
			resp.setContentType("application/json;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.write("{\"ok\":" + ok + ",\"favourited\":" + favourited + "}");
			return;
		}

		String redirect = req.getParameter("redirect");
		if (redirect != null && redirect.startsWith(ctx)) {
			resp.sendRedirect(redirect);
		} else if ("remove".equalsIgnoreCase(action)) {
			resp.sendRedirect(ctx + "/profile#wishlist");
		} else {
			resp.sendRedirect(ctx + "/home#items");
		}
	}
}

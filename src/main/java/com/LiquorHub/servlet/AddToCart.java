package com.LiquorHub.servlet;

import java.io.IOException;

import com.LiquorHub.dao.CartDAO;
import com.LiquorHub.dao.CartItemDAO;
import com.LiquorHub.daoImpl.CartDAOImpl;
import com.LiquorHub.daoImpl.CartItemDAOImpl;
import com.LiquorHub.dto.CartDTO;
import com.LiquorHub.dto.CartItemDTO;
import com.LiquorHub.dto.CustomerDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-to-cart")
public class AddToCart extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		String ctx = req.getContextPath();

		if (customer == null) {
			resp.sendRedirect(ctx + "/login");
			return;
		}

		String pid = req.getParameter("productId");
		int productId;
		try {
			productId = Integer.parseInt(pid);
		} catch (Exception e) {
			resp.sendRedirect(ctx + "/home");
			return;
		}

		CartDAO cartDAO = new CartDAOImpl();
		CartItemDAO itemDAO = new CartItemDAOImpl();

		CartDTO cart = cartDAO.getCartByCustomerId(customer.getCustomerId());
		if (cart == null) {
			CartDTO fresh = new CartDTO();
			fresh.setCustomerId(customer.getCustomerId());
			cartDAO.createCart(fresh);
			cart = cartDAO.getCartByCustomerId(customer.getCustomerId());
		}

		if (cart == null) {
			resp.sendRedirect(ctx + "/home?cart=error");
			return;
		}

		CartItemDTO item = new CartItemDTO();
		item.setCartId(cart.getCartId());
		item.setProductId(productId);
		item.setQuantity(1);
		itemDAO.addItem(item);

		resp.sendRedirect(ctx + "/cart?added=1");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}

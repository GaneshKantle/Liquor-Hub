package com.LiquorHub.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dao.CartDAO;
import com.LiquorHub.dao.CartItemDAO;
import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.daoImpl.CartDAOImpl;
import com.LiquorHub.daoImpl.CartItemDAOImpl;
import com.LiquorHub.daoImpl.ProductDAOImpl;
import com.LiquorHub.dto.CartDTO;
import com.LiquorHub.dto.CartItemDTO;
import com.LiquorHub.dto.CustomerDTO;
import com.LiquorHub.dto.ProductDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class Cart extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		if (customer == null) {
			String ctx = req.getContextPath();
			resp.sendRedirect(ctx + "/login?reason=cart&next=" + Login.encodeNext(ctx + "/cart"));
			return;
		}

		loadCart(req, customer);
		try {
			com.LiquorHub.dao.CategoryDAO categoryDAO = new com.LiquorHub.daoImpl.CategoryDAOImpl();
			req.setAttribute("categories", categoryDAO.getAllCategories());
		} catch (Exception e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/cart.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		if (customer == null) {
			String ctx = req.getContextPath();
			resp.sendRedirect(ctx + "/login?reason=cart&next=" + Login.encodeNext(ctx + "/cart"));
			return;
		}

		String action = req.getParameter("action");
		String itemIdStr = req.getParameter("cartItemId");
		CartItemDAO itemDAO = new CartItemDAOImpl();

		if (itemIdStr != null) {
			try {
				int cartItemId = Integer.parseInt(itemIdStr);
				if ("remove".equals(action)) {
					itemDAO.removeItem(cartItemId);
				} else if ("qty".equals(action)) {
					int qty = Integer.parseInt(req.getParameter("quantity"));
					if (qty <= 0) {
						itemDAO.removeItem(cartItemId);
					} else {
						itemDAO.updateQuantity(cartItemId, qty);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		resp.sendRedirect(req.getContextPath() + "/cart");
	}

	static void loadCart(HttpServletRequest req, CustomerDTO customer) {
		CartDAO cartDAO = new CartDAOImpl();
		CartItemDAO itemDAO = new CartItemDAOImpl();
		ProductDAO productDAO = new ProductDAOImpl();

		CartDTO cart = cartDAO.getCartByCustomerId(customer.getCustomerId());
		List<CartItemDTO> items = new ArrayList<>();
		List<ProductDTO> products = new ArrayList<>();

		if (cart != null) {
			List<CartItemDTO> raw = itemDAO.getCartItems(cart.getCartId());
			if (raw != null) {
				items = raw;
				for (CartItemDTO it : items) {
					products.add(productDAO.getProductById(it.getProductId()));
				}
			}
		}

		req.setAttribute("cart", cart);
		req.setAttribute("cartItems", items);
		req.setAttribute("cartProducts", products);
	}
}

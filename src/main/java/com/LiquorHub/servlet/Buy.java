package com.LiquorHub.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dao.CartDAO;
import com.LiquorHub.dao.CartItemDAO;
import com.LiquorHub.dao.OrderDAO;
import com.LiquorHub.dao.OrderItemDAO;
import com.LiquorHub.dao.PaymentDAO;
import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.daoImpl.CartDAOImpl;
import com.LiquorHub.daoImpl.CartItemDAOImpl;
import com.LiquorHub.daoImpl.OrderDAOImpl;
import com.LiquorHub.daoImpl.OrderItemDAOImpl;
import com.LiquorHub.daoImpl.PaymentDAOImpl;
import com.LiquorHub.daoImpl.ProductDAOImpl;
import com.LiquorHub.dto.CartDTO;
import com.LiquorHub.dto.CartItemDTO;
import com.LiquorHub.dto.CustomerDTO;
import com.LiquorHub.dto.OrderDTO;
import com.LiquorHub.dto.OrderItemDTO;
import com.LiquorHub.dto.PaymentDTO;
import com.LiquorHub.dto.ProductDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({ "/buy", "/buy-now" })
public class Buy extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		String ctx = req.getContextPath();
		String pid = req.getParameter("productId");
		if (customer == null) {
			String q = pid != null && !pid.isBlank()
					? "/buy-now?productId=" + pid
					: "/buy";
			resp.sendRedirect(ctx + "/login?reason=buy&next=" + Login.encodeNext(ctx + q));
			return;
		}

		if (pid != null && !pid.isBlank()) {
			try {
				ensureInCart(customer.getCustomerId(), Integer.parseInt(pid));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		loadCheckout(req, customer);
		List<?> items = (List<?>) req.getAttribute("cartItems");
		if (items == null || items.isEmpty()) {
			resp.sendRedirect(ctx + "/cart");
			return;
		}
		req.getRequestDispatcher("/buy.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		String ctx = req.getContextPath();
		if (customer == null) {
			resp.sendRedirect(ctx + "/login?reason=buy&next=" + Login.encodeNext(ctx + "/buy"));
			return;
		}

		CartDAO cartDAO = new CartDAOImpl();
		CartItemDAO itemDAO = new CartItemDAOImpl();
		ProductDAO productDAO = new ProductDAOImpl();
		OrderDAO orderDAO = new OrderDAOImpl();
		OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
		PaymentDAO paymentDAO = new PaymentDAOImpl();

		CartDTO cart = cartDAO.getCartByCustomerId(customer.getCustomerId());
		if (cart == null) {
			resp.sendRedirect(ctx + "/cart");
			return;
		}

		List<CartItemDTO> items = itemDAO.getCartItems(cart.getCartId());
		if (items == null || items.isEmpty()) {
			resp.sendRedirect(ctx + "/cart");
			return;
		}

		double total = 0;
		List<ProductDTO> products = new ArrayList<>();
		for (CartItemDTO it : items) {
			ProductDTO p = productDAO.getProductById(it.getProductId());
			products.add(p);
			if (p != null) {
				total += p.getPrice() * Math.max(1, it.getQuantity());
			}
		}

		String method = req.getParameter("paymentMethod");
		if (method == null || method.isBlank()) {
			method = "UPI";
		}

		OrderDTO order = new OrderDTO();
		order.setCustomerId(customer.getCustomerId());
		order.setOrderDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		order.setTotalAmount(total);
		order.setStatus("Placed");

		boolean ok = orderDAO.placeOrder(order);
		if (!ok || order.getOrderId() <= 0) {
			req.setAttribute("buyError", "Could not place order. Please try again.");
			loadCheckout(req, customer);
			req.getRequestDispatcher("/buy.jsp").forward(req, resp);
			return;
		}

		for (int i = 0; i < items.size(); i++) {
			CartItemDTO it = items.get(i);
			OrderItemDTO oi = new OrderItemDTO();
			oi.setOrderId(order.getOrderId());
			oi.setProductId(it.getProductId());
			oi.setQuantity(Math.max(1, it.getQuantity()));
			orderItemDAO.addOrderItem(oi);
		}

		PaymentDTO payment = new PaymentDTO();
		payment.setOrderId(order.getOrderId());
		payment.setPaymentMethod(method);
		payment.setPaymentStatus("Paid");
		paymentDAO.makePayment(payment);

		for (CartItemDTO it : items) {
			itemDAO.removeItem(it.getCartItemId());
		}

		resp.sendRedirect(ctx + "/profile?ordered=" + order.getOrderId());
	}

	private static void ensureInCart(int customerId, int productId) {
		CartDAO cartDAO = new CartDAOImpl();
		CartItemDAO itemDAO = new CartItemDAOImpl();
		CartDTO cart = cartDAO.getCartByCustomerId(customerId);
		if (cart == null) {
			CartDTO fresh = new CartDTO();
			fresh.setCustomerId(customerId);
			cartDAO.createCart(fresh);
			cart = cartDAO.getCartByCustomerId(customerId);
		}
		if (cart == null) {
			return;
		}
		List<CartItemDTO> items = itemDAO.getCartItems(cart.getCartId());
		if (items != null) {
			for (CartItemDTO it : items) {
				if (it.getProductId() == productId) {
					return;
				}
			}
		}
		CartItemDTO item = new CartItemDTO();
		item.setCartId(cart.getCartId());
		item.setProductId(productId);
		item.setQuantity(1);
		itemDAO.addItem(item);
	}

	private static void loadCheckout(HttpServletRequest req, CustomerDTO customer) {
		CartDAO cartDAO = new CartDAOImpl();
		CartItemDAO itemDAO = new CartItemDAOImpl();
		ProductDAO productDAO = new ProductDAOImpl();

		CartDTO cart = cartDAO.getCartByCustomerId(customer.getCustomerId());
		List<CartItemDTO> items = new ArrayList<>();
		List<ProductDTO> products = new ArrayList<>();
		double total = 0;

		if (cart != null) {
			List<CartItemDTO> raw = itemDAO.getCartItems(cart.getCartId());
			if (raw != null) {
				items = raw;
				for (CartItemDTO it : items) {
					ProductDTO p = productDAO.getProductById(it.getProductId());
					products.add(p);
					if (p != null) {
						total += p.getPrice() * Math.max(1, it.getQuantity());
					}
				}
			}
		}

		req.setAttribute("cart", cart);
		req.setAttribute("cartItems", items);
		req.setAttribute("cartProducts", products);
		req.setAttribute("cartTotal", total);
		req.setAttribute("customer", customer);
	}
}

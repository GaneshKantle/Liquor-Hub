package com.LiquorHub.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dao.OrderDAO;
import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.dao.WishlistItemDAO;
import com.LiquorHub.daoImpl.OrderDAOImpl;
import com.LiquorHub.daoImpl.ProductDAOImpl;
import com.LiquorHub.daoImpl.WishlistItemDAOImpl;
import com.LiquorHub.dto.CustomerDTO;
import com.LiquorHub.dto.OrderDTO;
import com.LiquorHub.dto.ProductDTO;
import com.LiquorHub.dto.WishlistItemDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({ "/dashboard", "/profile" })
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

		try {
			OrderDAO orderDAO = new OrderDAOImpl();
			List<OrderDTO> orders = orderDAO.getOrdersByCustomer(customer.getCustomerId());
			req.setAttribute("orders", orders);
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			com.LiquorHub.dao.CategoryDAO categoryDAO = new com.LiquorHub.daoImpl.CategoryDAOImpl();
			req.setAttribute("categories", categoryDAO.getAllCategories());
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			WishlistItemDAO wishDAO = new WishlistItemDAOImpl();
			ProductDAO productDAO = new ProductDAOImpl();
			List<WishlistItemDTO> wishItems = wishDAO.getItemsByCustomer(customer.getCustomerId());
			List<ProductDTO> wishProducts = new ArrayList<>();
			if (wishItems != null) {
				for (WishlistItemDTO w : wishItems) {
					ProductDTO p = productDAO.getProductById(w.getProductId());
					wishProducts.add(p);
				}
			}
			req.setAttribute("wishlistItems", wishItems);
			req.setAttribute("wishlistProducts", wishProducts);
		} catch (Exception e) {
			e.printStackTrace();
		}

		req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
	}
}

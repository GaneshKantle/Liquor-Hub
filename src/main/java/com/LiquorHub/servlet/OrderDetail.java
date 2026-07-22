package com.LiquorHub.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.LiquorHub.dao.OrderDAO;
import com.LiquorHub.dao.OrderItemDAO;
import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.daoImpl.OrderDAOImpl;
import com.LiquorHub.daoImpl.OrderItemDAOImpl;
import com.LiquorHub.daoImpl.ProductDAOImpl;
import com.LiquorHub.dto.CustomerDTO;
import com.LiquorHub.dto.OrderDTO;
import com.LiquorHub.dto.OrderItemDTO;
import com.LiquorHub.dto.ProductDTO;
import com.LiquorHub.utility.ImageUrls;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({ "/order-detail", "/order" })
public class OrderDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter out = resp.getWriter();

		if (customer == null) {
			resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			out.write("{\"ok\":false,\"error\":\"login\"}");
			return;
		}

		int orderId;
		try {
			orderId = Integer.parseInt(req.getParameter("orderId"));
		} catch (Exception e) {
			resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.write("{\"ok\":false,\"error\":\"bad_id\"}");
			return;
		}

		OrderDAO orderDAO = new OrderDAOImpl();
		OrderDTO order = orderDAO.getOrderById(orderId);
		if (order == null || order.getCustomerId() != customer.getCustomerId()) {
			resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
			out.write("{\"ok\":false,\"error\":\"not_found\"}");
			return;
		}

		OrderItemDAO itemDAO = new OrderItemDAOImpl();
		ProductDAO productDAO = new ProductDAOImpl();
		List<OrderItemDTO> items = itemDAO.getOrderItems(orderId);

		StringBuilder json = new StringBuilder();
		json.append("{\"ok\":true");
		json.append(",\"orderId\":").append(order.getOrderId());
		json.append(",\"orderDate\":\"").append(esc(order.getOrderDate())).append("\"");
		json.append(",\"status\":\"").append(esc(order.getStatus())).append("\"");
		json.append(",\"total\":").append(order.getTotalAmount());
		json.append(",\"items\":[");

		if (items != null) {
			boolean first = true;
			for (OrderItemDTO it : items) {
				if (it == null) continue;
				ProductDTO p = productDAO.getProductById(it.getProductId());
				String name = p != null && p.getProductName() != null ? p.getProductName() : "Bottle";
				String brand = p != null && p.getBrand() != null ? p.getBrand() : "LiquorHub";
				double price = p != null ? p.getPrice() : 0;
				int qty = Math.max(1, it.getQuantity());
				int catId = p != null ? p.getCategoryId() : 0;
				String img = ImageUrls.forProduct(name, brand, catId);

				if (!first) json.append(",");
				first = false;
				json.append("{");
				json.append("\"productId\":").append(it.getProductId());
				json.append(",\"name\":\"").append(esc(name)).append("\"");
				json.append(",\"brand\":\"").append(esc(brand)).append("\"");
				json.append(",\"qty\":").append(qty);
				json.append(",\"price\":").append(price);
				json.append(",\"lineTotal\":").append(price * qty);
				json.append(",\"image\":\"").append(esc(img)).append("\"");
				json.append("}");
			}
		}

		json.append("]}");
		out.write(json.toString());
	}

	private static String esc(String value) {
		if (value == null) return "";
		return value
				.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\r", " ")
				.replace("\n", " ");
	}
}

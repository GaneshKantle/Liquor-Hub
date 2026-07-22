package com.LiquorHub.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.LiquorHub.dao.CategoryDAO;
import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.dao.WishlistItemDAO;
import com.LiquorHub.daoImpl.CategoryDAOImpl;
import com.LiquorHub.daoImpl.ProductDAOImpl;
import com.LiquorHub.daoImpl.WishlistItemDAOImpl;
import com.LiquorHub.dto.CategoryDTO;
import com.LiquorHub.dto.CustomerDTO;
import com.LiquorHub.dto.ProductDTO;

import com.LiquorHub.utility.CatalogSeeder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/home")
public class Home extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		loadHome(req);
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	static void loadHome(HttpServletRequest req) {
		List<CategoryDTO> categories = new ArrayList<>();
		List<ProductDTO> products = new ArrayList<>();

		try {
			CategoryDAO categoryDAO = new CategoryDAOImpl();
			ProductDAO productDAO = new ProductDAOImpl();
			CatalogSeeder.ensureExtraProducts(productDAO);
			List<CategoryDTO> cats = categoryDAO.getAllCategories();
			List<ProductDTO> prods = productDAO.getAllProducts();
			if (cats != null) {
				categories = cats;
			}
			if (prods != null) {
				products = prods;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<ProductDTO> whiskyEssentials = new ArrayList<>();
		List<ProductDTO> housePour = new ArrayList<>();
		List<ProductDTO> premiumPicks = new ArrayList<>();

		for (ProductDTO p : products) {
			if (p.getCategoryId() == 1 && whiskyEssentials.size() < 4) {
				whiskyEssentials.add(p);
			}
			if (p.getPrice() < 1500 && housePour.size() < 4) {
				housePour.add(p);
			}
			if (p.getPrice() >= 4000 && premiumPicks.size() < 4) {
				premiumPicks.add(p);
			}
		}

		// Fallback so collection panels never render as empty voids
		if (whiskyEssentials.isEmpty()) {
			whiskyEssentials = take(products, 4);
		}
		if (housePour.isEmpty()) {
			housePour = take(products, 4);
		}
		if (premiumPicks.isEmpty()) {
			premiumPicks = takeFromEnd(products, 4);
		}

		Set<Integer> wishlistIds = new HashSet<>();
		HttpSession session = req.getSession(false);
		CustomerDTO customer = session != null ? (CustomerDTO) session.getAttribute("Customer") : null;
		if (customer != null) {
			try {
				WishlistItemDAO wishDAO = new WishlistItemDAOImpl();
				wishlistIds = wishDAO.getProductIdsByCustomer(customer.getCustomerId());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		req.setAttribute("categories", categories);
		req.setAttribute("products", products);
		req.setAttribute("whiskyEssentials", whiskyEssentials);
		req.setAttribute("housePour", housePour);
		req.setAttribute("premiumPicks", premiumPicks);
		req.setAttribute("wishlistIds", wishlistIds);
	}

	private static List<ProductDTO> take(List<ProductDTO> src, int n) {
		List<ProductDTO> out = new ArrayList<>();
		if (src == null) {
			return out;
		}
		for (int i = 0; i < src.size() && out.size() < n; i++) {
			out.add(src.get(i));
		}
		return out;
	}

	private static List<ProductDTO> takeFromEnd(List<ProductDTO> src, int n) {
		List<ProductDTO> out = new ArrayList<>();
		if (src == null || src.isEmpty()) {
			return out;
		}
		int start = Math.max(0, src.size() - n);
		for (int i = start; i < src.size(); i++) {
			out.add(src.get(i));
		}
		return out;
	}
}

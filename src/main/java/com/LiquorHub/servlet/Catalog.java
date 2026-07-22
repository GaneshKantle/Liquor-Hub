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

@WebServlet({ "/catalog", "/shop", "/all-products" })
public class Catalog extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

		String catParam = req.getParameter("cat");
		Integer filterCat = null;
		if (catParam != null && !catParam.isBlank()) {
			try {
				filterCat = Integer.parseInt(catParam);
			} catch (NumberFormatException ignored) {
			}
		}

		List<ProductDTO> visible = products;
		if (filterCat != null) {
			visible = new ArrayList<>();
			for (ProductDTO p : products) {
				if (p.getCategoryId() == filterCat.intValue()) {
					visible.add(p);
				}
			}
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
		req.setAttribute("products", visible);
		req.setAttribute("productTotal", products.size());
		req.setAttribute("filterCat", filterCat);
		req.setAttribute("wishlistIds", wishlistIds);
		req.getRequestDispatcher("/catalog.jsp").forward(req, resp);
	}
}

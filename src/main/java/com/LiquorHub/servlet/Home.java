package com.LiquorHub.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.LiquorHub.dao.CategoryDAO;
import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.daoImpl.CategoryDAOImpl;
import com.LiquorHub.daoImpl.ProductDAOImpl;
import com.LiquorHub.dto.CategoryDTO;
import com.LiquorHub.dto.ProductDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

		req.setAttribute("categories", categories);
		req.setAttribute("products", products);
		req.setAttribute("whiskyEssentials", whiskyEssentials);
		req.setAttribute("housePour", housePour);
		req.setAttribute("premiumPicks", premiumPicks);
	}
}

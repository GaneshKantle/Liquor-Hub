package com.LiquorHub.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.LiquorHub.dao.WishlistItemDAO;
import com.LiquorHub.dto.WishlistItemDTO;
import com.LiquorHub.utility.Connector;

public class WishlistItemDAOImpl implements WishlistItemDAO {

	private Connection con;

	public WishlistItemDAOImpl() {
		con = Connector.requestConnection();
		ensureTable();
	}

	private void ensureTable() {
		if (con == null) {
			return;
		}
		String sql = "CREATE TABLE IF NOT EXISTS WishlistItem ("
				+ "wishlist_item_id INT AUTO_INCREMENT PRIMARY KEY,"
				+ "customer_id INT NOT NULL,"
				+ "product_id INT NOT NULL,"
				+ "UNIQUE KEY uk_wishlist_customer_product (customer_id, product_id),"
				+ "FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),"
				+ "FOREIGN KEY (product_id) REFERENCES Product(product_id)"
				+ ")";
		try (Statement st = con.createStatement()) {
			st.execute(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean addItem(WishlistItemDTO item) {
		String sql = "INSERT INTO WishlistItem(customer_id, product_id) VALUES(?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, item.getCustomerId());
			ps.setInt(2, item.getProductId());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean removeItem(int wishlistItemId) {
		String sql = "DELETE FROM WishlistItem WHERE wishlist_item_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, wishlistItemId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean removeByCustomerAndProduct(int customerId, int productId) {
		String sql = "DELETE FROM WishlistItem WHERE customer_id=? AND product_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, customerId);
			ps.setInt(2, productId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean isInWishlist(int customerId, int productId) {
		String sql = "SELECT 1 FROM WishlistItem WHERE customer_id=? AND product_id=? LIMIT 1";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, customerId);
			ps.setInt(2, productId);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<WishlistItemDTO> getItemsByCustomer(int customerId) {
		List<WishlistItemDTO> items = new ArrayList<>();
		String sql = "SELECT * FROM WishlistItem WHERE customer_id=? ORDER BY wishlist_item_id DESC";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, customerId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				WishlistItemDTO item = new WishlistItemDTO();
				item.setWishlistItemId(rs.getInt("wishlist_item_id"));
				item.setCustomerId(rs.getInt("customer_id"));
				item.setProductId(rs.getInt("product_id"));
				items.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return items;
	}

	@Override
	public Set<Integer> getProductIdsByCustomer(int customerId) {
		Set<Integer> ids = new HashSet<>();
		String sql = "SELECT product_id FROM WishlistItem WHERE customer_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, customerId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ids.add(rs.getInt("product_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ids;
	}

	@Override
	public boolean toggle(int customerId, int productId) {
		if (isInWishlist(customerId, productId)) {
			removeByCustomerAndProduct(customerId, productId);
			return false;
		}
		WishlistItemDTO item = new WishlistItemDTO();
		item.setCustomerId(customerId);
		item.setProductId(productId);
		addItem(item);
		return true;
	}
}

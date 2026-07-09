package com.liqourhub.dao;

import java.util.List;
import com.liqourhub.dto.Product;

public interface ProductDAO {

	boolean addProduct(Product product);

	boolean updateProduct(Product product);

	boolean deleteProduct(int productId);

	Product getProductById(int productId);

	List<Product> getAllProducts();

	List<Product> getProductsByCategory(int categoryId);

}
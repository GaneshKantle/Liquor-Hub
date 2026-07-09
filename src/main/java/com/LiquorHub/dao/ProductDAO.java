package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.ProductDTO;

public interface ProductDAO {

	boolean addProduct(ProductDTO product);
 
	boolean updateProduct(ProductDTO product);

	boolean deleteProduct(int productId);

	ProductDTO getProductById(int productId);

	List<ProductDTO> getAllProducts();

	List<ProductDTO> getProductsByCategory(int categoryId);

}
package com.LiquorHub.dao;

import java.util.List;

import com.LiquorHub.dto.CategoryDTO;

public interface CategoryDAO {

	boolean addCategory(CategoryDTO category);

	boolean updateCategory(CategoryDTO category);

	boolean deleteCategory(int categoryId);

	CategoryDTO getCategoryById(int categoryId);

	List<CategoryDTO> getAllCategories(); 

}
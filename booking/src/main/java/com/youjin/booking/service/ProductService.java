package com.youjin.booking.service;

import java.util.List;

import com.youjin.booking.dto.ProductDisplayFile;

public interface ProductService {

	public static final Integer LIMIT = 4;
	
	public int getCount();
	public int getCountByCategory(int categoryId);
	public List<ProductDisplayFile> getProducts(Integer start);
	public List<ProductDisplayFile> getProductsByCategory(int categoryId, Integer start);
	public List<ProductDisplayFile> getProductById(Integer id);
}

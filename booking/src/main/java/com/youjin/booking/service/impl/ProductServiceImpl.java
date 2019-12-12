package com.youjin.booking.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.youjin.booking.dao.ProductDao;
import com.youjin.booking.dto.ProductDisplayFile;
import com.youjin.booking.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDao productDao;

	@Override
	@Transactional // 꼭 붙여야 하는 경우는 어떤 경우 ?
	public int getCount() {
		return productDao.selectCount();
	}

	@Override
	@Transactional
	public List<ProductDisplayFile> getProducts(Integer start) {
		List<ProductDisplayFile> list = productDao.selectAll(start, ProductService.LIMIT);
		return list;
	}

	@Override
	public List<ProductDisplayFile> getProductsByCategory(String categoryName, Integer start) {
		List<ProductDisplayFile> list = productDao.selectByCategory(categoryName, start, ProductService.LIMIT);
		return list;
	}
	
	
	
	
	
}

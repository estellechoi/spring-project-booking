package com.youjin.booking.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.youjin.booking.dao.CategoryDao;
import com.youjin.booking.dto.Category;
import com.youjin.booking.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	CategoryDao categoryDao;
	
	@Override
	@Transactional
	public List<Category> getCategories() {
		List<Category> list = categoryDao.selectAll();
		return list;
	}

	
}

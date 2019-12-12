package com.youjin.booking.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youjin.booking.dao.PromotionDao;
import com.youjin.booking.dto.Promotion;
import com.youjin.booking.service.PromotionService;
@Service
public class PromotionServiceImpl implements PromotionService {

	@Autowired
	PromotionDao promotionDao;
	
	@Override
	public List<Promotion> getPromotions() {
		promotionDao.selectAll();
		return promotionDao.selectAll();
	}

	
}

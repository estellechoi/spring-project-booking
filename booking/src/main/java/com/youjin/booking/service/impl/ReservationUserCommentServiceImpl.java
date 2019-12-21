package com.youjin.booking.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youjin.booking.dao.ReservationUserCommentDao;
import com.youjin.booking.dto.ReservationUserComment;
import com.youjin.booking.service.ReservationUserCommentService;
@Service
public class ReservationUserCommentServiceImpl implements ReservationUserCommentService{

	@Autowired
	ReservationUserCommentDao reservationUserCommentDao;
	
	@Override
	public int getCount(Integer id, Integer displayInfoId) {
		int count =reservationUserCommentDao.selectCount(id, displayInfoId);
		return count;
	}

	@Override
	public BigDecimal getAvg(Integer id, Integer displayInfoId) {
		BigDecimal avg =reservationUserCommentDao.selectAvg(id, displayInfoId);
		return avg;
	}

	@Override
	public List<ReservationUserComment> getComment(Integer id, Integer displayInfoId) {
		List<ReservationUserComment> list = reservationUserCommentDao.selectById(id, displayInfoId);
		return list;
	}
	
	

	
	
}

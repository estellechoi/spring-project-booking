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
	public int getCount(Integer id) {
		int count =reservationUserCommentDao.selectCount(id);
		return count;
	}

	@Override
	public BigDecimal getAvg(Integer id) {
		BigDecimal avg =reservationUserCommentDao.selectAvg(id);
		return avg;
	}

	@Override
	public List<ReservationUserComment> getComment(Integer id) {
		List<ReservationUserComment> list = reservationUserCommentDao.selectById(id);
		return list;
	}
	
	

	
	
}

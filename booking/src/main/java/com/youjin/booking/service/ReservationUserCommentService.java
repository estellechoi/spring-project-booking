package com.youjin.booking.service;

import java.math.BigDecimal;
import java.util.List;

import com.youjin.booking.dto.ReservationUserComment;

public interface ReservationUserCommentService {

	public int getCount(Integer id, Integer displayInfoId);
	public BigDecimal getAvg(Integer id, Integer displayInfoId);
	public List<ReservationUserComment> getComment(Integer id, Integer displayInfoId);
}

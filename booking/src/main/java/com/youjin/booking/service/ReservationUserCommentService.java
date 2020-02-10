package com.youjin.booking.service;

import java.math.BigDecimal;
import java.util.List;

import com.youjin.booking.dto.FileInfo;
import com.youjin.booking.dto.ReservationInfoPrice;
import com.youjin.booking.dto.ReservationUserComment;

public interface ReservationUserCommentService {

	public int getCount(Integer id, Integer displayInfoId);
	public BigDecimal getAvg(Integer id, Integer displayInfoId);
	public List<ReservationUserComment> getComment(Integer id, Integer displayInfoId);
	public List<ReservationUserComment> getReservationInfo(String reservationEmail);
	public List<ReservationInfoPrice> getReservationPrice(Integer reservationInfoId);
	public int setReservationInfo(ReservationUserComment reservationUserComment);
	public int setReservationPrice(ReservationInfoPrice reservationInfoPrice);
	public int updateCancelFlag(Integer reservationInfoId);
	public int setComment(ReservationUserComment reservationUserComment, FileInfo fileInfo);
}

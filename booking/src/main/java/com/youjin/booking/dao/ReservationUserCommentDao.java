package com.youjin.booking.dao;

import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_AVG;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_COUNT;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_BY_ID;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.youjin.booking.dto.ReservationUserComment;
@Repository
public class ReservationUserCommentDao {

	private NamedParameterJdbcTemplate template;
	private RowMapper<ReservationUserComment> rowMapper = BeanPropertyRowMapper.newInstance(ReservationUserComment.class);

	public ReservationUserCommentDao(DataSource dataSource) {
		this.template = new NamedParameterJdbcTemplate(dataSource);
	}
	
	// 전체 한줄평 수
	public int selectCount(Integer id) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		int count = template.queryForObject(SELECT_COUNT, paramMap, Integer.class);
		return count;
	}
	
	// 전체 점수 평균 
	public BigDecimal selectAvg(Integer id) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		BigDecimal avg = template.queryForObject(SELECT_AVG, paramMap, BigDecimal.class);
		// setScale(소수점 자릿수, 반올림 설정(RoundingMode.HALF_EVEN));
		// javaScript 로 처리 ...
		return avg;		
	}
		
	// 상품별 한줄평
	public List<ReservationUserComment> selectById(Integer id) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		
		return template.query(SELECT_BY_ID, paramMap, rowMapper);
	}
}

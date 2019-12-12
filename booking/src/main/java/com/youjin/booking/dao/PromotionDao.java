package com.youjin.booking.dao;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.youjin.booking.dto.Promotion;
import static com.youjin.booking.dao.PromotionDaoSqls.*;

@Repository
public class PromotionDao {

	private NamedParameterJdbcTemplate template;
	private RowMapper<Promotion> rowMapper = BeanPropertyRowMapper.newInstance(Promotion.class);
	
	public PromotionDao(DataSource dataSource) {
		this.template = new NamedParameterJdbcTemplate(dataSource);
	}
	
	// 모든 프로모션 상품 불러오기 
	public List<Promotion> selectAll() {
		Map<String, ?> paramMap = Collections.emptyMap();
		return template.query(SELECT_ALL, paramMap, rowMapper);
	}
	
}

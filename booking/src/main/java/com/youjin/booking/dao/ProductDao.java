package com.youjin.booking.dao;

import static com.youjin.booking.dao.ProductDaoSqls.SELECT_ALL_LIMIT;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_BY_CATEGORY;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_COUNT;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_COUNT_BY_CATEGORY;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.youjin.booking.dto.ProductDisplayFile;

@Repository
public class ProductDao {

	private NamedParameterJdbcTemplate template;
	private RowMapper<ProductDisplayFile> rowMapper = BeanPropertyRowMapper.newInstance(ProductDisplayFile.class);
	
	public ProductDao(DataSource dataSource) {
		this.template = new NamedParameterJdbcTemplate(dataSource);
		
	}
	
	// 전체 상품수
	public int selectCount() {
		Map<String, ?> paramMap = Collections.emptyMap();
		return template.queryForObject(SELECT_COUNT, paramMap, Integer.class);
	}
	
	public int selectCountByCategory(String categoryName) {
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("categoryName", categoryName);
		return template.queryForObject(SELECT_COUNT_BY_CATEGORY, paramMap, Integer.class);
	}
	
	// 모든 상품 불러오기 (limit 개수씩 불러오기)
	public List<ProductDisplayFile> selectAll(Integer start, Integer limit) {
		
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("start", start);
		paramMap.put("limit", limit);
		
		// 다중 테이블 조회결과를 ProductDisplayFile 객체 타입의 Map 으로 반환한다.
		return template.query(SELECT_ALL_LIMIT, paramMap, rowMapper);
	}
	
	// 카테고리별 상품 불러오기
	public List<ProductDisplayFile> selectByCategory(String categoryName, Integer start, Integer limit) {

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("categoryName", categoryName);
		paramMap.put("start", start);
		paramMap.put("limit", limit);
		
		return template.query(SELECT_BY_CATEGORY, paramMap, rowMapper);
		

	}
}

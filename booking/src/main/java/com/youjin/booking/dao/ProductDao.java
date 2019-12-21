package com.youjin.booking.dao;

import static com.youjin.booking.dao.ProductDaoSqls.SELECT_ALL_LIMIT;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_BY_CATEGORY;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_COUNT;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_COUNT_BY_CATEGORY;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_BY_ID;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_IMAGE_BY_ID;
import static com.youjin.booking.dao.ProductDaoSqls.SELECT_DISPLAY_BY_ID;

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
	
	// 카테고리별 상품수
	public int selectCountByCategory(int categoryId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("categoryId", categoryId);
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
	public List<ProductDisplayFile> selectByCategory(int categoryId, Integer start, Integer limit) {

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("categoryId", categoryId);
		paramMap.put("start", start);
		paramMap.put("limit", limit);
		
		return template.query(SELECT_BY_CATEGORY, paramMap, rowMapper);
	}
	
	// 상품별 상세정보 가져오기
	public	ProductDisplayFile selectById(Integer id) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		
		return template.queryForObject(SELECT_BY_ID, paramMap, rowMapper);
	}
	
	// 상품별 이미지 가져오기
	public List<ProductDisplayFile> selectImageById(Integer id) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		
		return template.query(SELECT_IMAGE_BY_ID, paramMap, rowMapper);		
	}
	
	// 상품별 전시정보 가져오기 
	// SELECT_DISPLAY_BY_ID
	// 1개의 상품에 대해 전시정보가 여러개일 수 있다 ..!
	// queryForObject 는 결과값이 1개여야한다 !
	public ProductDisplayFile selectDisplayById(Integer id, Integer displayInfoId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("displayInfoId", displayInfoId);
		
		return template.queryForObject(SELECT_DISPLAY_BY_ID, paramMap, rowMapper);	
	}
	
}

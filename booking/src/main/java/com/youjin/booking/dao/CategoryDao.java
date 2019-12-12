package com.youjin.booking.dao;

import static com.youjin.booking.dao.CategoryDaoSqls.SELECT_ALL;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.youjin.booking.dto.Category;

@Repository
public class CategoryDao {

	private NamedParameterJdbcTemplate template;
	// RowMapper : 데이터베이스 레코드 값을 지정한 클래스의 변수명에 맞추어 Map 타입으로 반환
	private RowMapper<Category> rowMapper = BeanPropertyRowMapper.newInstance(Category.class);
	
	public CategoryDao(DataSource dataSource) {
		this.template = new NamedParameterJdbcTemplate(dataSource);
	}
	
	// select all
	public List<Category> selectAll() {
		Map<String, ?> paramMap = Collections.emptyMap();
		
		return template.query(SELECT_ALL, paramMap, rowMapper);
	}
}

package com.youjin.booking.dao;

import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_AVG;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_BY_ID;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_COUNT;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_RESERVATION_INFO;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.SELECT_RESERVATION_PRICE;
import static com.youjin.booking.dao.ReservationUserCommentDaoSqls.UPDATE_CANCEL_FLAG;
//UPDATE_CANCEL_FLAG

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.youjin.booking.dto.FileInfo;
import com.youjin.booking.dto.ReservationInfoPrice;
import com.youjin.booking.dto.ReservationUserComment;
@Repository
public class ReservationUserCommentDao {

	private NamedParameterJdbcTemplate template;
	private RowMapper<ReservationUserComment> rowMapper = BeanPropertyRowMapper.newInstance(ReservationUserComment.class);
	private RowMapper<ReservationInfoPrice> rowMapperPrice = BeanPropertyRowMapper.newInstance(ReservationInfoPrice.class);
	private SimpleJdbcInsert insert;
	private SimpleJdbcInsert insertPrice;
	private SimpleJdbcInsert insertComment;
	private SimpleJdbcInsert insertCommentImage;
	private SimpleJdbcInsert insertFile;
	
	public ReservationUserCommentDao(DataSource dataSource) {
		this.template = new NamedParameterJdbcTemplate(dataSource);
		this.insert = new SimpleJdbcInsert(dataSource).withTableName("reservation_info").usingGeneratedKeyColumns("id");
		this.insertPrice = new SimpleJdbcInsert(dataSource).withTableName("reservation_info_price").usingGeneratedKeyColumns("id");
		this.insertComment = new SimpleJdbcInsert(dataSource).withTableName("reservation_user_comment").usingGeneratedKeyColumns("id");
		this.insertFile = new SimpleJdbcInsert(dataSource).withTableName("file_info").usingGeneratedKeyColumns("id");
		this.insertCommentImage = new SimpleJdbcInsert(dataSource).withTableName("reservation_user_comment_image").usingGeneratedKeyColumns("id");
	}
	
	// 예약 데이터 추가
	public int insertReservationInfo(ReservationUserComment reservationUserComment) {
		// ReservationUserComment 객체의 createDate, modifyDate 변수(아직 Null)에 값 할당하기
		// 1) Calendar 객체를 이용하여 현재시간 가져오기
		Calendar today = Calendar.getInstance();
		// 2) SimpleDateFormat 객체의 format 메소드를 이용하여 형식 변환하기 (String 값 반환)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = sdf.format(today.getTime());
		// 3) String 값에서 Timestamp 값 얻기 
		Timestamp createDate = Timestamp.valueOf(now);
		// 4) setter 를 이용하여 객체에 값 주입하기
		reservationUserComment.setCreateDate(createDate);
		reservationUserComment.setModifyDate(createDate);
		
		//ReservationUserComment 객체의 변수명을 DB 테이블 필드에 맞추어 매핑
		SqlParameterSource paramMap = new BeanPropertySqlParameterSource(reservationUserComment);
		// insert 실행 및 새로 생성된 id 반환 
		int id = insert.executeAndReturnKey(paramMap).intValue();
		return id;
	}
	
	// 예약 티켓수, 가격 데이터 추가
	public int insertReservationPrice(ReservationInfoPrice reservationInfoPrice) {
		SqlParameterSource paramMap = new BeanPropertySqlParameterSource(reservationInfoPrice);
		int id = insertPrice.executeAndReturnKey(paramMap).intValue();
		return id;
	}
	
	// 전체 한줄평 수
	public int selectCount(Integer id, Integer displayInfoId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("displayInfoId", displayInfoId);
		int count = template.queryForObject(SELECT_COUNT, paramMap, Integer.class);
		return count;
	}
	
	// 전체 점수 평균 
	public BigDecimal selectAvg(Integer id, Integer displayInfoId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("displayInfoId", displayInfoId);
		BigDecimal avg = template.queryForObject(SELECT_AVG, paramMap, BigDecimal.class);
		// setScale(소수점 자릿수, 반올림 설정(RoundingMode.HALF_EVEN));
		// javaScript 로 처리 ...
		return avg;		
	}
		
	// 상품별 한줄평
	public List<ReservationUserComment> selectById(Integer id, Integer displayInfoId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("displayInfoId", displayInfoId);	
		return template.query(SELECT_BY_ID, paramMap, rowMapper);
	}
	
	// 이메일로 예약정보 가져오기 
	public List<ReservationUserComment> selectReservationInfo(String reservationEmail) {
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("reservationEmail", reservationEmail);
		List<ReservationUserComment> list = template.query(SELECT_RESERVATION_INFO, paramMap, rowMapper);
		return list;
	}
	// 예약정보에 해당하는 가격/수량 가져오기 
	public List<ReservationInfoPrice> selectReservationPrice(Integer reservationInfoId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("reservationInfoId", reservationInfoId);
		List<ReservationInfoPrice> list = template.query(SELECT_RESERVATION_PRICE, paramMap, rowMapperPrice);
		return list;
	}
	
	// 예약 취소하기 
	public int updateCancelFlag(Integer reservationInfoId) {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("reservationInfoId", reservationInfoId);
		int cancel = template.update(UPDATE_CANCEL_FLAG, paramMap);
		// 쿼리 실행 결과로 변경된 행의 개수를 반환
		return cancel;
	}
	
	public int insertComment(ReservationUserComment reservationUserComment, FileInfo fileInfo) {		
		// ReservationUserComment 객체의 createDate, modifyDate 변수(아직 Null)에 값 할당하기
		// 1) Calendar 객체를 이용하여 현재시간 가져오기
		Calendar today = Calendar.getInstance();
		// 2) SimpleDateFormat 객체의 format 메소드를 이용하여 형식 변환하기 (String 값 반환)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = sdf.format(today.getTime());
		// 3) String 값에서 Timestamp 값 얻기 
		Timestamp createDate = Timestamp.valueOf(now);
		// 4) setter 를 이용하여 객체에 값 주입하기
		reservationUserComment.setCreateDate(createDate);
		reservationUserComment.setModifyDate(createDate);
		fileInfo.setCreateDate(createDate);
		fileInfo.setModifyDate(createDate);

		int reservationInfoId = reservationUserComment.getReservationInfoId();
		
		// 1) 리뷰 데이터 저장
		//ReservationUserComment 객체의 변수명을 DB 테이블 필드에 맞추어 매핑
		SqlParameterSource paramMap1 = new BeanPropertySqlParameterSource(reservationUserComment);
		int reservationUserCommentId = insertComment.executeAndReturnKey(paramMap1).intValue();
		
		// 2) 파일 데이터 저장
		SqlParameterSource paramMap2 = new BeanPropertySqlParameterSource(fileInfo);
		int fileId = insertFile.executeAndReturnKey(paramMap2).intValue();
		
		// 3) 리뷰 이미지 데이터 저장
		// NamedParameterJdbcTemplate 의 인자와 달리, java의 카멜 표기법을 사용하지 않고 DB의 실제 컬럼명과 이름이 완전 일치해야 한다. 
		Map<String, Integer> paramMap3 = new HashMap<>();
		paramMap3.put("reservation_info_id", reservationInfoId);
		paramMap3.put("reservation_user_comment_id", reservationUserCommentId);
		paramMap3.put("file_id", fileId);
		int id = insertCommentImage.executeAndReturnKey(paramMap3).intValue();
		
		return reservationUserCommentId;
	}

}

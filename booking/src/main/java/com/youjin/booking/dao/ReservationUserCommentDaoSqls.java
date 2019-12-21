package com.youjin.booking.dao;

public class ReservationUserCommentDaoSqls {

	// 상품별 한줄평
	// 이미지가 있는 한줄평은 왜 레코드가 중복으로 나오는지 ..? ㅜ
	public static final String SELECT_BY_ID = "select distinct reservation_user_comment.id as id, score, comment, description, reservation_email, reservation_date, if(reservation_user_comment_image.reservation_user_comment_id = reservation_user_comment.id, save_file_name, '') as save_file_name from reservation_user_comment, reservation_user_comment_image, product, display_info, reservation_info, file_info where product.id = reservation_user_comment.product_id and reservation_user_comment.reservation_info_id = reservation_info.id and reservation_user_comment_image.file_id = file_info.id and display_info.product_id = product.id and product.id = :id and display_info.id = :displayInfoId";
	
	// 전체 한줄평의 개수 
	public static final String SELECT_COUNT = "select count(reservation_user_comment.id) from reservation_user_comment, product, display_info where reservation_user_comment.product_id = product.id and display_info.product_id = product.id and product.id = :id and display_info.id = :displayInfoId";
	
	// 전체 한줄평의 평균 점수
	public static final String SELECT_AVG = "select avg(score) as avg_score from reservation_user_comment, product, display_info where reservation_user_comment.product_id = product.id and display_info.product_id = product.id and product.id = :id and display_info.id = :displayInfoId";


}

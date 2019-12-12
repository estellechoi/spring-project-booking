package com.youjin.booking.dao;

public class PromotionDaoSqls {

	public static final String SELECT_ALL = "select distinct promotion.id, promotion.product_id, save_file_name from promotion, file_info, product_image  where promotion.product_id = product_image.product_id  and product_image.file_id = file_info.id and product_image.type = 'th'";
}

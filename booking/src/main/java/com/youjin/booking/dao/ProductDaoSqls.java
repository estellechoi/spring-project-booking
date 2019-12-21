package com.youjin.booking.dao;

public class ProductDaoSqls {
	
	public static final String SELECT_COUNT = "SELECT count(*) FROM product";
	public static final String SELECT_COUNT_BY_CATEGORY = "SELECT count(product.id) FROM product, category WHERE category.id = :categoryId AND product.category_id = category.id";
	public static final String SELECT_ALL_LIMIT = "SELECT DISTINCT product.id as id, description, content, display_info.id as display_info_id, place_name, save_file_name FROM product, display_info, product_image, file_info where product.id = display_info.product_id and product.id = product_image.product_id and product_image.file_id = file_info.id and product_image.type = 'th' ORDER BY product.id DESC LIMIT :start, :limit";
	public static final String SELECT_BY_CATEGORY = "SELECT DISTINCT product.id as id, description, content, display_info.id as display_info_id, place_name, save_file_name, category.name as category_name FROM product, display_info, product_image, file_info, category where product.category_id = category.id and product.id = display_info.product_id and product.id = product_image.product_id and product_image.file_id = file_info.id and product_image.type = 'th' and category.id = :categoryId ORDER BY product.id DESC LIMIT :start, :limit";
	public static final String SELECT_BY_ID = "SELECT id, description, content, event FROM product WHERE id = :id";
	public static final String SELECT_IMAGE_BY_ID = "SELECT product.id as id, save_file_name FROM product, file_info, product_image WHERE product.id = :id and product.id = product_image.product_id and product_image.file_id = file_info.id and product_image.type in('ma', 'et')";
	public static final String SELECT_DISPLAY_BY_ID = "select description, content, place_street, place_lot, place_name, tel, save_file_name from product, display_info, display_info_image, file_info where display_info.product_id = product.id and display_info_image.display_info_id = display_info.id and display_info_image.file_id = file_info.id and product.id = :id and display_info.id = :displayInfoId";
}

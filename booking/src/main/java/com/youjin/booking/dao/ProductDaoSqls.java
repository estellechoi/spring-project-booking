package com.youjin.booking.dao;

public class ProductDaoSqls {
	
	public static final String SELECT_COUNT = "SELECT count(*) FROM product";
	public static final String SELECT_COUNT_BY_CATEGORY = "SELECT count(product.id) FROM product, category WHERE category.id = :categoryId AND product.category_id = category.id";
	public static final String SELECT_ALL_LIMIT = "SELECT DISTINCT product.id as id, description, content, place_name, save_file_name FROM product, display_info, product_image, file_info where product.id = display_info.product_id and product.id = product_image.product_id and product_image.file_id = file_info.id and product_image.type = 'th' ORDER BY product.id DESC LIMIT :start, :limit";
	public static final String SELECT_BY_CATEGORY = "SELECT DISTINCT product.id as id, description, content, place_name, save_file_name, category.name as category_name FROM product, display_info, product_image, file_info, category where product.category_id = category.id and product.id = display_info.product_id and product.id = product_image.product_id and product_image.file_id = file_info.id and product_image.type = 'th' and category.id = :categoryId ORDER BY product.id DESC LIMIT :start, :limit";
	public static final String SELECT_BY_ID = "select product.id as id, description, content, event, save_file_name from product, file_info, product_image where product.id = :id and product.id = product_image.product_id and product_image.file_id = file_info.id and product_image.type in('ma', 'et')";
}

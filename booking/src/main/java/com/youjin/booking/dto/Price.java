package com.youjin.booking.dto;

public class Price {
	// product
	private int id;

	// product_price
	private String priceTypeName;
	private int price;
	private long discountRate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPriceTypeName() {
		return priceTypeName;
	}

	public void setPriceTypeName(String priceTypeName) {
		this.priceTypeName = priceTypeName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public long getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(long discountRate) {
		this.discountRate = discountRate;
	}

}

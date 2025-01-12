package com.food.model.dao.model;

public class Order {
	
	private int orderId;
	private int userId;
	private int restaurantId;
	private int menuId;
	private int quantity;
	private int total;
	private String paymentMode;
	private String status;
	
	public Order(int orderId, int userId, int restaurantId, int menuId, int quantity, int total, String paymentMode,
			String status) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.restaurantId = restaurantId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.total = total;
		this.paymentMode = paymentMode;
		this.status = status;
	}

	public Order() {
		
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		
		return orderId + " " + userId + " " + restaurantId + " "+ menuId + " " + quantity + " " + total + " " + paymentMode + " " + status;
	}
	
	
}

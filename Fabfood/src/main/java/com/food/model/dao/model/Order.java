package com.food.model.dao.model;

public class Order {
	
	public static final int DEFAULT_ID = 0; 
	private int orderId;
	private int userId;
	private int quantity;
	private int total;
	private String orderDate;
	private String paymentMode;
	private String status;
	
	public Order(int orderId, int userId, int quantity, int total, String paymentMode,
			String status) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.quantity = quantity;
		this.total = total;
		this.paymentMode = paymentMode;
		this.status = status;
	}

	public Order(int orderId, int userId, int quantity, int total,String orderDate, String paymentMode,
			String status) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.quantity = quantity;
		this.total = total;
		this.orderDate = orderDate;
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

	public String getOrderDate() {
		return orderDate;
	}
	
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	
	@Override
	public String toString() {
		
		return orderId + " " + userId + " " + quantity + " " + total + " " + paymentMode + " " + status;
	}

	
	
}

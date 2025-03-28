package com.food.model.dao.model;

public class OrderItem {
	public static final int DEFAULT_ID = 0;
	private int orderItemId;
	private int orderId;
	private int menuId;
	private int quantity;
	private int itemTotal;
	
	public OrderItem(int orderItemId, int orderId, int menuId, int quantity, int itemTotal) {
		super();
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
	}

	public OrderItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
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

	public int getItemTotal() {
		return itemTotal;
	}

	public void setItemTotal(int itemTotal) {
		this.itemTotal = itemTotal;
	}

	@Override
	public String toString() {
		return  "[ " + orderItemId + " " + orderId + " " + menuId + " " + quantity + " " + itemTotal + " ]";
	}
	
	
	
}

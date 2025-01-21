package com.food.model.dao.model;

public class OrderHistory {
    private String restaurantName;
    private String itemName;
    private int price;
    private int quantity;
    private int itemTotal;
    private String status;
    private String orderDate;

    public OrderHistory(String restaurantName, String itemName,int price, int quantity,int itemTotal, String status,String orderDate) {
        this.restaurantName = restaurantName;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
        this.itemTotal = itemTotal;
        this.status = status;
        this.orderDate = orderDate;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getItemTotal() {
        return itemTotal;
    }

    public void setItemTotal(int itemTotal) {
        this.itemTotal = itemTotal;
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

    public int getQuantity() {
    	return quantity;
    }
    
    public void setQuantity(int quantity) {
    	this.quantity = quantity;
    }
    
    public int getPrice() {
    	return price;
    }
    
    public void setPrice(int price) {
    	this.price = price;
    }
    
    @Override
    public String toString() {
        return "[ " + " " + restaurantName +" " + itemName + " " + price +" " + quantity +" "+ itemTotal +" " + status +" "+ orderDate +" ]";
    }



}

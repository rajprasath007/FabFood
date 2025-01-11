package com.food.model.dao.pojo;

public class CartItem implements Comparable<CartItem>{
	
	private int menuID;
	private int rId;
	private String itemName;
	private String restaurantName;
	private int price;
	private byte[] image;
	
	public CartItem(int menuID, int rId, String itemName,String restaurantName, int price, byte[] image) {
		super();
		this.menuID = menuID;
		this.rId = rId;
		this.itemName = itemName;
		this.restaurantName = restaurantName;
		this.price = price;
		this.image = image;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return menuID + "," + rId + "," + itemName + "," + price;
	}

	@Override
	public int compareTo(CartItem cartItem) {
		if(this.getMenuID() > cartItem.getMenuID()) return 1;
		return 0;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}
	
}

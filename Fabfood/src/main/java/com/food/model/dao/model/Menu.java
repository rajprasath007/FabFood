package com.food.model.dao.model;

public class Menu {

	private int menuId;
	private int rId;
	private String name;
	private String description;
	private float price;
	private float rating;
	private boolean isAvailable;
	private byte[] image;
	
	public Menu() {
		
	}
	
	public Menu(int menuId,int rId, String name, String description, float price, float rating, boolean isAvailable, byte[] image) {
		super();
		this.setMenuId(menuId);
		this.rId = rId;
		this.name = name;
		this.description = description;
		this.price = price;
		this.rating = rating;
		this.isAvailable = isAvailable;
		this.image = image;
	}

	@Override
	public String toString() {
		return "rId=" + rId + ", name=" + name + ", description=" + description + ", price=" + price + ", rating="
				+ rating + ", image=" + image ;
	}
	
	public boolean getIsAvailable() {
		return isAvailable;
	}
	
	public void setIsAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}
	
	public int getrId() {
		return rId;
	}
	
	public void setrId(int rId) {
		this.rId = rId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public float getPrice() {
		return price;
	}
	
	public void setPrice(float price) {
		this.price = price;
	}
	
	public float getRating() {
		return rating;
	}
	
	public void setRating(float rating) {
		this.rating = rating;
	}
	
	public byte[] getImage() {
		return image;
	}
	
	public void setImage(byte[] image) {
		this.image = image;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	
	
	
}

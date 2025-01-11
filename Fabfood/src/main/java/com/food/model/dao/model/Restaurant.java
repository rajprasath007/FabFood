package com.food.model.dao.model;

public class Restaurant implements Comparable<Restaurant>{

	private int rId;
    private String name;
    private String cuisineType;
    private String address;
    private float rating;
    private int deliveryTime;
    private boolean isActive;
    private byte[] image;  // Changed from FileInputStream to byte[]

    public Restaurant() {}

    public Restaurant(int rId,String name, String cuisineType, String address, float rating, int deliveryTime, boolean isActive, byte[] image) {
    	this.rId = rId;
        this.name = name;
        this.cuisineType = cuisineType;
        this.address = address;
        this.rating = rating;
        this.deliveryTime = deliveryTime;
        this.isActive = isActive;
        this.image = image;
    }
    
    public Restaurant(String name, String cuisineType, String address, float rating, int deliveryTime, boolean isActive, byte[] image) {
        this.name = name;
        this.cuisineType = cuisineType;
        this.address = address;
        this.rating = rating;
        this.deliveryTime = deliveryTime;
        this.isActive = isActive;
        this.image = image;
    }

    @Override
    public String toString() {
        return "name=" + name + ", cuisineType=" + cuisineType + ", address=" + address + ", rating="
                + rating + ", deliveryTime=" + deliveryTime + ", isActive=" + isActive;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCuisineType() {
        return cuisineType;
    }

    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(int deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

	@Override
	public int compareTo(Restaurant r2) {
		Restaurant r1 = this;
		if(r1.name.equals(r2.name)) {
			Integer d1 = r1.deliveryTime;
			Integer d2 = r2.deliveryTime;
			return d1.compareTo(d2);
		}
		else return r1.name.compareTo(r2.name);
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}
}


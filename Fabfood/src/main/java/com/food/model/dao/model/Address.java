package com.food.model.dao.model;

public class Address {
	
	private Integer addressId;
	private String doorNo;
	private String streetName;
	private String city;
	private String state;
	private int pincode;
	private String country;
	

	public Address() {
		super();
	}

	public Address(Integer addressId,String doorNo, String streetName, String city, String state, int pincode, String country) {
		super();
		this.addressId = addressId;
		this.doorNo = doorNo;
		this.streetName = streetName;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
		this.country = country;
	}

	@Override
	public String toString() {
		return  addressId + " " + doorNo + " " + streetName + " "
				+ city + " " + state + " " + pincode + " " + country;
	}
	
	public String getDoorNo() {
		return doorNo;
	}
	public void setDoorNo(String doorNo) {
		this.doorNo = doorNo;
	}
	public String getStreetName() {
		return streetName;
	}
	public void setStreetName(String streetName) {
		this.streetName = streetName;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getPincode() {
		return pincode;
	}
	public void setPincode(int pincode) {
		this.pincode = pincode;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}
}

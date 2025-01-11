package com.food.model.dao.model;

public class User {
	
	private Integer uId;
	private String userName;
	private String email;
	private String password;
	private long mobileNumber;
	private String lastLogin;
	private String accountCreated;
	private Integer addressId;
	

	public User() {
		super();
	}

	public User(String userName, String email, String password, long mobileNumber, String lastLogin) {
		super();
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.mobileNumber = mobileNumber;
		this.lastLogin = lastLogin;
	}
	
	
	public User(Integer uId,String userName, String email, long mobileNumber, Integer addressId) {
		super();
		this.uId = uId;
		this.userName = userName;
		this.email = email;
		this.mobileNumber = mobileNumber;
		this.addressId = addressId;
	}
	
	public User(String userName, String email, String password, long mobileNumber, String lastLogin, Integer addressId) {
		super();
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.mobileNumber = mobileNumber;
		this.lastLogin = lastLogin;
		this.addressId = addressId;
	}
	
	public User(String userName, String email, String password, long mobileNumber, String lastLogin,String accountCreated, Integer addressId) {
		super();
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.mobileNumber = mobileNumber;
		this.lastLogin = lastLogin;
		this.accountCreated = accountCreated;
		this.addressId = addressId;
	}
	
	public User(int uId,String userName, String email, String password, long mobileNumber, String lastLogin,String accountCreated, Integer addressId) {
		super();
		this.uId = uId;
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.mobileNumber = mobileNumber;
		this.lastLogin = lastLogin;
		this.accountCreated = accountCreated;
		this.addressId = addressId;
	}

	public User(String userName, String email, String password, long mobileNumber) {
		super();
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.mobileNumber = mobileNumber;
	}

	public User(Integer uId, String name, String email, Long mobileNumber) {
		this.uId = uId;
		this.userName = name;
		this.email = email;
		this.mobileNumber = mobileNumber;
	}

	@Override
	public String toString() {
		return "userName=" + userName + ", email=" + email + ", password=" + password + ", mobileNumber="
				+ mobileNumber;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public long getMobileNumber() {
		return mobileNumber;
	}
	
	public void setMobileNumber(long mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public String getAccountCreated() {
		return accountCreated;
	}

	public void setAccountCreated(String accountCreated) {
		this.accountCreated = accountCreated;
	}

	public Integer getuId() {
		return uId;
	}

	public void setuId(Integer uId) {
		this.uId = uId;
	}
	

}

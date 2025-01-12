package com.food.model.dao.model;

public class OrderHistory {

	private int oHId;
	private int oId;
	private int total;
	private String status;
	private int rId;
	private int uId;
	
	public OrderHistory(int oHId, int oId, int total, String status, int rId, int uId) {
		super();
		this.oHId = oHId;
		this.oId = oId;
		this.total = total;
		this.status = status;
		this.rId = rId;
		this.uId = uId;
	}

	public OrderHistory() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getoHId() {
		return oHId;
	}

	public void setoHId(int oHId) {
		this.oHId = oHId;
	}

	public int getoId() {
		return oId;
	}

	public void setoId(int oId) {
		this.oId = oId;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	public int getuId() {
		return uId;
	}

	public void setuId(int uId) {
		this.uId = uId;
	}

	@Override
	public String toString() {
		return oHId + " " + oId + " " + total + " " + status + " "+ rId + " " + uId;
	}
	
	
}

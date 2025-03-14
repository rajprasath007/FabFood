package com.food.model.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.AddressDAO;
import com.food.model.dao.model.Address;
import com.security.Secret;

public class AddressDAOImpl implements AddressDAO{
	
	private Connection con;
	private PreparedStatement prepStmt;
	private final String INSERT_QUERY = "insert into address(addressId,dNo,streetName,city,state,pincode,country) values(?,?,?,?,?,?,?)";
	private final String FETCH_ALL_QUERY = "select * from `address`";
	private final String FETCH_QUERY = "select * from `address` where addressId = ?";
	private final String UPDATE_QUERY = "update `address` set dNo = ?, streetName = ? , city = ? , state = ?, pincode = ? , country = ? where addressId = ?";
	private final String DELETE_QUERY = "delete from `address` where addressId = ?";
	private final String LAST_ID_QUERY = "select max(addressId) from address";
	private List<Address> addressDetails = new ArrayList<Address>();
	private int status;
	private Address address;
	private int key;
	
	public int getKey() {
		return key;
	}
	
	public int generateNewKey() {
		try {
			prepStmt = con.prepareStatement(LAST_ID_QUERY);
			ResultSet resultSet = prepStmt.executeQuery();
			if(resultSet == null) key = 1;
			else{
				resultSet.next();
				key = resultSet.getInt(1) + 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return key;
	}

	public AddressDAOImpl() {
		super();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodDelivery","root","root");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int insert(Address address) {
		try {
			prepStmt  = con.prepareStatement(INSERT_QUERY);
			prepStmt.setInt(1, address.getAddressId());
			prepStmt.setString(2, address.getDoorNo());
			prepStmt.setString(3, address.getStreetName());
			prepStmt.setString(4, address.getCity());
			prepStmt.setString(5, address.getState());
			prepStmt.setInt(6, address.getPincode());
			prepStmt.setString(7, address.getCountry());
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<Address> fetchAll() {
		try {
			prepStmt = con.prepareStatement(FETCH_ALL_QUERY);
			ResultSet resultSet  = prepStmt.executeQuery();
			addressDetails = extractAddressDetailsFromResultSet(resultSet);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return addressDetails;
	}


	@Override
	public Address fetch(int addressId) {
		try {
			prepStmt = con.prepareStatement(FETCH_QUERY);
			prepStmt.setInt(1, addressId);
			ResultSet resultSet  = prepStmt.executeQuery();
			List<Address> u = extractAddressDetailsFromResultSet(resultSet);
			if(u.size() > 0) address = u.get(0);
			else address = null;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return address;
	}

	@Override
	public int update(int addressId, Address address) {
		try {
			prepStmt = con.prepareStatement(UPDATE_QUERY);
			prepStmt.setString(1,address.getDoorNo());
			prepStmt.setString(2,address.getStreetName());
			prepStmt.setString(3,address.getCity());
			prepStmt.setString(4,address.getState());
			prepStmt.setInt(5, address.getPincode());
			prepStmt.setString(6,address.getCountry());
			prepStmt.setInt(7, addressId);
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public int delete(int addressId) {
		try {
			prepStmt = con.prepareStatement(DELETE_QUERY);
			prepStmt.setInt(1, addressId);
			status = prepStmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}

	private List<Address> extractAddressDetailsFromResultSet(ResultSet resultSet) {
		try {
			while(resultSet.next()) {
				addressDetails.add( new Address(resultSet.getInt("addressID"),Secret.decrypt(resultSet.getString("dNo")), Secret.decrypt(resultSet.getString("streetName")),Secret.decrypt(resultSet.getString("city")), Secret.decrypt(resultSet.getString("state")),Secret.decrypt(resultSet.getInt("pincode")),Secret.decrypt(resultSet.getString(7))));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return addressDetails;
	}
}

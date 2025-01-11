package com.food.model.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.UserDAO;
import com.food.model.dao.model.User;
import com.security.Secret;

public class UserDAOImpl implements UserDAO{

	private Connection con;
	private PreparedStatement prepStmt;
	private final String INSERT_QUERY = "insert into user(username,email,password,mobileNumber) values(?,?,?,?)";
	private final String FETCH_ALL_QUERY = "select * from `user`";
	private final String FETCH_QUERY = "select * from `user` where uId = ?";
	private final String FETCH_EMAIL_QUERY = "select * from `user` where email = ?";
	private final String UPDATE_QUERY = "update `user` set email = ? where uId = ?";
	private final String UPDATE_ALL_QUERY = "update `user` set username = ?,email = ?,mobileNumber = ?,addressId = ? where uId = ?";
	private final String UPDATE_ALL_EXCEPT_ADDRESS_QUERY = "update `user` set username = ?,email = ?,mobileNumber = ? where uId = ?";
	private final String UPDATE_ADDRESS_QUERY = "update `user` set aId = ? where email = ?";
	private final String UPDATE_LOGIN_QUERY = "update `user` set lastlogin = current_timestamp where email = ?";
	private final String DELETE_QUERY = "delete from `user` where uId = ?";
	private List<User> userDetails = new ArrayList<User>();
	private int status;
	private User user;

	public UserDAOImpl() {
		super();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodDelivery","root","root");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int updateAddress(String email) {
		try {
			prepStmt = con.prepareStatement(UPDATE_ADDRESS_QUERY);
			prepStmt.setString(1, email);
			status = prepStmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public int update(String email) {
		try {
			prepStmt = con.prepareStatement(UPDATE_LOGIN_QUERY);
			prepStmt.setString(1, email);
			status = prepStmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public int updateAll(int uId,User user) {
		try {
			prepStmt = con.prepareStatement(UPDATE_ALL_QUERY);
			prepStmt.setString(1, user.getUserName());
			prepStmt.setString(2, user.getEmail());
			prepStmt.setLong(3, user.getMobileNumber());
			prepStmt.setInt(4, user.getAddressId());
			prepStmt.setInt(5, uId);
			status = prepStmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public User fetch(String email) {
		try {
			prepStmt = con.prepareStatement(FETCH_EMAIL_QUERY);
			prepStmt.setString(1, email);
			ResultSet resultSet  = prepStmt.executeQuery();
			List<User> u = extractUserDetailsFromResultSet(resultSet);
			if(u.size() > 0) user = u.get(0);
			else user = null;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public int insert(User user) {
		try {
			prepStmt  = con.prepareStatement(INSERT_QUERY);
			prepStmt.setString(1, user.getUserName());
			prepStmt.setString(2, user.getEmail());
			prepStmt.setString(3, user.getPassword());
			prepStmt.setLong(4, user.getMobileNumber());
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<User> fetchAll() {
		try {
			prepStmt = con.prepareStatement(FETCH_ALL_QUERY);
			ResultSet resultSet  = prepStmt.executeQuery();
			userDetails = extractUserDetailsFromResultSet(resultSet);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return userDetails;
	}

	@Override
	public User fetch(int uId) {
		try {
			prepStmt = con.prepareStatement(FETCH_QUERY);
			prepStmt.setInt(1, uId);
			ResultSet resultSet  = prepStmt.executeQuery();
			List<User> u = extractUserDetailsFromResultSet(resultSet);
			if(u.size() > 0) user = u.get(0);
			else user = null;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public int update(int uId, String email) {
		try {
			prepStmt = con.prepareStatement(UPDATE_QUERY);
			prepStmt.setString(1, email);
			prepStmt.setInt(2, uId);
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public int delete(int uId) {
		try {
			prepStmt = con.prepareStatement(DELETE_QUERY);
			prepStmt.setInt(1, uId);
			status = prepStmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	private List<User> extractUserDetailsFromResultSet(ResultSet resultSet){
		try {
			while(resultSet.next()) {
				Integer address = resultSet.getInt(8);
				if(resultSet.wasNull()) address = null;
				userDetails.add( new User(resultSet.getInt("uId"),Secret.decrypt(resultSet.getString("userName")),Secret.decrypt(resultSet.getString("email")),Secret.decrypt(resultSet.getString("password")),Secret.decrypt(resultSet.getLong("mobileNumber")), resultSet.getString("lastlogin"), resultSet.getString("accountCreated"),address));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userDetails;
	}

	public int updateAllExcludingAddress(Integer uId, User user) {
		try {
			prepStmt = con.prepareStatement(UPDATE_ALL_EXCEPT_ADDRESS_QUERY);
			prepStmt.setString(1, user.getUserName());
			prepStmt.setString(2, user.getEmail());
			prepStmt.setLong(3, user.getMobileNumber());
			prepStmt.setInt(4, uId);
			status = prepStmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}	
	
}

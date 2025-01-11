package com.food.model.dao.impl;
import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.RestaurantDAO;
import com.food.model.dao.model.Restaurant;

public class RestaurantDAOImpl implements RestaurantDAO {
	
	private Connection con;
	private PreparedStatement prepStmt;
	private final String INSERT_QUERY = "insert into restaurant(name,cuisineType,address,rating, deliveryTime,isActive, image) values(?,?,?,?,?,?,?)";
	private final String FETCH_ALL_QUERY = "select * from `restaurant`";
	private final String FETCH_QUERY = "select * from `restaurant` where rId = ?";
	private final String DELETE_QUERY = "delete from `restaurant` where rId = ?";
	private List<Restaurant> restaurantDetails = new ArrayList<Restaurant>();
	private int status;
	private Restaurant restaurant;
	
	public RestaurantDAOImpl() {
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
	public int insert(Restaurant restaurant) {
		
		try {
			prepStmt  = con.prepareStatement(INSERT_QUERY);
			prepStmt.setString(1, restaurant.getName());
			prepStmt.setString(2, restaurant.getCuisineType());
			prepStmt.setString(3, restaurant.getAddress());
			prepStmt.setFloat(4, restaurant.getRating());
			prepStmt.setInt(5, restaurant.getDeliveryTime());
			prepStmt.setBoolean(6, restaurant.isActive());
			prepStmt.setBytes(7, restaurant.getImage());
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<Restaurant> fetchAll() {
		
		try {
			prepStmt = con.prepareStatement(FETCH_ALL_QUERY);
			ResultSet resultSet  = prepStmt.executeQuery();
			restaurantDetails = extractRestaurantDetailsFromResultSet(resultSet);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return restaurantDetails;
	}

	@Override
	public Restaurant fetch(int rId) {
		try {
			prepStmt = con.prepareStatement(FETCH_QUERY);
			prepStmt.setInt(1, rId);
			ResultSet resultSet  = prepStmt.executeQuery();
			restaurant = extractRestaurantDetailsFromResultSet(resultSet).get(0);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return restaurant;
	}

	@Override
	public int delete(int rId) {
		try {
			prepStmt = con.prepareStatement(DELETE_QUERY);
			prepStmt.setInt(1, rId);
			status = prepStmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	private List<Restaurant> extractRestaurantDetailsFromResultSet(ResultSet resultSet){
		try {
			while(resultSet.next()) {
				restaurantDetails.add(new Restaurant(resultSet.getInt(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4), resultSet.getFloat(5),resultSet.getInt(6),resultSet.getBoolean(7), resultSet.getBytes(8)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return restaurantDetails;
	}

}

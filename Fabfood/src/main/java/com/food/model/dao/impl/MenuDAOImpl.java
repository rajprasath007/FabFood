package com.food.model.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.MenuDAO;
import com.food.model.dao.model.Menu;

public class MenuDAOImpl implements MenuDAO {
	
	private Connection con;
	private PreparedStatement prepStmt;
	private final String INSERT_QUERY = "insert into menu(rId,name,description,price,rating,isAvailable,image) values(?,?,?,?,?,?,?)";
	private final String FETCH_ALL_QUERY = "select * from `menu`";
	private final String FETCH_QUERY = "select * from `menu` where menuId = ?";
	private final String FETCH_R_QUERY = "select * from `menu` where rId = ?";
	private final String DELETE_QUERY = "delete from `menu` where menuId = ?";
	private List<Menu> menuDetails = new ArrayList<Menu>();
	private int status;
	private Menu menu;

	public MenuDAOImpl() {
		super();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodDelivery","root","root");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Menu> fetchRestaurantMenu(int rId){
		try {
			prepStmt = con.prepareStatement(FETCH_R_QUERY);
			prepStmt.setInt(1, rId);
			ResultSet resultSet  = prepStmt.executeQuery();
			menuDetails = extractMenuDetailsFromResultSet(resultSet);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return menuDetails;
	} 
	
	@Override
	public int insert(Menu menu) {
		try {
			prepStmt  = con.prepareStatement(INSERT_QUERY);
			prepStmt.setInt(1, menu.getrId());
			prepStmt.setString(2, menu.getName());
			prepStmt.setString(3, menu.getDescription());
			prepStmt.setFloat(4, menu.getPrice());
			prepStmt.setFloat(5, menu.getRating());
			prepStmt.setBoolean(6, menu.getIsAvailable());
			prepStmt.setBytes(7, menu.getImage());
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<Menu> fetchAll() {
		try {
			prepStmt = con.prepareStatement(FETCH_ALL_QUERY);
			ResultSet resultSet  = prepStmt.executeQuery();
			menuDetails = extractMenuDetailsFromResultSet(resultSet);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return menuDetails;
	}

	@Override
	public Menu fetch(int menuId) {
		try {
			prepStmt = con.prepareStatement(FETCH_QUERY);
			prepStmt.setInt(1, menuId);
			ResultSet resultSet  = prepStmt.executeQuery();
			menu = extractMenuDetailsFromResultSet(resultSet).get(0);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return menu;
	}

	@Override
	public int delete(int menuId) {
		try {
			prepStmt = con.prepareStatement(DELETE_QUERY);
			prepStmt.setInt(1, menuId);
			status = prepStmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	private List<Menu> extractMenuDetailsFromResultSet(ResultSet resultSet){
		try {
			while(resultSet.next()) {
				menuDetails.add( new Menu(resultSet.getInt(1),resultSet.getInt(2),resultSet.getString(3),resultSet.getString(4),resultSet.getFloat(5),resultSet.getFloat(6),resultSet.getBoolean(8), resultSet.getBytes(7)) );
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return menuDetails;
	}

}

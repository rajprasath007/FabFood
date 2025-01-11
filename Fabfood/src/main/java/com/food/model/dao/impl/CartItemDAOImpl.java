package com.food.model.dao.impl;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.food.model.dao.interfaces.CartItemDAO;
import com.food.model.dao.pojo.CartItem;

public class CartItemDAOImpl implements CartItemDAO {

	private Connection con;
	private PreparedStatement preparedStatement;
	private ResultSet resultSet;
	private CartItem cartItem;

	public CartItemDAOImpl() {
		try {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodDelivery","root","root");
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	@Override
	public CartItem fetch(int menuId) {
		try {
			preparedStatement = con.prepareStatement("select m.menuId,r.rId,m.name,m.price,m.image,r.name as resName from menu m inner join restaurant r where m.rId = r.rId and m.menuId = ?;");
			preparedStatement.setInt(1, menuId);
			resultSet = preparedStatement.executeQuery();
			cartItem = extractCartItemFromResultSet(resultSet);
		}
		catch (Exception e) {
			
		}
		return cartItem;
	}

	private CartItem extractCartItemFromResultSet(ResultSet resultSet) {
		try {
			while(resultSet.next()) {
				cartItem = new CartItem(resultSet.getInt("menuId"), resultSet.getInt("rId"), resultSet.getString("name"),resultSet.getString("resName"), resultSet.getInt("price"), resultSet.getBytes("image"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cartItem;
	}

}

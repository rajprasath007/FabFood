package com.food.model.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.OrderItemDAO;
import com.food.model.dao.model.OrderItem;

public class OrderItemDAOImpl implements OrderItemDAO{

	private Connection con;
	private PreparedStatement prepStmt;
	private final String INSERT_QUERY = "insert into orderItems(orderId,menuId,quantity,itemTotal) values(?,?,?,?)";
	private final String FETCH_ALL_QUERY = "select * from `orderItems`";
	private final String FETCH_QUERY = "select * from `orderItems` where orderItemId = ?";
	private final String UPDATE_QUERY = "update `orderItems` set total = ? where orderItemId = ?";
	private final String DELETE_QUERY = "delete from `orderItems` where orderItemId = ?";
	private final String LAST_ID_QUERY = "select max(orderItemId) from orderItems";
	private List<OrderItem> orderItemDetails = new ArrayList<OrderItem>();
	private int status;
	private OrderItem orderItem;
	private ResultSet resultSet;
	private int key;

	public OrderItemDAOImpl() {
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
	public int insert(OrderItem orderItem) {
		try {
			prepStmt = con.prepareStatement(INSERT_QUERY);
			prepStmt.setInt(1, orderItem.getOrderId());
			prepStmt.setInt(2, orderItem.getMenuId());
			prepStmt.setInt(3, orderItem.getQuantity());
			prepStmt.setInt(4, orderItem.getItemTotal());
			status = prepStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<OrderItem> fetchAll() {
		try {
			prepStmt =  con.prepareStatement(FETCH_ALL_QUERY);
			resultSet = prepStmt.executeQuery();
			orderItemDetails = extractDetailsFromResultSet(resultSet);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderItemDetails;
	}

	@Override
	public OrderItem fetch(int orderItemId) {
		try {
			prepStmt = con.prepareStatement(FETCH_QUERY);
			prepStmt.setInt(1, orderItemId);
			resultSet = prepStmt.executeQuery();
			orderItem = extractDetailsFromResultSet(resultSet).get(0);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderItem;
	}

	@Override
	public int update(int orderItemId, OrderItem orderItem) {
		try {
			prepStmt = con.prepareStatement(UPDATE_QUERY);
			prepStmt.setInt(1, orderItem.getQuantity());
			prepStmt.setInt(2, orderItem.getOrderItemId());
			status = prepStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public int delete(int orderItemId) {
		try {
			prepStmt = con.prepareStatement(DELETE_QUERY);
			prepStmt.setInt(1, orderItemId);
			status = prepStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}
	
	private List<OrderItem> extractDetailsFromResultSet(ResultSet resultSet) {
		try {
			while(resultSet.next()) {
				OrderItem orderItem = new OrderItem(resultSet.getInt("orderItemId"),resultSet.getInt("orderId"),resultSet.getInt("menuId"),resultSet.getInt("quantity"),resultSet.getInt("itemTotal"));
				orderItemDetails.add(orderItem);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderItemDetails;
	}
	
}

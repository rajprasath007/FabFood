package com.food.model.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.OrderDAO;
import com.food.model.dao.model.Order;

public class OrdersDAOImpl implements OrderDAO{
	
	private Connection con;
	private PreparedStatement prepStmt;
	private final String INSERT_QUERY = "insert into orders(uId,quantity,total,payment,status) values(?,?,?,?,?)";
	private final String FETCH_ALL_QUERY = "select * from `orders`";
	private final String FETCH_QUERY = "select * from `orders` where orderId = ?";
	private final String UPDATE_QUERY = "update `orders` set status = ? where orderId = ?";
	private final String DELETE_QUERY = "delete from `orders` where orderId = ?";
	private final String LAST_ID_QUERY = "select max(orderId) from orders";
	private List<Order> ordersDetails = new ArrayList<Order>();
	private int status;
	private Order order;
	private ResultSet resultSet;
	private int key;
	
	public OrdersDAOImpl() {
		super();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodDelivery","root","root");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getRencentKey() {
		try {
			prepStmt = con.prepareStatement(LAST_ID_QUERY);
			resultSet = prepStmt.executeQuery();
			resultSet.next();
			key = resultSet.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return key;
	}

	@Override
	public int insert(Order order) {
		try {
			prepStmt = con.prepareStatement(INSERT_QUERY);
			prepStmt.setInt(1, order.getUserId());
			prepStmt.setInt(2, order.getQuantity());
			prepStmt.setInt(3, order.getTotal());
			prepStmt.setString(4, order.getPaymentMode());
			prepStmt.setString(5, order.getStatus());
			status = prepStmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<Order> fetchAll() {
		try {
			prepStmt =  con.prepareStatement(FETCH_ALL_QUERY);
			resultSet = prepStmt.executeQuery();
			ordersDetails = extractDetailsFromResultSet(resultSet);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ordersDetails;
	}
	
	public List<Order> fetchAll(int userId) {
		try {
			prepStmt =  con.prepareStatement("select * from orders where uId = ?");
			prepStmt.setInt(1, userId);I
			resultSet = prepStmt.executeQuery();
			ordersDetails = extractDetailsFromResultSet(resultSet);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ordersDetails;
	}


	@Override
	public Order fetch(int orderId) {
		try {
			prepStmt = con.prepareStatement(FETCH_QUERY);
			prepStmt.setInt(1, orderId);
			resultSet = prepStmt.executeQuery();
			order = extractDetailsFromResultSet(resultSet).get(0);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return order;
	}

	@Override
	public int update(int orderId, Order order) {
		try {
			prepStmt = con.prepareStatement(UPDATE_QUERY);
			prepStmt.setString(1, order.getStatus());
			prepStmt.setInt(2, orderId);
			status = prepStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public int delete(int orderId) {
		try {
			prepStmt = con.prepareStatement(DELETE_QUERY);
			prepStmt.setInt(1, orderId);
			status = prepStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}

	private List<Order> extractDetailsFromResultSet(ResultSet resultSet) {
		try {
			while(resultSet.next()) {
				Order order = new Order(resultSet.getInt("orderId"),resultSet.getInt("uId"),resultSet.getInt("quantity"),resultSet.getInt("total"),resultSet.getString("orderDate"), resultSet.getString("payment"),resultSet.getString("status"));
				ordersDetails.add(order);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ordersDetails;
	}
}

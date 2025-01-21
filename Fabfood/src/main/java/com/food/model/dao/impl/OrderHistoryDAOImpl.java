package com.food.model.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.model.dao.interfaces.OrderHistoryDAO;
import com.food.model.dao.model.OrderHistory;

public class OrderHistoryDAOImpl implements OrderHistoryDAO {
		
		private Connection con;
		private PreparedStatement prepStmt;
		private final String FETCH_ALL_QUERY = "SELECT r.name rname,m.name mname,m.price,o.quantity,oi.itemTotal,o.status,o.orderdate FROM orderItems oi JOIN orders o ON oi.orderId = o.orderId JOIN menu m ON oi.menuId = m.menuId JOIN restaurant r ON m.rId = r.rId WHERE o.uId = ?;";
		private List<OrderHistory> ordersHistoryDetails = new ArrayList<OrderHistory>();
		private ResultSet resultSet;

		public OrderHistoryDAOImpl() {
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
		public List<OrderHistory> fetchAll(int userId) {
			try {
				prepStmt =  con.prepareStatement(FETCH_ALL_QUERY);
				prepStmt.setInt(1, userId);
				resultSet = prepStmt.executeQuery();
				ordersHistoryDetails = extractDetailsFromResultSet(resultSet);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return ordersHistoryDetails;
		}

		private List<OrderHistory> extractDetailsFromResultSet(ResultSet resultSet) {
			try {
				while(resultSet.next()) {
					OrderHistory orderHistory = new OrderHistory(resultSet.getString("rname"),resultSet.getString("mname"),resultSet.getInt("price") ,resultSet.getInt("quantity"),resultSet.getInt("itemTotal"),resultSet.getString("status"),resultSet.getString("orderdate"));
					ordersHistoryDetails.add(orderHistory);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return ordersHistoryDetails;
		}
	
}

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
		private final String INSERT_QUERY = "insert into orderHistory(oId,uId,rId,total,status) values(?,?,?,?,?)";
		private final String FETCH_ALL_QUERY = "select * from `orderHistory`";
		private final String FETCH_QUERY = "select * from `orderHistory` where oHId = ?";
		private final String UPDATE_QUERY = "update `orderHistory` set status = ? where oHId = ?";
		private final String DELETE_QUERY = "delete from `orderHistory` where oHId = ?";
		private final String LAST_ID_QUERY = "select max(addressId) from address";
		private List<OrderHistory> ordersHistoryDetails = new ArrayList<OrderHistory>();
		private int status;
		private OrderHistory orderHistory;
		private ResultSet resultSet;
		private int key;

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
		public int insert(OrderHistory orderHistory) {
			try {
				prepStmt = con.prepareStatement(INSERT_QUERY);
				prepStmt.setInt(1, orderHistory.getoId());
				prepStmt.setInt(2, orderHistory.getuId());
				prepStmt.setInt(3, orderHistory.getrId());
				prepStmt.setInt(4, orderHistory.getTotal());
				prepStmt.setString(5, orderHistory.getStatus());
				status = prepStmt.executeUpdate();
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
			return status;
		}

		@Override
		public List<OrderHistory> fetchAll() {
			try {
				prepStmt =  con.prepareStatement(FETCH_ALL_QUERY);
				resultSet = prepStmt.executeQuery();
				ordersHistoryDetails = extractDetailsFromResultSet(resultSet);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return ordersHistoryDetails;
		}


		@Override
		public OrderHistory fetch(int orderHistoryId) {
			try {
				prepStmt = con.prepareStatement(FETCH_QUERY);
				prepStmt.setInt(1, orderHistoryId);
				resultSet = prepStmt.executeQuery();
				orderHistory = extractDetailsFromResultSet(resultSet).get(0);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return orderHistory;
		}

		@Override
		public int update(int orderHistoryId, OrderHistory orderHistory) {
			try {
				prepStmt = con.prepareStatement(UPDATE_QUERY);
				prepStmt.setString(1, orderHistory.getStatus());
				prepStmt.setInt(2, orderHistoryId);
				status = prepStmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return status;
		}

		@Override
		public int delete(int orderHistoryId) {
			try {
				prepStmt = con.prepareStatement(DELETE_QUERY);
				prepStmt.setInt(1, orderHistoryId);
				status = prepStmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return status;
		}

		private List<OrderHistory> extractDetailsFromResultSet(ResultSet resultSet) {
			try {
				while(resultSet.next()) {
					OrderHistory orderHistory = new OrderHistory(resultSet.getInt("oHId"),resultSet.getInt("oId"),resultSet.getInt("total"),resultSet.getString("status"),resultSet.getInt("rId"),resultSet.getInt("uId"));
					ordersHistoryDetails.add(orderHistory);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return ordersHistoryDetails;
		}
	
}

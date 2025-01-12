package com.food.model.dao.interfaces;

import java.util.List;

import com.food.model.dao.model.OrderHistory;

public interface OrderHistoryDAO {

	int insert(OrderHistory orederHistory);
	List<OrderHistory> fetchAll();
	OrderHistory fetch(int orderHistoryId);
	int update(int orderHistoryId,OrderHistory orderHistory);
	int delete(int orderHistoryId);
	
}

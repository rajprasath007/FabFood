package com.food.model.dao.interfaces;

import java.util.List;

import com.food.model.dao.model.OrderHistory;

public interface OrderHistoryDAO {

	List<OrderHistory> fetchAll(int userId);
	
}

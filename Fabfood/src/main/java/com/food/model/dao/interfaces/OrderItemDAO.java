package com.food.model.dao.interfaces;

import java.util.List;

import com.food.model.dao.model.OrderItem;

public interface OrderItemDAO {
	int insert(OrderItem orderItem);
	List<OrderItem> fetchAll();
	OrderItem fetch(int orderItemId);
	int update(int orderItemId,OrderItem orderItem);
	int delete(int orderItemId);
}

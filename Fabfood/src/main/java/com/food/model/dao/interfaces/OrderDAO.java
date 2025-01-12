package com.food.model.dao.interfaces;

import java.util.List;

import com.food.model.dao.model.Order;

public interface OrderDAO {

	int insert(Order oreder);
	List<Order> fetchAll();
	Order fetch(int orderId);
	int update(int orderId,Order order);
	int delete(int orderId);
}

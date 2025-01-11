package com.food.model.dao.interfaces;

import java.util.List;

import com.food.model.dao.model.Restaurant;

public interface RestaurantDAO {

	int insert(Restaurant restaurant);
	List<Restaurant> fetchAll();
	Restaurant fetch(int rId);
	int delete(int rId);
	
}

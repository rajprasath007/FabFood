package com.food.model.dao.launcher;

import com.food.model.dao.impl.RestaurantDAOImpl;
import com.food.model.dao.model.Restaurant;

public class RestaurantLauncher {
	
	public static void main(String[] args) {
		
		
		Restaurant restaurant = new Restaurant("Nagalatha Hotel","Indian","BTM Layout , Bangalore , India",4.5f,50,true,null);
		RestaurantDAOImpl daoImpl = new RestaurantDAOImpl();
		daoImpl.insert(restaurant);
	}
	

}

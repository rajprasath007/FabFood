package com.food.model.dao.launcher;

import com.food.model.dao.impl.OrdersDAOImpl;
import com.food.model.dao.model.Order;

public class OrdersLauncher {

	public static void main(String[] args) {
		
		OrdersDAOImpl daoImpl = new OrdersDAOImpl();
		daoImpl.insert(new Order(1,38,4,3,5,100,"COD","Delivered"));
		for ( Order oList : daoImpl.fetchAll() ) {
			System.out.println(oList);
		}

	}

}

package com.food.model.dao.launcher;

import com.food.model.dao.impl.OrderHistoryDAOImpl;
import com.food.model.dao.model.OrderHistory;

public class OrderHistoryLauncher {
	
	public static void main(String[] args) {
		
		OrderHistoryDAOImpl daoImpl = new OrderHistoryDAOImpl();
		/*OrderHistory history = new OrderHistory(2,3,400,"Ordered",3,38);
		System.out.println(daoImpl.insert(history));*/
		System.out.println(daoImpl.delete(3));
	}
	
}

package com.food.model.dao.launcher;

import com.food.model.dao.impl.OrderItemDAOImpl;

public class OrderItemLauncher {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		OrderItemDAOImpl daoImpl = new OrderItemDAOImpl();
		
		System.out.println(daoImpl.delete(2));
		
	}

}

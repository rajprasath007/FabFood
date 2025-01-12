package com.food.model.dao.launcher;

import com.food.model.dao.impl.CartItemDAOImpl;

public class CartItemLauncher {
	
	public static void main(String[] args) {
		
		CartItemDAOImpl cartItemImpl = new CartItemDAOImpl();
		System.out.println((cartItemImpl.fetch(2)));
		
	}
	
}

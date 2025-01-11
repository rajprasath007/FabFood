package com.food.model.dao.launcher;

import com.food.model.dao.impl.CartItemImpl;

public class CartItemLauncher {
	
	public static void main(String[] args) {
		
		CartItemImpl cartItemImpl = new CartItemImpl();
		System.out.println((cartItemImpl.fetch(2)));
		
	}
	
}

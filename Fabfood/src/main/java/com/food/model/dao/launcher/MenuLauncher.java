package com.food.model.dao.launcher;


import com.food.model.dao.impl.MenuDAOImpl;
import com.food.model.dao.model.Menu;

public class MenuLauncher {

	public static void main(String[] args) {
		
		MenuDAOImpl daoImpl = new MenuDAOImpl();
		
		Menu menu = new Menu();
		daoImpl.insert(menu);
		
		
	}
	
}

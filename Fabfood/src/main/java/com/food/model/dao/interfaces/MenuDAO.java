package com.food.model.dao.interfaces;

import java.util.List;


import com.food.model.dao.model.Menu;

public interface MenuDAO {

	int insert(Menu menu);
	List<Menu> fetchAll();
	Menu fetch(int menuId);
	int delete(int menuId);
	
}

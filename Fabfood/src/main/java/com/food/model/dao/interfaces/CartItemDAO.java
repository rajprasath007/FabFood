package com.food.model.dao.interfaces;

import com.food.model.dao.pojo.CartItem;

public interface CartItemDAO {
	
	CartItem fetch(int menuId);
	
}

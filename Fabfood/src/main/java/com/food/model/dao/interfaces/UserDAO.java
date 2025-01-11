package com.food.model.dao.interfaces;

import java.util.List;


import com.food.model.dao.model.User;

public interface UserDAO {
	
	int insert(User user);
	List<User> fetchAll();
	User fetch(int uId);
	int update(int  uId, String email);
	int delete(int uId);
}

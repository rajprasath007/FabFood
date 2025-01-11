package com.food.model.dao.launcher;

import com.food.model.dao.impl.UserDAOImpl;

public class UserLauncher {

	public static void main(String[] args) {
		
		//User user = new User("rajprasath","rajprasath@gmail.com","raj12345",9043438319l);
		UserDAOImpl launcher = new UserDAOImpl();
		//int u = launcher.insert(user); 
		System.out.println(launcher.update(3, "raj@gmail.com"));

	}
	
}

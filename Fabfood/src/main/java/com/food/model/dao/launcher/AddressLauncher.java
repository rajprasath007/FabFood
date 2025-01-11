package com.food.model.dao.launcher;

import com.food.model.dao.impl.AddressDAOImpl;
import com.food.model.dao.model.Address;

public class AddressLauncher {
	
	public static void main(String[] args) {
		
		AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
		Address address = new Address(addressDAOImpl.generateNewKey(),"14501","16th Main Road","Bengaluru","Karnataka",630078,"India");
		addressDAOImpl.insert(address);
		System.out.println(address);
	}
	
}

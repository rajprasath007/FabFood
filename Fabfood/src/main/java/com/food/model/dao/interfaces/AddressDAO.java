package com.food.model.dao.interfaces;

import java.util.List;

import com.food.model.dao.model.Address;

public interface AddressDAO {
		
		int insert(Address address);
		List<Address> fetchAll();
		Address fetch(int addressId);
		int update(int addressId,Address address);
		int delete(int addressId);
}

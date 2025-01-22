package com.food.controller;

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.impl.AddressDAOImpl;
import com.food.model.dao.impl.UserDAOImpl;
import com.food.model.dao.model.Address;
import com.food.model.dao.model.User;
import com.security.Secret;

@WebServlet("/UpdateProfile")

public class UpdateProfile extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		Integer uId = (Integer) session.getAttribute("uId");
		String name = req.getParameter("name");
		String email =  req.getParameter("email");
		Long mobileNumber =  Long.parseLong(req.getParameter("mobile"));
		Integer addressId = (Integer) session.getAttribute("addressId");
		String doorNo = req.getParameter("flat");
		try {
			name = Secret.encrypt(name);
			email = Secret.encrypt(email);
			mobileNumber = Secret.encrypt(mobileNumber);
			doorNo = Secret.encrypt(doorNo);
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		UserDAOImpl userDAOImpl = new UserDAOImpl();
		if(!doorNo.equals("")) {
			
			String streetName = Secret.encrypt(req.getParameter("street"));
			String city = Secret.encrypt(req.getParameter("city"));
			String state = Secret.encrypt(req.getParameter("state"));
			Integer pincode = (int) Secret.encrypt(Integer.parseInt(req.getParameter("pincode")));
			String country = Secret.encrypt(req.getParameter("country"));
			AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
			if(addressId != null) {
				Address address = new Address(addressId,doorNo,streetName,city,state,pincode,country);
				addressDAOImpl.update(addressId, address);
				User user = new User(uId,name,email,mobileNumber,addressId);
				userDAOImpl.updateAll(uId, user);
			}
			else {
				Address address = new Address(addressDAOImpl.generateNewKey(),doorNo,streetName,city,state,pincode,country);
				addressDAOImpl.insert(address);
				addressId = addressDAOImpl.getKey();
				User user = new User(uId,name,email,mobileNumber,addressId);
				userDAOImpl.updateAll(uId, user);
				session.setAttribute("addressId", addressId);
			}
		}
		else {
			User user = new User(uId,name,email,mobileNumber);
			userDAOImpl.updateAllExcludingAddress(uId, user);
		}
		resp.sendRedirect("profile.jsp");
	}
	
	

}

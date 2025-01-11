package com.food.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.impl.AddressDAOImpl;
import com.food.model.dao.model.Address;
import com.security.Secret;


@WebServlet("/Profile")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer addressId = (Integer) session.getAttribute("addressId");
		if(addressId != null) {
			AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
			Address address = addressDAOImpl.fetch(addressId);
			session.setAttribute("doorNo", Secret.decrypt(address.getDoorNo()));
			session.setAttribute("streetName", Secret.decrypt(address.getStreetName()));
			session.setAttribute("city", Secret.decrypt(address.getCity()));
			session.setAttribute("state", Secret.decrypt(address.getState()));
			session.setAttribute("pincode", Secret.decrypt(address.getPincode()));
			session.setAttribute("country", Secret.decrypt(address.getCountry()));
		}
		response.sendRedirect("profile.jsp");
	}

}

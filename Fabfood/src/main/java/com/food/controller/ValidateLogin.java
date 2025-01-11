package com.food.controller;

import java.io.IOException;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.impl.RestaurantDAOImpl;
import com.food.model.dao.impl.UserDAOImpl;
import com.food.model.dao.model.Restaurant;
import com.food.model.dao.model.User;
import com.security.Secret;

@WebServlet("/ValidateLogin")
public class ValidateLogin extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		User user = null;
		String email = null;
		String password = null;
		UserDAOImpl daoImpl = null;
		try {
			email = request.getParameter("email");
			password = request.getParameter("password");
			daoImpl = new UserDAOImpl();
			user = daoImpl.fetch(Secret.encrypt(email));
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		if(user != null) {
				if(password.equals(user.getPassword())) {
					daoImpl.update(Secret.encrypt(email));
					HttpSession session = request.getSession(); 
					session.setAttribute("uId", user.getuId());
					session.setAttribute("addressId", user.getAddressId());
					RestaurantDAOImpl rdaoImpl = new RestaurantDAOImpl();
					List<Restaurant> restaurantList = rdaoImpl.fetchAll();
					session.setAttribute("restaurants", restaurantList);
					response.sendRedirect("dashboard.jsp");
				}
				else {
					response.setContentType("application/json");
			        response.getWriter().write("{\"status\":\"error\",\"message\":\"Incorrect password\"}");
				}
		}
		else{
			response.setContentType("application/json");
	        response.getWriter().write("{\"status\":\"error\",\"message\":\"No user found\"}");
		}
	}

}

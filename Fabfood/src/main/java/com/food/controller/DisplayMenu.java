package com.food.controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.impl.MenuDAOImpl;
import com.food.model.dao.impl.RestaurantDAOImpl;
import com.food.model.dao.model.Menu;
import com.food.model.dao.model.Restaurant;


@WebServlet("/DisplayMenu")
public class DisplayMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int rId =  Integer.parseInt(request.getParameter("restaurantId"));
		RestaurantDAOImpl resDaoImpl = new RestaurantDAOImpl();
		Restaurant restaurant = resDaoImpl.fetch(rId);
		HttpSession session = request.getSession();
		session.setAttribute("currentRestaurant", restaurant);
		response.sendRedirect("menu.jsp");
		MenuDAOImpl menuDaoImpl = new MenuDAOImpl();
		List<Menu> menus =  menuDaoImpl.fetchRestaurantMenu(rId);
		session.setAttribute("menus", menus);
	}

}

package com.food.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.food.model.dao.impl.MenuDAOImpl;
import com.food.model.dao.impl.RestaurantDAOImpl;
import com.food.model.dao.model.Menu;
import com.food.model.dao.model.Restaurant;

@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RestaurantDAOImpl restaurantDaoImpl = new RestaurantDAOImpl();
		List<Restaurant> restaurants = restaurantDaoImpl.fetchAll();
		request.getSession().setAttribute("restaurants", restaurants);
		MenuDAOImpl menuDaoImpl = new MenuDAOImpl();
		List<Menu> menus = menuDaoImpl.fetchAll();
		request.getSession().setAttribute("menus",menus);
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}

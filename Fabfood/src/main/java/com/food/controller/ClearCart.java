package com.food.controller;

import java.io.IOException;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.pojo.CartItem;


@WebServlet("/ClearCart")
public class ClearCart extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		TreeMap<CartItem, Integer> map = (TreeMap<CartItem,Integer>)(session.getAttribute("cartItems"));
		map.clear();
		response.sendRedirect("cart.jsp");
	}

}

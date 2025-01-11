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

@WebServlet("/DeleteCartItem")
public class DeleteCartItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		int id = Integer.parseInt(request.getParameter("cartItemId"));
		@SuppressWarnings("unchecked")
		TreeMap<CartItem, Integer> cartMap = (TreeMap<CartItem, Integer>)(session.getAttribute("cartItems"));
		CartItem itemToBeRemoved = null;
		for ( CartItem cartItem : cartMap.keySet() ) {
			if(cartItem.getMenuID() == id) { itemToBeRemoved = cartItem; break;} 
		}
		if(itemToBeRemoved != null) {
			cartMap.remove(itemToBeRemoved);
		}
		
		response.sendRedirect("cart.jsp");
		
	}
		
}

package com.food.controller;

import java.io.IOException;
import java.util.TreeMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.impl.CartItemDAOImpl;
import com.food.model.dao.pojo.CartItem;

@WebServlet("/UpdateCart")
public class UpdateCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int valId = Integer.parseInt(request.getParameter("menuId"));
		int updateQuantity = Integer.parseInt(request.getParameter("updateQuantity"));
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		TreeMap<CartItem,Integer> cartItemsMap = (TreeMap<CartItem,Integer>) (session.getAttribute("cartItems"));
		CartItemDAOImpl cartItemDAOImpl = new CartItemDAOImpl();
		CartItem cartItem = cartItemDAOImpl.fetch(valId);
		int val = cartItemsMap.get(cartItem);
		if((val > 1 && updateQuantity == -1) || (updateQuantity == 1)) cartItemsMap.put(cartItem, val+updateQuantity);
		
		response.setContentType("text/plain");
		response.getWriter().write("success");
	}

}

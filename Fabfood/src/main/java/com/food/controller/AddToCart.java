package com.food.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.food.model.dao.impl.CartItemDAOImpl;
import com.food.model.dao.pojo.CartItem;


@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int id = Integer.parseInt(request.getParameter("menuId"));
		String valId = "addToCartQuantity-"+id;
		int val = Integer.parseInt(request.getParameter(valId));
		HttpSession session = request.getSession();
		Object cartItems = session.getAttribute("cartItems");
		CartItemDAOImpl cartItemDaoImpl = new CartItemDAOImpl();
		CartItem cartItem = cartItemDaoImpl.fetch(id);
		if(cartItems == null) {
			TreeMap<CartItem,Integer> cartItemsNew = new TreeMap<CartItem, Integer>();
			cartItemsNew.put(cartItem,val);
			session.setAttribute("cartItems",cartItemsNew);
		}
		else {
			@SuppressWarnings("unchecked")
			TreeMap<CartItem,Integer> map = (TreeMap<CartItem,Integer>)(cartItems);
			map.put(cartItem, val);
		}
		
		JSONObject jsonObject = new JSONObject();
		
		TreeMap<CartItem, Integer> map = (TreeMap<CartItem,Integer>)(session.getAttribute("cartItems"));
		jsonObject.put("message", "success");
		jsonObject.put("cartSize", map.size());
		
		response.setContentType("application/json");
		response.getWriter().write(jsonObject.toString());
		
	}

}

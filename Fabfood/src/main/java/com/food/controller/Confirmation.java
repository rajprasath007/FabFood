package com.food.controller;

import java.io.IOException;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.model.dao.impl.OrderItemDAOImpl;
import com.food.model.dao.impl.OrdersDAOImpl;
import com.food.model.dao.model.Order;
import com.food.model.dao.model.OrderItem;
import com.food.model.dao.pojo.CartItem;


@WebServlet("/Confirmation")
public class Confirmation extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Order order;
		OrderItemDAOImpl orderItemDaoImpl = new OrderItemDAOImpl();
		OrderItem orderItem;
		OrdersDAOImpl ordersDaoImpl = new OrdersDAOImpl();
		int orderId;
		HttpSession session =  request.getSession();
		String paymentType = request.getParameter("paymentMode");
		@SuppressWarnings("unchecked")
		TreeMap<CartItem,Integer> cartItems = (TreeMap<CartItem, Integer>) session.getAttribute("cartItems");
		int total = 0, qunatity = 0;
		for(Entry<CartItem, Integer> map : cartItems.entrySet()) {
			total += map.getKey().getPrice() * map.getValue();
			qunatity += map.getValue();
		}
		order = new Order(Order.DEFAULT_ID, (int) session.getAttribute("uId"), qunatity, total, paymentType, "Ordered");
		ordersDaoImpl.insert(order);
		orderId = ordersDaoImpl.getRencentKey();
		for(CartItem map : cartItems.keySet()) {
			int menuId = map.getMenuID();
			int quantity = cartItems.get(map);
			int itemTotal = map.getPrice() * quantity;
			orderItem = new OrderItem(OrderItem.DEFAULT_ID,orderId,menuId,quantity,itemTotal); 
			orderItemDaoImpl.insert(orderItem);
		}
		response.sendRedirect("placeorder.jsp");
		
	}

}

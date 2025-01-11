package com.food.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.food.model.dao.impl.UserDAOImpl;
import com.food.model.dao.model.User;
import com.security.Secret;

@WebServlet("/register")
public class CollectData extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userName = Secret.encrypt(req.getParameter("name"));
		String email = Secret.encrypt(req.getParameter("email"));
		long mobileNumber = Secret.encrypt(Long.parseLong(req.getParameter("tel")));
		String password = Secret.encrypt(req.getParameter("password"));
		User user = new User(userName,email,password,mobileNumber);
		UserDAOImpl userDAOImpl = new UserDAOImpl();
		PrintWriter printWriter = resp.getWriter();
		if(userDAOImpl.fetch(email) == null) { 
			int status = userDAOImpl.insert(user);
			printWriter.print(status > 0 ? "success" : "failure"); 
			RequestDispatcher rd = req.getRequestDispatcher("/ValidateLogin");
			rd.forward(req, resp);
		}
		else {
			printWriter.print("Try different email, Already an user with this email");
		}
	}

}

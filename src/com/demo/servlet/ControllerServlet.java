package com.demo.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import com.google.gson.*;

/**
 * Servlet implementation class ControllerServlet
 */
@WebServlet("/ControllerServlet")
@MultipartConfig
public class ControllerServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private ModelDB model;
	
	// Data source injection defined in context.xml
	@Resource(name="jdbc/test_db") 
	private DataSource datasource;
	
	@Override
	public void init() throws ServletException { 
		super.init();
		// initialize database model with the data source
		// init() is ran once only when the application starts
		try {
			model = new ModelDB(datasource);
		} catch(Exception e) {
			System.out.println(e.getMessage() + "/nError init() modelDB");
		}
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		
		try {
			// Command parameter determines which form was submitted and which method to call 
			 String command = request.getParameter("command");
			 
			 if(command == null) {
				 response.sendRedirect("login.jsp");
			 }
			
			switch (command) {
				case "searchForm":
					search(request, response);
					break;
				case "addRecord":
					addRecord(request, response);
					break;
				case "retrieve":
					retrieve(request, response);
					break;
				default:
					response.sendRedirect("test.jsp");
			}
		}
		catch (Exception e){
			System.out.println("Exception in get()");
			e.printStackTrace();
		}
	}

	private void retrieve(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	private void addRecord(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// AJAX call, data will be sent back in JSON form
		try {
			// Store data into Database and store in list
			String orderid = request.getParameter("orderid");
			String name = request.getParameter("name");
			String json;
			
			// True if insertion was successful
			if(model.addRecord(orderid, name)) {
				json = new Gson().toJson("{\"insert\": true}");
			}
			else {
				json = new Gson().toJson("{\"insert\": false}");
			}
			
			// Send data back as JSON objects
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(200);
			response.getWriter().write(json);;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error in search");
			response.sendRedirect("login.jsp");
		}
	}

	private void search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// AJAX call, data will be sent back in JSON form
		try {
			// Retrieve data from Database and store in list
			String keyword = request.getParameter("searchKeyword");
			String category = request.getParameter("searchCategory");
			ArrayList<Order> orders = model.searchBy(keyword, category);
			String json = new Gson().toJson(orders);
			
			// Send data back as JSON objects
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error in search");
			response.sendRedirect("login.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String command = request.getParameter("command");
			
			switch (command) {
				case "signin":
					signIn(request, response);
					break;
				case "admin":
					admin(request, response);
					break;
				case "user":
					user(request, response);
					break;
				default:
					// redirect to sign in page if 'command' parameter is unknown/null
					RequestDispatcher dispatcher = request.getRequestDispatcher("/test.jsp");
					dispatcher.forward(request, response);
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	private void user(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getSession().setAttribute("privilege", false);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin.jsp");
		dispatcher.forward(request, response);
		
	}

	private void admin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.getSession().setAttribute("privilege", true);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin.jsp");
		dispatcher.forward(request, response);
		
	}

	private void signIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// send user information to user table in database model
		User user = new User(request.getParameter("userName"), request.getParameter("password"));
		
		// call a page redirect depending on if user is an admin or user; or throw exception if no match found in table
		try {
			int admin = model.getUser(user);
			// issue: user object never used again
			if(admin == 1) {
				user.setAdmin(true);
				admin(request, response);
			}
			else {
				user.setAdmin(false);
				user(request, response);
			}
		} catch (Exception e){
			request.setAttribute("invalidLogin", true);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
			dispatcher.forward(request, response);
		} 
	}

}

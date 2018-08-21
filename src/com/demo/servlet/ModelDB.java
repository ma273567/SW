package com.demo.servlet;

import javax.sql.DataSource;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ModelDB {

	private DataSource datasource;
	
	public ModelDB(DataSource ds) {
		datasource = ds;
	}
	
	public int getUser(User user) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int admin = 0;
		
		try {
			
			String query = "SELECT * FROM user WHERE username=? AND password=md5(?)";
			
			conn = datasource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				admin = rs.getInt("admin");
			}
			else {
				throw new Exception("unknown user");
			}
			
			return admin;
		} 
		finally {
			// close connection to database
			conn.close();
			pstmt.close();
			rs.close();
			
		}
	}
	
	public ArrayList<Order> searchBy(String keyword, String category) throws Exception {
			
		ArrayList<Order> orders = new ArrayList<Order>();
		Order order;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM orders WHERE " + category + " LIKE ?";
		
		try {
			conn = datasource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, new String("%" + keyword + "%"));
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				String orderID = rs.getString("Order_ID");
				String customerName = rs.getString("Customer_Name");
				String orderDate = rs.getString("Order_Date");
				int zipcode = rs.getInt("Zipcode");
				String state = rs.getString("State");
				
				order = new Order(orderID, customerName, orderDate, zipcode, state);
				orders.add(order);
				
			}
			return orders;
			
		} catch (Exception e) {
			throw new Exception("unknown user");
		}
		finally {
			// close connection to database
			conn.close();
			pstmt.close();
			rs.close();
		}
	}
	
	public boolean addRecord(String orderID, String name) throws SQLException {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		// fields are mostly dummy data
		int zipcode = 00000;
		String queryInsert = "INSERT INTO orders VALUES (?, '22/01/2018', '23/01/2018', 'First Class', "
				+ "'BC-12312', ?, 'Paris', 'Ohio', ?)";
		
		try {
			conn = datasource.getConnection();
			pstmt = conn.prepareStatement(queryInsert);
			pstmt.setString(1, orderID);
			pstmt.setString(2, name);
			pstmt.setInt(3, zipcode); // dummy data for int zipcode
			
			pstmt.execute();
			
			return true;
			
		} catch (MySQLIntegrityConstraintViolationException e) {
			return false;
			
		} finally {
			// close connection to database
			conn.close();
			pstmt.close();
		}
	}
}

	

package com.demo.servlet;

public class Order {

	/* 
	 * The variables here do not represent the complete columns in the 'orders' table
	 * for simplicity sake
	 */
	private String orderID, orderDate, customerName, state  = null;
	
	private int zipcode;
	
	public Order(String orderID, String customerName, String orderDate, int zipcode, String state) {
		this.orderID = orderID;
		this.customerName = customerName;
		this.orderDate = orderDate;
		this.zipcode = zipcode;
		this.state = state;
	}

	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}


	public int getZipcode() {
		return zipcode;
	}

	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}

package com.demo.servlet;

public class User {

	private String username;
	private String password;
	private boolean admin;
	
	public User(String username, String password) {
		this.username = username;
		this.password = password;
		this.admin = false;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}
	
	
	
}

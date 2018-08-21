<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <meta charset="utf-8">
	  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	  
	  <title>View</title>

	<!-- Scripting starts here -->
		<script>
		$(document).ready(function() {
			
			// Search bar functionality
			// with minimal pattern search
			$('#search').click(function() {
				
				var category = $('#searchOption').val();
 				var keyword = $('#searchKeyword').val();
				var params = {
						command : "searchForm",
						searchKeyword : keyword,
						searchCategory : category
					};
				// TODO: AjAX Pagination, limit 10 records per page
				$.get("ControllerServlet", $.param(params), function(data, status) {
					console.log(data);
 				    // populate table
 				   	var length = data.length;
 				    // update "# of hits" 
 				    $('#hits').text('(' + length + ' records)');
 				    // create new table rows after deleting old ones
 				    $('#tableBody > tr').empty();
 				   	
 				    $.each(data, function(key, value) {
 				    	$("<tr>").appendTo($("#tableBody"))                     
 		                .append($("<th>").text(value.orderID))
 		                .append($("<td>").text(value.orderDate))
 		                .append($("<td>").text(value.customerName))
 		                .append($("<td>").text(value.zipcode))
 		                .append($("<td>").text(value.state))
 		                .append("<td><a href='#'>update</a></td>"); 
 				    });
 				    
 				});
			})
			
			// Adding new record with an AJAX call
			// Admin only inserts 2 data fields, for simplicity
			$('#addNew').click(function(){
				
				var command = "addRecord";
				var params = {
					command: "addRecord",
					orderid: $('input[name="orderID"]').val(),
					name: $('input[name="customerName"]').val()
				}
				
				$.get("ControllerServlet", $.param(params), function(data, status) {
					
					console.log(data);
					var parsedData = JSON.parse(data);
					// read data and show alert success or fail
					if(parsedData.insert === false) {
						alert("Failed to add!");
					}
					else {
						alert("Successfully added!");
					}
					
				})
				
			})
			// Toggle 'add new' button based on user privilege
			// clicking back button on browser breaks this function. 
			// Should disable cache in servlet
			$(function() {
				
				if($("#privilege").val()) {
					$("#addBtn").addClass("btn-primary").prop("disabled", false);
				}
				else {
					$("#addBtn").prop("disabled", true);
				}
			});
			// remove highlight on some buttons
 			$('.btn').mouseup(function() { this.blur() });
 			$('a').mouseup(function() { this.blur() });
 			
 			// TODO: add function to update column
		});
		</script>
	<!-- Scripting ends -->
</head>
<body style="background-color: #d2d2d2; height: 100%; margin: 0;padding: 0;">
	<div class="card card-header image">
		<div class="container">
			<!-- Testing Page -->
			<h4 class="display-4 text-center" style="padding: 1.2rem .5rem;">
			<c:out value="${sessionScope.privilege ? 'Welcome Admin!' : 'Welcome User!'}"></c:out></h4>
			<input id="privilege" type="hidden" value="${sessionScope.privilege}">
			<!-- Testing Page -->
		</div>
		<div class="container search-bar">
		<!-- Use AJAX here to search information from the database -->
		<div class="input-group col">
		    <input type="text" class="form-control" placeholder="Search" id="searchKeyword" required>
		      <div class="input-group-append col-4">
				  <select class="custom-select" id="searchOption">
				    <option selected value="Order_ID" >Order ID</option>
				    <option value="Customer_Name">Customer Name</option>
				    <option value="State">State</option>
				    <option value="Order_Date">Order Date</option>
				  </select>
				  <div class="input-group-append">
				    <button id="search" class="btn btn-success active" type="submit"> Search</button>
				  </div>
				</div>
		  </div>
		</div>
	</div>
	<!-- Bootstrap Modal -->
	<div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header" style="background-color:black;">
	          <h4 class="display-6" style="color:white;">Add New Record</h4>
	          <button type="button" class="close btn-default" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="container modal-form">
		        <form action="#">
				  <div class="form-group row">
					  <div class="col-4"><label for="orderID">Order #: </label></div>
					  <div class="col"><input type="text" class="form-control" name="orderID" required></div>
				  </div>
				  <div class="form-group row">
				  	<div class="col-4"><label for="customerName">Customer Name: </label></div>
				  	<div class="col"><input type="text" class="form-control" name="customerName" required></div>
				  </div>
				  <div class="form-group row">
				  	<div class="col-sm"></div>
				  	<div class="col-sm-2"><button id="addNew" type="button" class="btn btn-success">Save</button></div>
				  	<div class="col-sm-2"><button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button></div>
				  	<div class="col-sm"></div>
				  </div>
				</form>
	        </div>
	      </div>
	    </div>
	  </div>
	<div class=" card card-body">
		<!-- Use AJAX here to search information from the database 
			using id = ajaxResponse
		-->
		<div class=" row">
		<div class="col">
		<h2>Results</h2><h6 id="hits">(0 records)</h6>
		</div>
		<div class="input-btn-group col-2">
			<!-- Use jquery to toggle the disabled attribute depending on user privilege 
				Issues when clicking the back button -->
		    <button id="addBtn" class="btn float-right" disabled="disabled" type="button"
		     data-toggle="modal" data-target="#myModal">Add New</button>
		</div>
		</div>
		<table id="table" class="table table-hover">
		  <thead class="thead-dark text-center">
		    <tr>
		      <th scope="col">Order#</th>
		      <th scope="col">Order Date</th>
		      <th scope="col">Customer Name</th>
		      <th scope="col">Zipcode</th>
		      <th scope="col">State</th>
		      <th scope="col">Update</th>
		    </tr>
		  </thead>
		  <tbody id="tableBody" class="data text-center">
		    <tr id="nullData">
		      <th scope="row">null</th>
		      <td>(empty)</td>
		      <td>(empty)</td>
		      <td>(empty)</td>
		      <td>(empty)</td>
		      <td><a href="#">update</a></td>
		    </tr>
		  </tbody>
		</table>
	</div>
	<div class="container-fluid foot-nav card-footer footer">
		<!--  TODO
			Use jquery to toggle disabled/active links based on the pages user is at
			Use ajax to retrieve new set of 10 records from database per page
		 -->
		<nav aria-label="Page navigation">
		  <ul class="pagination">
		    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item"><a class="page-link" href="#">Next</a></li>
		  </ul>
		</nav>
	</div>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
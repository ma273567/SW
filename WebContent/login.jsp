<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href=${pageContext.request.contextPath}/css/bootstrap.min.css>
    <link rel="stylesheet" href=${pageContext.request.contextPath}/css/style.css>
	<title>Sign-In</title>
	<!--  set session attribute privilege default to user -->
	<c:set var="privilege" value="${false}" scope="session"/>
</head>
<body class="signin-body" background="${pageContext.request.contextPath}/css/bg.png">
    <div class="container signin-container">
        <div class="row">
        	<div class="col"></div>
            <div class="col-6">
            <c:if test="${requestScope.invalidLogin}">
            	<div class="alert alert-danger alert-dismissible fade show">
				    <button type="button" class="close" data-dismiss="alert">&times;</button>
				    Login Error!
				  </div>
            </c:if>
                <div class="card signin-card">
                    <div class="card-block">
                    	<div class="row">
                    		<div class="col">
                    		<h1 class="text-center login">Demo App</h1>
                    		</div>
                    	</div>
                        <form class="signin-form" action="ControllerServlet" method="POST">
                        	<input type="hidden" name="command" value="signin">
                            <div class="form-group row">
                                <input type="text" class="form-control" name="userName" placeholder="username" required>
                            </div>
                            <div class="form-group row">
                                <input type="password" class="form-control" name="password" placeholder="Password" required>
                            </div>
                            <div class="form-group row">
                            	<div class="col-4"></div>
                            	<div class="col-4">
                            		<button type="submit" class="btn signin-btn btn-primary">Sign In</button>
                            	</div>
                            	<div class="col-4"></div>
                        	</div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col"></div>
        </div>
    </div>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" 
	integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" 
	crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
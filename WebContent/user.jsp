<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href=${pageContext.request.contextPath}/css/bootstrap.min.css>
    <link rel="stylesheet" href=${pageContext.request.contextPath}/css/bootstrap-theme.min.css>
    <link rel="stylesheet" href=${pageContext.request.contextPath}/css/style.css>
<title></title>
</head>
<body class="container-fluid">
	<c:if test="${sessionScope.privilege == 'admin'}"><p class="h4">Welcome, Admin!</p></c:if>
	<c:if test="${sessionScope.privilege == 'user'}"><p class="h4">Welcome, User!</p></c:if>
	
	
	
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" 
	integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" 
	crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
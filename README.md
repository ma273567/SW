# Software Engineering Project

A reworked J2EE course project which was originally written using the Spring Boot framework. 
It is a simple MVC application with a MySQL database model, Java/JSP controller, and a HTML, CSS, Bootstrap 
and JQuery view.

The view consists of 2 JSP pages, a log-in page and a user/admin page. The user would log on, and the user information
would be pulled from the database to check if user has either an admin or normal privilege. Upon successful log in, the controller
servlet redirects the view to admin.jsp. This page provides a database searching function using a JQuery/AJAX call to the controller, 
populating the table on the page. Only a few columns are displayed since this is only for testing. 

The controller servlets is used mainly as data handler from the view to the database and back again. For form data using POST, I used the
session and pageContext objects to bind the values from the view using a little of both JSP and JSTL. Other data are passed as JSON objects, when using AJAX. 





# Issues, To-Do list

- AJAX Pagination
- Web interface not very responsive
- update column
- deployment

<%-- 
    Document   : logout
    Created on : Mar 12, 2014, 1:37:00 AM
    Author     : Pae
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/netprog";
                String username = "pshop";
                String password = "";
                Connection connection = DriverManager.getConnection(dbURL,username,password);
                Statement statement = connection.createStatement();
                String query="DELETE from CART where username='"+session.getAttribute("username")+"'";
                System.out.println(query);
                        int rowCount = statement.executeUpdate(query);
                        session.invalidate();
                        response.sendRedirect("product.jsp");
        }
        
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
         
        
            }
        
        %>
        <h1>Hello World!</h1>
    </body>
</html>

<%-- 
    Document   : waitadd
    Created on : Mar 12, 2014, 11:37:08 PM
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
        <title>waitadd</title>
    </head>
    <body>
         <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/netprog";
                String username = "pshop";
                String password = "";
                Connection connection = DriverManager.getConnection(dbURL,username,password);
            
                Statement statement = connection.createStatement();
                //ResultSet userIDResult = statement.executeQuery("SELECT * FROM product");
                String query="insert into product (issn,tname,tpicurl1,tdescription,tquantity,tprice,category) values('"+request.getParameter("isbn")+"',"+"'"+request.getParameter("name")+"',"+"'"+request.getParameter("url")+"',"+"'"+request.getParameter("description")+"',"+"'"+request.getParameter("quantity")+"',"+"'"+request.getParameter("price")+"',"+"'"+request.getParameter("category")+"'"+")";
                System.out.println(query);
                int rowCount = statement.executeUpdate(query);
                response.sendRedirect("product.jsp");
        %>
        <h1>Wait Add</h1>
        <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
                response.sendRedirect("add.jsp?status=false");
            }
           
        %>
    </body>
</html>

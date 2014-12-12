<%-- 
    Document   : waitlogin
    Created on : Mar 11, 2014, 11:42:41 PM
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
        <title>wait sign up</title>
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
                
                ResultSet userIDResult = statement.executeQuery("SELECT username FROM user where username='"+request.getParameter("username")+"'");
                userIDResult.next();
                try{
                    userIDResult.getString(1);
                    response.sendRedirect("signup.jsp?name="+request.getParameter("name")+"&telphone="+request.getParameter("telphone")+"&email="+request.getParameter("email"));
                    
                   
                }catch(SQLException e){
                    String adduser="insert into user (email,username,password,flname,telphone,admin) values('"+request.getParameter("email")+"',"+"'"+request.getParameter("username")+"',"+"'"+request.getParameter("password")+"',"+"'"+request.getParameter("name")+"',"+"'"+request.getParameter("telphone")+"',"+"'"+"0"+"')";
                    System.out.println(adduser);
                    int rowCount = statement.executeUpdate(adduser);
                    session.setAttribute("FLName",request.getParameter("name"));
                    session.setAttribute("username",request.getParameter("username"));
                    response.sendRedirect("product.jsp");  
                            
                      
                }
                
        %>
        <h1>Wait Sign up</h1>
         <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
           
        %>
    </body>
</html>

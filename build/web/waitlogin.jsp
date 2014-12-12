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
        <title>wait login</title>
    </head>
    <body>
        <%
            try{
                if(request.getParameter("username")!=null&&request.getParameter("password")!=null){
                    
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/netprog";
                String username = "pshop";
                String password = "";
                Connection connection = DriverManager.getConnection(dbURL,username,password);
            
                Statement statement = connection.createStatement();
                
                ResultSet userIDResult = statement.executeQuery("SELECT username,password,FLName,Admin FROM user where username='"+request.getParameter("username")+"'");
                userIDResult.next();
                //System.out.println(userIDResult.getString(1).equals(request.getParameter("username")));
                //System.out.println(userIDResult.getString(4));
                try{
                    //userIDResult.getString(1);
                    if(userIDResult.getString(1).equals(request.getParameter("username"))&&userIDResult.getString(2).equals(request.getParameter("password"))){
                        
                            %>Login Success<%
                            session.setAttribute("FLName",userIDResult.getString(3));
                            session.setAttribute("username",userIDResult.getString(1));
                            if(userIDResult.getString(4).equals("1")){
                                session.setAttribute("admin","True");
                            }
                            response.sendRedirect("product.jsp");
                        }else{
                            response.sendRedirect("login.jsp");
                        }
                   
                }catch(SQLException e){
                    
                    response.sendRedirect("login.jsp");
                }
                }
        %>
        <h1>Wait Login</h1>
         <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
           
        %>
    </body>
</html>

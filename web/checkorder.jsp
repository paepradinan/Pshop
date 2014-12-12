<%-- 
    Document   : checkorder
    Created on : Mar 12, 2014, 11:56:50 PM
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
    <%
        if(session.getAttribute("username")==null||session.getAttribute("admin")==null){
            response.sendRedirect("product.jsp");
        }
    %>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	<link rel='stylesheet' type='text/css' href='css/styles.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.css' />
	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
	<script type='text/javascript' src='menu_jquery.js'></script>
<title>Check Order</title>
<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function validate(){
            var name=document.forms["confirm"]["name"].value;
            var address=document.forms["confirm"]["address"].value;
            var telphone=document.forms["confirm"]["tel"].value;
            if(name===null||name===""){
             alert("Please input your name.");
             document.confirm.name.focus();
             return false;
            }
            else if(address===null||address===""){
             alert("Please input your address.");
             document.confirm.address.focus();
             return false;
            }
            else if(telphone===null|telphone===""){
             alert("Please input your telphone number."); 
             document.confirm.tel.focus();
             return false;
            }
            else if(!isDouble(telphone)){
             alert("Please input your telphone number in number."); 
             document.confirm.tel.focus();
             return false;
            }
        }

        function isDouble(str) {
            return !isNaN(str);
//            try {
//                var temp= parseDouble(str);
//                return true;
//            } catch (NumberFormatException e) {
//                return false;
//            }
        }
</script>
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
                ResultSet userIDResult = statement.executeQuery("SELECT orderid,username,flname,fladdress,fltelphone,sumprice FROM orderid");
        %>
<div id='cssmenu'>
<ul>
   <li ><a href='product.jsp'><span>New Product</span></a></li>
   <li class='has-sub'><a><span>Catagory</span></a>
   <ul>
   		<li ><a href='it.jsp'><span>IT</span></a></li>
                
                <li ><a href='book.jsp'><span>BOOK</span></a></li>
   		<li ><a href='sport.jsp'><span>SPORT</span></a></li>
   		<li class='last'><a href='toy.jsp'><span>TOY</span></a></li>
   </ul>
   </li>
   <li ><a href='cart.jsp'><span>Cart</span></a></li>
   <% if(session.getAttribute("username")==null){ %>
        <li ><a href='login.jsp'><span>Login</span></a></li>
   <%}else{%>
         <%if(session.getAttribute("admin")!=null){ %>
        <li class="has-sub active"><a href='admin.jsp'><span>Admin</span></a>
            <ul>
                <li ><a href='add.jsp'><span>ADD PRODUCT</span></a></li>
                <li class="last"><a href='checkorder.jsp'><span>CHECK ORDER</span></a></li>
                
            </ul>
        </li>
         <%}%>
        <li ><a href='logout.jsp'><span>Logout</span></a></li>
        <li ><a><span>Welcome <%=session.getAttribute("FLName")%></span></a></li>
   <%}%>     
   
</ul>
</div>
<form name='buynonmem' action="index.html" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="800" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div class="bs-example table-responsive"><strong>Order All</strong>
                <% while(userIDResult.next()){ %> 
            <table width="800" border="1" class="table table-striped table-hover ">
  
                <tbody>
                     
                  <tr>
                    <td width="200">OrderID</td>
                    <td width="600"><%=userIDResult.getString(1)%></td>
                    </tr>
                  <tr>
                    <td width="200">Name</td>
                    <td width="600"><%=userIDResult.getString(3)%></td>
                    </tr>
                    <tr>
                    <td width="200">Address</td>
                    <td width="600"><%=userIDResult.getString(4)%></td>
                    </tr>
                    <tr>
                    <td width="200">Telphone</td>
                    <td width="600"><%=userIDResult.getString(5)%></td>
                    </tr>
                    <tr>
                    <td width="200">Username</td>
                    <td width="600"><%=userIDResult.getString(2)%></td>
                    </tr><tr>
                    <td width="200">Summary Price</td>
                    <td width="600">$<%=userIDResult.getString(6)%></td>
                    </tr>
                    <tr>
      <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL2 = "jdbc:mysql://localhost:3306/netprog";
                String username2 = "pshop";
                String password2 = "";
                Connection connection2 = DriverManager.getConnection(dbURL2,username2,password2);
            
                Statement statement2 = connection2.createStatement();
                ResultSet userIDResult2 = statement2.executeQuery("SELECT orderrela.issn,orderrela.cquanity FROM orderid inner join orderrela on orderid.orderid=orderrela.orderid where orderid.orderid='"+userIDResult.getString(1)+"'");
                Statement statement3 = connection2.createStatement();
                
      %>

                    <td width="200">Details</td>
                    <td width="600"><%int i=1;%>
                        <% while(userIDResult2.next()){ %>
                        <%ResultSet userIDResult3 = statement3.executeQuery("SELECT tname FROM product where issn='"+userIDResult2.getString(1)+"'");
                        userIDResult3.next();%>
                        <%=i++%>. <%=userIDResult3.getString(1)%>&nbsp;&nbsp;&nbsp;(<%=userIDResult2.getString(2)%>)
                        
                        <br>
                        <%}%>
                    </td>
                    </tr>
           <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
           
        %>        
                  
                  
                  
                  
                  
                </tbody>
          </table>
                     <%}%>
         	<table width="100%" border="0" cellspacing="0" cellpadding="0">
         	 
       	    </table>
         	
              </div>
            </td>
              </tr>
              </table>
              </td>
              </tr>
              </table>
              </form>
            </div>
            <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
           
        %>
</body>
</html>
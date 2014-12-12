<%-- 
    Document   : product
    Created on : Mar 11, 2014, 11:19:23 PM
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
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	<link rel='stylesheet' type='text/css' href='css/styles.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.css' />
	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
	<script type='text/javascript' src='menu_jquery.js'></script>
<title>Login</title>
</head>
<body>
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
   <li class="active"><a href='login.jsp'><span>Login</span></a></li>
   <%}else{%>
         <%if(session.getAttribute("admin")!=null){ %>
        <li class="has-sub"><a href='admin.jsp'><span>Admin</span></a>
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
<form name='login' action="waitlogin.jsp" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="800" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div class="bs-example table-responsive">
          <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="center"><table width="400" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><table width="600" border="0" class="table table-striped table-hover ">
                    <tbody>
                      <tr>
                        <td width="200" valign="middle">Username</td>
                        <td width="400"><input type="text" class="form-control" name="username" placeholder="Username"></td>
                      </tr>
                      <tr>
                        <td width="200" valign="middle">Password</td>
                        <td width="400"><input type="password" class="form-control" name="password" placeholder="Password"></td>
                      </tr>
                    </tbody>
                  </table></td>
                </tr>
                <tr>
         	    <td align="right"><table width="400" border="0" cellspacing="0" cellpadding="0">
         	      <tr>
         	        <td width="100" align="right">&nbsp;</td>
         	        <td width="125" align="right"><button type="submit" class="btn btn-primary">Sign in</button></td>
         	        <td width="50" align="left">&nbsp;</td>
         	        <td width="125" align="left"><a href="signup.jsp"><button type="button" class="btn btn-primary">Sign up</button></a></td>
       	        </tr>
       	      </table>
         	      <p>&nbsp;</p>         	      </td>
       	    </tr>
              </table></td>
            </tr>
        </table>
          </div>
          </td>
          </tr>
          </table>
          </td>
          </tr>
          </table>
          </form>
          </body>
          </html>
          
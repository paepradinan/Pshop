<%-- 
    Document   : admin
    Created on : Mar 13, 2014, 12:38:13 AM
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
<title>View User</title>
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
        function grant(username){
    if(username!=null){
    <%
             try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/netprog";
                String username = "pshop";
                String password = "";
                Connection connection = DriverManager.getConnection(dbURL,username,password);
                Statement statement = connection.createStatement();
                if(session.getAttribute("username")!=null){
                String query="update user set admin='1' where iduser='"+request.getParameter("grant")+"'";
                    System.out.println(query);
                    int rowCount = statement.executeUpdate(query);
                    %>alert('Grant');<%
                }
                }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
     %> 
                 }
    
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
                ResultSet userIDResult = statement.executeQuery("SELECT * FROM user");
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
<form name='buynonmem' action="stock.html" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="800" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div class="bs-example table-responsive">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td>User</td>
            </tr>
          </table>
         	<table width="800" class="table table-striped table-hover ">
            <thead>
                  <tr>
                    <th width="43">#</th>
                    <th width="131">Username</th>
                    <th width="199">Name</th>
                    <th width="190">Email</th>
                    <th width="113">Telphone</th>
                    <th width="64">Admin</th>
                    </tr>
                </thead>
                <tbody>
                    <% while(userIDResult.next()){ %> 
                  <tr>
                    <td width="43"><%=userIDResult.getString(1)%></td>
                    <td width="131"><%=userIDResult.getString(3)%></td>
                    <td width="199"><%=userIDResult.getString(5)%></td>
                    <td width="190"><%=userIDResult.getString(2)%></td>
                    <td width="113"><%=userIDResult.getString(6)%></td>
                    <td width="64"><%if(!userIDResult.getBoolean(7)){%><a href="?grant=<%=userIDResult.getString(1)%>" onclick="grant(<%=userIDResult.getString(1)%>)">Grant</a><%}%></td>
                    </tr>
                  
                  <%}%>
                  
                  
                  
                  
                </tbody>
              </table>
         	<table width="100%" border="0" cellspacing="0" cellpadding="0">
         	  <tr>
         	    <td align="right"></td>
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
            </div>
             <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
           
        %>
</body>
</html>

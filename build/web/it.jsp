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
<title>Product - IT</title>
<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function addcart(issn,username){
    if(username!=null){
    <%if(request.getParameter("cissn")!=null&&session.getAttribute("username")!=null){
             try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/netprog";
                String username = "pshop";
                String password = "";
                Connection connection = DriverManager.getConnection(dbURL,username,password);
                Statement statement = connection.createStatement();
                if(session.getAttribute("username")!=null){
                String query="insert into cart (issn,username,cquanity,cprice,tname,tpicurl1,tpicurl2) values('"+request.getParameter("cissn")+"',"+"'"+session.getAttribute("username")+"',"+"'"+"1"+"',"+"'"+request.getParameter("price")+"',"+"'"+""+"',"+"'"+""+"',"+"'"+""+"'"+")";
                    System.out.println(query);
                    int rowCount = statement.executeUpdate(query);
                    %>//alert('Buy : ');<%
                }
                }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
     }%> 
    }else{
        alert('Login please');
        
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
                ResultSet userIDResult = statement.executeQuery("SELECT * FROM product where Category='"+"it"+"'");
        %>
<div id='cssmenu'>
<ul>
   <li ><a href='product.jsp'><span>New Product</span></a></li>
   <li class='has-sub active'><a><span>Catagory</span></a>
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
<form name='search' action="search.jsp" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="bs-example table-responsive">
          <tr>
            <td width="70%">&nbsp;</td>
            <td width="23%"><input name="search" class="form-control input-sm" type="text" id="inputSmall" placeholder="Search"></td>
            <td width="7%" align="right"><button type="submit" class="btn btn-primary btn-sm">Search</button></td>
          </tr>
        </table>
          <p>&nbsp;</p>
          <div class="bs-example table-responsive">
          <table width="800" border="0" align="center" class="table table-striped table-hover ">
          
           
                  
           <thead><tr>
           <th colspan="2"  align="center">Product</th>
           <th width="60"  align="center">Price</th>
           <th width="60"  align="center">&nbsp;</th>
                    </tr>
                  </thead>
                  
            <tbody>
                <% while(userIDResult.next()){ %> 
                  <tr> 
                    <td width="160" height="160" align="center" valign="top"><img src="<%=userIDResult.getString(3)%>" width="160"></td>
                    <th width="520" height="160" align="center"><p>ISBN : <%=userIDResult.getString(1)%></p>
                      <p><%=userIDResult.getString(2)%> </p>
                      <p><%=userIDResult.getString(5)%></p></th>
                    <th width="60" height="160" align="center" valign="middle"><p>$<%=userIDResult.getString(7)%></p></th>
          <th width="60" align="center" valign="middle"><a onclick="addcart(<%=userIDResult.getString(1)%>,<%=session.getAttribute("username")%>)" href="?cissn=<%=userIDResult.getString(1)%>&price=<%=userIDResult.getString(7)%>"  >add cart</a></th>
                
                    </tr>
                    <%} %>
                 </tbody>
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
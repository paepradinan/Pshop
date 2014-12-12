<%-- 
    Document   : cart
    Created on : Mar 12, 2014, 1:49:29 PM
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
        if(session.getAttribute("username")==null){
            response.sendRedirect("login.jsp");
        }
        %>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	<link rel='stylesheet' type='text/css' href='css/styles.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.css' />
	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
	<script type='text/javascript' src='menu_jquery.js'></script>
<title>Cart</title>
<script>
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function addquan(issn){
     <%
             try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL2 = "jdbc:mysql://localhost:3306/netprog";
                String username2 = "pshop";
                String password2 = "";
                Connection connection2 = DriverManager.getConnection(dbURL2,username2,password2);
                Statement statement2 = connection2.createStatement();
                if(request.getParameter("add")!=null){
                String query2="update cart set cquanity=cart.cquanity+1 where issn='"+request.getParameter("cissn")+"'";
                System.out.println(query2);
                int rowCount2 = statement2.executeUpdate(query2);
                String qchk="SELECT cart.cquanity,product.tprice FROM product inner join cart on cart.issn=product.issn where issn='"+request.getParameter("cissn")+"',"+"username='"+session.getAttribute("username")+"'";
                System.out.println(qchk);
                ResultSet checkprice = statement2.executeQuery("SELECT cart.cquanity,product.tprice FROM product inner join cart on cart.issn=product.issn where cart.issn='"+request.getParameter("cissn")+"' and "+"cart.username='"+session.getAttribute("username")+"'");               
                    checkprice.next();
                    System.out.println(checkprice.getString(1)+"\t"+checkprice.getString(2));
                    String queryadd="update cart set cprice='"+checkprice.getDouble(2)*checkprice.getInt(1)+"' where issn='"+request.getParameter("cissn")+"'";
                    System.out.println(queryadd);
                    int rowCountadd = statement2.executeUpdate(queryadd);
                }
                }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
     
    %>
}
function minusquan(issn){
     <%
             try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL2 = "jdbc:mysql://localhost:3306/netprog";
                String username2 = "pshop";
                String password2 = "";
                Connection connection2 = DriverManager.getConnection(dbURL2,username2,password2);
                Statement statement2 = connection2.createStatement();
                if(request.getParameter("minus")!=null){
                    ResultSet userIDResult = statement2.executeQuery("select cquanity from cart where issn='"+request.getParameter("cissn")+"'");
                    userIDResult.next();
                    if(userIDResult.getInt(1)<=1){
                        %>//alert('Your order is 0.');<%
                        String query2="delete from cart where issn='"+request.getParameter("cissn")+"'";
                        System.out.println(query2);
                        int rowCount2 = statement2.executeUpdate(query2);
                    }else{
                    String query2="update cart set cquanity=cart.cquanity-1 where issn='"+request.getParameter("cissn")+"'";
                    System.out.println(query2);
                    int rowCount2 = statement2.executeUpdate(query2);
                    }%>//alert('-');<%
                    ResultSet checkprice = statement2.executeQuery("SELECT cart.cquanity,product.tprice FROM product inner join cart on cart.issn=product.issn where cart.issn='"+request.getParameter("cissn")+"' and "+"cart.username='"+session.getAttribute("username")+"'");               
                    checkprice.next();
                    System.out.println(checkprice.getString(1)+"\t"+checkprice.getString(2));
                    String queryadd="update cart set cprice='"+checkprice.getDouble(2)*checkprice.getInt(1)+"' where issn='"+request.getParameter("cissn")+"'";
                    System.out.println(queryadd);
                    int rowCountadd = statement2.executeUpdate(queryadd);
                }
                }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
     
    %>
}
function remove(issn){
     <%
             try{
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL2 = "jdbc:mysql://localhost:3306/netprog";
                String username2 = "pshop";
                String password2 = "";
                Connection connection2 = DriverManager.getConnection(dbURL2,username2,password2);
                Statement statement2 = connection2.createStatement();
                if(request.getParameter("remove")!=null){
                String query2="delete from cart where issn='"+request.getParameter("cissn")+"'";
                System.out.println(query2);
                int rowCount2 = statement2.executeUpdate(query2);
                %>//alert('-');<%
                }
                }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
     
    %>
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
                System.out.println("SELECT COUNT(username) from cart where username='"+session.getAttribute("username")+"'");
                Statement statement = connection.createStatement();
                ResultSet counttuple = statement.executeQuery("SELECT COUNT(username) from cart where username='"+session.getAttribute("username")+"'");
                counttuple.next();
                int count=counttuple.getInt(1);
                System.out.println(counttuple.getInt(1)+"\t"+count);
                ResultSet userIDResult = statement.executeQuery("SELECT product.issn,product.Tname,product.tpicurl1,product.tdescription,cart.cquanity,product.tprice,cart.cprice FROM cart inner join product on cart.issn=product.issn where username='"+session.getAttribute("username")+"'");
                
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
   <li class="active"><a href='cart.jsp'><span>Cart</span></a></li>
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
<form name='buynonmem' action="customer.html" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="bs-example table-responsive">
          <tr>
            
              <td width="100%" align="right">
                  <%if(count>0){%>
                  <a href="checkout.jsp?status=true"><button type="button" class="btn btn-primary">Check out</button></a>
                  <%}%>
                </td>
            </tr>
        </table>
          <p>&nbsp;</p>
          <div class="bs-example table-responsive">
          <table width="800" border="0" align="center" class="table table-striped table-hover ">
          
           
                  
           <thead><tr>
           <th colspan="2"  align="center">Product</th>
           <th width="60"  align="center">Quanity</th>
           <th width="60"  align="center">Price</th>
           <th width="110"  align="center">&nbsp;</th>
                    </tr>
                  </thead>
                  
            <tbody>
                <% while(userIDResult.next()){ %> 
                  <tr> 
                    <td width="160" height="160" align="center" valign="top"><img src="<%=userIDResult.getString(3)%>" width="160"></td>
                    <th width="410" height="160" align="center"><p>ISBN : <%=userIDResult.getString(1)%></p>
                      <p><%=userIDResult.getString(2)%> </p>
                      <p><%=userIDResult.getString(4)%></p></th>
                    <th width="60" align="center" valign="middle"><%=userIDResult.getString(5)%></th>
                    <th width="60" height="160" align="center" valign="middle"><p>$<%=userIDResult.getDouble(7)
                %></p></th>
          <th width="110" align="center" valign="middle">
              <a href="?add=true&cissn=<%=userIDResult.getString(1)%>" >
                  <button type="button" onclick="addquan(<%=userIDResult.getString(1)%>)" class="btn btn-primary">+</button>
              </a> 
              <a href="?minus=true&cissn=<%=userIDResult.getString(1)%>" >
              <button  type="button" onclick="minusquan(<%=userIDResult.getString(1)%>)" class="btn btn-primary"> -</button> 
              </a>
              <a href="?remove=true&cissn=<%=userIDResult.getString(1)%>" >
              <button type="button" onclick="remove(<%=userIDResult.getString(1)%>)" class="btn btn-primary">x</button></th>
          </a>
                 <%}%>   
                    </tr>
                 
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

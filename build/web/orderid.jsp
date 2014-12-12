<%-- 
    Document   : orderid
    Created on : Mar 12, 2014, 5:40:07 PM
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
        if(session.getAttribute("username")==null||request.getParameter("sumprice")==null){
            response.sendRedirect("product.jsp");
        }
    %>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	<link rel='stylesheet' type='text/css' href='css/styles.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.css' />
	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
	<script type='text/javascript' src='menu_jquery.js'></script>
<title>Complete</title>
<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
                //System.out.println("SELECT product.tname,cart.cquanity,cart.cprice FROM cart inner join on product where cart.username='"+session.getAttribute("username")+"'");
                //ResultSet idold = statement.executeQuery("SELECT");
                String query="insert into orderid (username,FLname,fladdress,fltelphone,sumprice) values('"+session.getAttribute("username")+"',"+"'"+request.getParameter("name")+"',"+"'"+request.getParameter("address")+"',"+"'"+request.getParameter("tel")+"',"+"'"+request.getParameter("sumprice")+"'"+")";
                    System.out.println(query);
                    int rowCount = statement.executeUpdate(query);
                    //System.out.println(rowCount);
                //orderrela
                System.out.println("SELECT issn,cquanity from cart where username='"+session.getAttribute("username")+"'");
                ResultSet orderidtorela = statement.executeQuery("SELECT orderid from orderid where orderid=(select max(orderid) from orderid where username='"+session.getAttribute("username")+"')");
                orderidtorela.next();
                int temp=orderidtorela.getInt(1);
                
                ResultSet carttoorder = statement.executeQuery("SELECT issn,cquanity from cart where username='"+session.getAttribute("username")+"'");
                while(carttoorder.next()){
                    String temp1=carttoorder.getString(1);
                    String temp2=carttoorder.getString(2);
                    String queryinsert="insert into orderrela(orderid,issn,cquanity) values ('"+temp+"',"+"'"+temp1+"',"+"'"+temp2+"')";
                    System.out.println(queryinsert);
                    System.out.println(temp+"\t"+temp1+"\t"+temp2);
                    Connection connection2 = DriverManager.getConnection(dbURL,username,password);
                    Statement statement2 = connection2.createStatement();
                    int rowCount2 = statement2.executeUpdate(queryinsert);
                }
                    
                    
                
                ResultSet userIDResult = statement.executeQuery("SELECT orderid,FLName,FLAddress,FLtelphone,sumprice from orderid where orderid=(select max(orderid) from orderid where username='"+session.getAttribute("username")+"')");
                userIDResult.next();
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
        <td>
          <div class="bs-example table-responsive">
          <table width="799" border="0" align="center" class="table table-striped table-hover ">
          
           
                  
           <thead><tr>
           <th colspan="2"  align="left">Order ID : <%=userIDResult.getString(1)%></th>
           </tr>
                  </thead>
                  
            <tbody>
                  <tr> 
                    <td width="104" align="left" valign="top">Name</td>
                    <th width="685" align="center">: <%=userIDResult.getString(2)%></th>
                    </tr>
                  <tr>
                    <td align="left" valign="top">Address</td>
                    <th align="center">: <%=userIDResult.getString(3)%></th>
                    </tr>
                  <tr>
                    <td align="left" valign="top">Telphone</td>
                    <th align="center">: <%=userIDResult.getString(4)%></th>
                    </tr>
                  <tr>
                    <td align="left" valign="top">Summary Price</td>
                    <th align="center">: $<%=userIDResult.getString(5)%></th>
                    </tr>
                  <tr>
                    <td align="left" valign="top">Product Order</td>
                    <%
                    ResultSet userIDResult2 = statement.executeQuery("SELECT product.tname FROM cart inner join product on cart.issn=product.issn where cart.username='"+session.getAttribute("username")+"'");
                    int i=1;
                    %>
                    <th align="center">: 
            <%while(userIDResult2.next()){%>
            <%=i++%>. <%=userIDResult2.getString(1)%> <br>&nbsp;
            <%}%>
            </th>
                    </tr>
                 </tbody>
              </table>
          </div></td>
          </tr>
              </table>
              </td>
              </tr>
              </table>
              </form>
            </div>
            <%String delete="DELETE from CART where username='"+session.getAttribute("username")+"'";
                System.out.println(delete);
                        int del = statement.executeUpdate(delete);%>
            <% }
            catch(SQLException e){
                for(Throwable t:e)
                    t.printStackTrace();
            }
           
        %>
</body>
</html>
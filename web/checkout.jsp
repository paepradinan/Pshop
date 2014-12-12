<%-- 
    Document   : checkout
    Created on : Mar 12, 2014, 5:11:16 PM
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
        if(session.getAttribute("username")==null||request.getParameter("status")==null){
            response.sendRedirect("product.jsp");
        }
    %>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	<link rel='stylesheet' type='text/css' href='css/styles.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.css' />
	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
	<script type='text/javascript' src='menu_jquery.js'></script>
<title>Checkout</title>
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
                System.out.println("SELECT product.tname,cart.cquanity,cart.cprice FROM cart inner join on product where cart.username='"+session.getAttribute("username")+"'");
                ResultSet userIDResult = statement.executeQuery("SELECT product.tname,cart.cquanity,cart.cprice FROM cart inner join product on cart.issn=product.issn where cart.username='"+session.getAttribute("username")+"'");
                
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
<form name='confirm' action="orderid.jsp" method="post" onsubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="bs-example table-responsive">
          <tr>
            
            <td width="100%" align="right">
                
                    <button type="submit" class="btn btn-primary">Confirm</button>
                
            </td>
          </tr>
        </table>
          <p>&nbsp;</p>
          <div class="bs-example table-responsive">
          <table width="800" border="0" align="center" class="table table-striped table-hover ">
          
           
                  
           <thead><tr>
           <th colspan="2"  align="center">Product</th>
           <th width="70"  align="center">Quanity</th>
           <th width="60"  align="center">Price</th>
           <%int i=1;double sum=0.0;%>
           </tr>
                  </thead>
                  
            <tbody>
                <% while(userIDResult.next()){ %> 
                  <tr> 
                    <td width="40" align="center" valign="top"><%=i++%>.</td>
                    <th width="620" align="center"><%=userIDResult.getString(1)%></th>
                    <th width="80" align="center" valign="middle"><%=userIDResult.getString(2)%></th>
                    <th width="60"  align="center" valign="middle">$<%=userIDResult.getDouble(3)%></th>
                    <%sum+=userIDResult.getDouble(3);%>
                    </tr>
                <%}%>
                    
                    
                    <tr> 
                        <td colspan="2" align="center" valign="top"><input type="hidden" name="sumprice" value="<%=sum%>"</td>
                    <th width="80" align="right" valign="middle">Sum Price</th>
                    <th width="60"  align="center" valign="middle">$<%=sum%></th>
                    </tr>
                 </tbody>
              </table>
              
          </div>
              <p>&nbsp;</p>
              <div class="bs-example table-responsive">
          <table width="800" border="0" align="center" class="table table-striped table-hover ">
          
           
                  
           <thead>
             <tr>
           <td colspan="2" align="left" valign="top">Customer Detail</td>
                    </tr>
                  </thead>
                  
            <tbody>
                  <tr> 
                    <td width="150" valign="top">Name</td>
                    <th width="650" align="center"><input type="text" class="form-control" name="name" placeholder="Firstname Lastname" value="<%=session.getAttribute("FLName")%>"></th>
                    </tr>
                  <tr>
                    <td width="150" valign="top">Address</td>
                    <th width="650" align="center"><textarea name="address" rows="3" class="form-control"></textarea></th>
                    </tr>
                  <tr>
                    <td width="150" valign="top">Telphone</td>
                    <th width="650" align="center"><input type="text" class="form-control" name="tel" maxlength="10"></th>
                    </tr>
                 </tbody>
              </table>
          <p>&nbsp;</p>
         	
         	
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
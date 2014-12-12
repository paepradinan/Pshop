<%-- 
    Document   : signup
    Created on : Mar 12, 2014, 9:43:41 PM
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
    <%if(request.getParameter("name")!=null){%>
        <script>alert('Your username is already');</script>
    <%}%>
<script type="text/javascript">
function alert2(){
    alert('Your username is already');
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function validate(){
            var name=document.forms["signup"]["name"].value;
            var email=document.forms["signup"]["email"].value;
            var telphone=document.forms["signup"]["telphone"].value;
            var username=document.forms["signup"]["username"].value;
            var password=document.forms["signup"]["password"].value;
            var password2=document.forms["signup"]["password"].value;
            if(name===null||name===""){
             alert("Please input your name.");
             document.signup.name.focus();
             return false;
            }
            else if(email===null||email===""){
             alert("Please input your email.");
             document.signup.email.focus();
             return false;
            }
            else if(username===null||username===""){
             alert("Please input your username.");
             document.signup.username.focus();
             return false;
            }
            else if(password===null||password===""){
             alert("Please input your password.");
             document.signup.password.focus();
             return false;
            }
            else if(password2===null||password2===""){
             alert("Please input your password.");
             document.signup.password2.focus();
             return false;
            }
            else if(telphone===null|telphone===""){
             alert("Please input your telphone number."); 
             document.signup.telphone.focus();
             return false;
            }
            else if(!isDouble(telphone)){
             alert("Please input your telphone number in number."); 
             document.signup.telphone.focus();
             return false;
            }
            else if((document.forms.signup.password.value!=document.forms.signup.password2.value)){
             alert("Your password is not match.");
             document.signup.password.focus();
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
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	<link rel='stylesheet' type='text/css' href='css/styles.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.css' />
	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
	<script type='text/javascript' src='menu_jquery.js'></script>
<title>Sign up</title>
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
<form name='signup' action="waitsignup.jsp" method="post" onsubmit="return validate()">
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
                        <td width="200">Name</td>
                        <td width="400"><input type="text" class="form-control" name="name" <%if(request.getParameter("name")!=null){%> value='<%=request.getParameter("name")%>' <%}%>></td>
                      </tr>
                      <tr>
                        <td>Username</td>
                        <td><input type="text" class="form-control" name="username" maxlength="10" ></td>
                      </tr>
                      <tr>
                        <td>Password</td>
                        <td><input type="password" class="form-control" name="password" maxlength="10"></td>
                      </tr>
                      <tr>
                        <td>Confirm Password</td>
                        <td><input type="password" class="form-control" name="password2" maxlength="10"></td>
                      </tr>
                      <tr>
                        <td>Email</td>
                        <td><input type="text" class="form-control" name="email" <%if(request.getParameter("email")!=null){%> value='<%=request.getParameter("email")%>' <%}%>></td>
                      </tr>
                      <tr>
                        <td>Telphone</td>
                        <td><input type="text" class="form-control" name="telphone" maxlength="10" <%if(request.getParameter("telphone")!=null){%> value='<%=request.getParameter("telphone")%>' <%}%>></td>
                      </tr>
                    </tbody>
                  </table></td>
                </tr>
                <tr>
         	    <td align="right"><table width="400" border="0" cellspacing="0" cellpadding="0">
         	      <tr>
         	        <td width="100" align="right">&nbsp;</td>
         	        <td width="125" align="right"><button type="submit" class="btn btn-primary">Sign up</button></td>
         	        <td width="50" align="left">&nbsp;</td>
         	        <td width="125" align="left"><a href="signup.jsp"><button type="button" class="btn btn-primary">Reset</button></a></td>
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
          

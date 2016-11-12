<%@page import="java.lang.String"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>jQuery, Ajax and Servlet/JSP integration example</title>

        <script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
        
    </head>
    <body>

        <form>
            Enter Your Name: <select id="userName" >
                <option selected="selected">Test</option>
                <option>University of Dhaka</option>
                <option>Red</option>
            </select>
        </form>
        <br>
        <br>

        <strong>Ajax Response</strong>
         <script>
//             $(document).ready(
//                     $("#userName").val;
//                     );
             //String value=$("#userName").val;
             //System.out.println(value);
           $(document).ready(function () {
                $('#userName').change(function () {
                    $.ajax({
                        url: 'GetUserServlet',
                        data: {
                            userName: $('#userName').val()
                        },
                        success: function (data) {
//				$('#ajaxGetUserServletResponse').text(responseText);
                            console.log(data);
                        }
                    });
                });
            });
        </script>
       <!-- <div id="ajaxGetUserServletResponse"></div>-->
        <%
//            String value = request.getParameter("userName");
//            System.out.println(value);
            String name = (String) request.getAttribute("text");
            String myVal;
            if(name!=null){
            myVal = name;
            System.out.println(myVal);
            }
            
        %>
        
    </body>
</html>
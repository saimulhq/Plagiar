
<%@page import="com.plagiar.entities.Users"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="com.plagiar.PlagiarRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <link rel="shortcut icon" href="favicon.ico" />
        <style>
            #contentBody, .container-fluid {
                /*height:523px;*/
                overflow-y:auto;
                height:77%;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <jsp:include page="navigation.jsp"/>

        <div class="container-fluid">
            <div class="row" id="contentRow">
                <jsp:include page="menu.jsp"/>
                <div class="col-md-10 col-sm-10" id="contentBody">


                    <div class="panel-default">
                        <div class="panel-body">
                            <div class="panel panel-default" style="background-color: ghostwhite;">
                                <div class="container-fluid">
                            <%
                                PlagiarRemote plagiarRemote = null;

                                try {
                                    Context context = new InitialContext();
                                    plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                                    //List<MenuItd> listx = itdr.getMenuByUsername(name);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                String inputPassword = request.getParameter("inputPassword");
                                String hashInputPassword = plagiarRemote.generateHashPassword(inputPassword);

                                String username = request.getUserPrincipal().getName();

                                Users users = plagiarRemote.getUserPassword(username);

                                String userPassword = users.getPassword();

                                if (userPassword.equals(hashInputPassword)) {
                            %>
                            <h3>Update Password</h3>
                            <form action="updatePassword3.jsp" method="post">
                                Enter new password: <input type="password" name="newPassword" class="form-control" style="width:300px;"><br>
                                <button type="submit" class="btn btn-default">Submit</button><br><br>
                            </form>
                            <%
                            } else {
                            %><h3>Incorrect Password!</h3><br/><br/>
                            <a href="updatePassword.jsp">Please try again...</a><br><br><%
                                }
                            %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="footer.jsp"/>
    </body>
</html>

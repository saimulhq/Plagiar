
<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="javascripts/paging.js"></script>
        <link rel="shortcut icon" href="favicon.ico" />
        <style>
            .pg-normal {
                color: #23527c;
                font-weight: normal;
                text-decoration: none;    
                cursor: pointer;    
            }
            .pg-selected {
                color: #E3106D;
                font-weight: bold;        
                text-decoration: underline;
                cursor: pointer;
            }
            .pg-normal:hover{
                background-color:#23527c;
                color: white;
            }
            
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
                            <h3>User Accounts</h3>
                            <%
                                PlagiarRemote plagiarRemote = null;

                                try {
                                    Context context = new InitialContext();
                                    plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                List<Users> listAllUsers = plagiarRemote.getUserList();

                            %>
                            <table class="table table-bordered" id="users">
                                <thead>
                                <th>Username</th><th>Role</th><th></th>
                                </thead>
                                <tbody>
                                    <%                for (Users users : listAllUsers) {
                                            if (users.getRole().equals("admin")) {
                                                continue;
                                            }
                                    %><tr><td><%=users.getUsername()%></td><td><%=users.getRole()%></td><td><a href="deleteAccount.jsp?username=<%=users.getUsername()%>&role=<%=users.getRole()%>" style="text-decoration: none;color:red;">Delete Account</a></td></tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                                <div id="pageNavPosition" align="center"></div><br>
                            <script type="text/javascript">
                                var pager = new Pager('users', 9);
                                pager.init();
                                pager.showPageNav('pager', 'pageNavPosition');
                                pager.showPage(1);
                            </script>
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


<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="com.plagiar.entities.Menu" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

            } catch (Exception e) {
                e.printStackTrace();
            }
            String username = request.getUserPrincipal().getName();
            //List<Menu> listMenu = plagiarRemote.getMenuByUsername(username);
            Users users = plagiarRemote.getUserRole(username);

            String role = users.getRole();

            if (role.equals("student")) {
        %>
        <div class="col-md-2 col-sm-2" id="menu">       
            <ul class="nav nav-stacked">
                <li><a href="home.jsp" style="color:#23527c; border-top:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Home</b></a></li>
                <li><a href="addFile.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Add File</b></a></li>
                <li><a href="view.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>View/Search</b></a></li>
                <li><a href="checkPlagiarism.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Check Plagiarism</b></a></li>
                <li><a href="updatePassword.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Update Password</b></a></li>
            </ul>
        </div>
        <% } else if (role.equals("teacher")) {
        %>
        <div class="col-md-2 col-sm-2" id="menu">       
            <ul class="nav nav-stacked">
                <li><a href="home.jsp" style="color:#23527c; border-top:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Home</b></a></li>
                <li><a data-toggle="collapse" href="#collapseFour" style="color:#23527c; border:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Create New</b></a></li>
                <div id="collapseFour" class="panel-collapse collapse">
                    <li><a href="createNewUni.jsp" class="list-group-item" style="background-color: gainsboro; border:0px; color:#23527c; padding-left:15%;" onMouseOver="this.style.color = 'blue';this.style.backgroundColor = '#EEEEEE';" onMouseOut="this.style.color = '#23527c';this.style.backgroundColor = 'gainsboro';"><b>University</b></a></li>
                    <li><a href="createNewDept.jsp" class="list-group-item" style="background-color: gainsboro; border:0px; color:#23527c; padding-left:15%;" onMouseOver="this.style.color = 'blue';this.style.backgroundColor = '#EEEEEE';" onMouseOut="this.style.color = '#23527c';this.style.backgroundColor = 'gainsboro';"><b>Department</b></a></li>
                    <li><a href="createCategory.jsp" class="list-group-item" style="background-color: gainsboro; border:0px; color:#23527c; padding-left:15%;" onMouseOver="this.style.color = 'blue';this.style.backgroundColor = '#EEEEEE';" onMouseOut="this.style.color = '#23527c';this.style.backgroundColor = 'gainsboro';"><b>Category</b></a></li>
                </div>
                <li><a href="addFile.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Add File</b></a></li>
                <li><a href="view.jsp" style="color:#23527c; border-top:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>View/Search</b></a></li>
                <li><a href="checkPlagiarism.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Check Plagiarism</b></a></li>
                <li><a href="showCheckingHistory.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Show Checking History</b></a></li>
                <li><a href="showSubmissions.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Show Submissions</b></a></li>
                <li><a href="updatePassword.jsp" style="color:#23527c; border:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Update Password</b></a></li>
            </ul>
        </div>
        <%
        } else {
        %>
        <div class="col-md-2 col-sm-2" id="menu">       
            <ul class="nav nav-stacked">
                <li><a href="home.jsp" style="color:#23527c; border-top:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Home</b></a></li>
                <li><a href="createAccount.jsp" style="color:#23527c; border-top:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>Create Account</b></a></li>
                <li><a href="accountDetails.jsp" style="color:#23527c; border-top:0px;margin:0px;" onMouseOver="this.style.color = 'blue'" onMouseOut="this.style.color = '#23527c'"><b>User Accounts</b></a></li>
            </ul>
        </div>
        <%
            }

        %>



    </body>
</html>

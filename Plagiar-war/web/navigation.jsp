<%@ page import="com.plagiar.entities.TeacherInfo" %>
<%@ page import="com.plagiar.entities.StudentInfo" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<html lang="en">
    <head>
        <link href="styles/template.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
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
            String name = null;
            
            Users users = plagiarRemote.getUserRole(username);
            
            String role = users.getRole();
            //System.out.println(role);
            
            if (role.equals("student")) {
                StudentInfo studentInfo = plagiarRemote.getStudentInfo(username);
                name = studentInfo.getName();
                //System.out.println(name);
            } else if (role.equals("teacher")) {
                TeacherInfo teacherInfo = plagiarRemote.getTeacherInfo(username);
                name = teacherInfo.getName();
                //System.out.println();
            } else {
                name = "Admin";
            }

        %>
        <nav class="navbar navbar-default" id="navigation">
            <ul class="nav navbar-nav navbar-left">
                <li id="navUsername"><a href="#" style="color: white; font-weight: bold;"><span class="glyphicon glyphicon-user"></span> User: <%=name%></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li id="navLogout"><a href="Logout" style="color: white; font-weight: bold;" onMouseOver="this.style.color='red';this.style.backgroundColor='gainsboro';" onMouseOut="this.style.color='white';this.style.backgroundColor='#23527c';"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
            </ul>
        </nav>

    </body>
</html>
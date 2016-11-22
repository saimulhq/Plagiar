<%@ page import="com.plagiar.entities.Groups" %>
<%@ page import="com.plagiar.entities.TeacherInfo" %>
<%@ page import="com.plagiar.entities.StudentInfo" %>
<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <style>
            #contentBody, .container-fluid {
                /*height:523px;*/
                overflow-y:auto;
                height:77%;
            }
        </style>
    </head>
    <body>
        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                //List<MenuItd> listx = itdr.getMenuByUsername(name);
            } catch (Exception e) {
                e.printStackTrace();
            }

            Users users = new Users();
            Groups groups = new Groups();
            StudentInfo studentInfo = new StudentInfo();
            TeacherInfo teacherInfo = new TeacherInfo();

            String t_username = request.getParameter("t_username");
            String t_password = request.getParameter("t_password");
            String s_username = request.getParameter("s_username");
            String s_password = request.getParameter("s_password");
            String designation = request.getParameter("designation");
            String t_dept = request.getParameter("t_dept");
            String t_university = request.getParameter("t_university");
            String t_name = request.getParameter("t_name");
            String s_name = request.getParameter("s_name");
            String b_name = request.getParameter("b_name");
            String b_number = request.getParameter("b_number");
            String roll = request.getParameter("roll");
            String s_dept = request.getParameter("s_dept");
            String s_university = request.getParameter("s_university");
            
            if (t_username != null && t_password != null) {
                users.setUsername(t_username);
                String hashTPassword = plagiarRemote.generateHashPassword(t_password);
                users.setPassword(hashTPassword);
                groups.setUsername(t_username);
                groups.setRole("teacher");
                users.setRole("teacher");
                teacherInfo.setUsername(t_username);
                teacherInfo.setDesignation(designation);
                teacherInfo.setDepartment(t_dept);
                teacherInfo.setUniversity(t_university);
                teacherInfo.setName(t_name);
                
                plagiarRemote.addTeacherAccountInDatabase(users, groups, teacherInfo);
            }
            
            else if (s_username != null && s_password != null) {
                users.setUsername(s_username);
                String hashSPassword = plagiarRemote.generateHashPassword(s_password);
                users.setPassword(hashSPassword);
                groups.setUsername(s_username);
                groups.setRole("student");
                users.setRole("student");
                studentInfo.setUsername(s_username);
                studentInfo.setName(s_name);
                studentInfo.setRollNumber(roll);
                studentInfo.setBatchName(b_name);
                studentInfo.setBatchNumber(b_number);
                studentInfo.setDepartment(s_dept);
                studentInfo.setUniversity(s_university);
                
                plagiarRemote.addStudentAccountInDatabase(users, groups, studentInfo);
            }
            //System.out.println(s_username);
            //System.out.println(s_password);
            //users.setUsername(s_username);
            //users.setPassword(s_password);
            
        %>
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
                        <h3>Account Created!</h3>
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

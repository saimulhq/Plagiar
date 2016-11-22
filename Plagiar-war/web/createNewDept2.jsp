
<%@ page import="java.util.List" %>
<%@ page import="com.plagiar.entities.Department" %>
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

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        String uniName = request.getParameter("university");
                        String deptName = request.getParameter("department");

                        List<Department> listAllDept = plagiarRemote.getDepartmentList();
                        int flag = 0;
                        for (Department dept : listAllDept) {
                            if (dept.getDepartmentName().equals(deptName) && dept.getUniversityName().equals(uniName)) {
                    %><h3>Department Already Exists!!!</h3> <br/><br/>
                    <a href="createNewDept.jsp">Try Again...</a><br/><br/>
                    <%
                                flag = 1;
                            }
                        }
                        System.out.println(flag);
                        if (flag == 0) {
                            Department department = new Department();
                            department.setUniversityName(uniName);
                            department.setDepartmentName(deptName);

                            plagiarRemote.addDepartmentInDatabase(department);
                    %><h3>Department Added!</h3><%
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

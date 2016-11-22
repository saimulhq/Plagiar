
<%@ page import="com.plagiar.entities.Department" %>
<%@ page import="java.util.List" %>
<%@ page import="com.plagiar.entities.Category" %>
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
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
                
            } catch (Exception e) {
                e.printStackTrace();
            }

            String university = request.getParameter("university");

            List<Department> listDepartmentByUniname = plagiarRemote.getDepartmentListByUniversity(university);

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
                        <h3>New Category</h3>
                        <form action="createCategory3.jsp?uni=<%=university%>" method="post">
                            Selected University: <input type="text" class="form-control" style="width:300px;" value="<%=university%>" disabled="disabled"><br/>
                            Select Department: <select id="department" name="department" class="form-control" style="width:300px;">
                                    <option selected="selected">Please select ...</option>
                                    <%
                                        for (Department department : listDepartmentByUniname) {
                                    %><option><%=department.getDepartmentName()%></option><%
                                        }
                                    %>
                                </select><br/>
                                
                                Category Name: <input name="category" type="text" class="form-control" style="width:300px;"><br/>
                                <button type="submit" class="btn btn-default">Create</button><br><br>
                        </form>
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

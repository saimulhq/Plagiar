
<%@page import="com.plagiar.entities.TeacherInfo"%>
<%@page import="com.plagiar.entities.Category"%>
<%@page import="java.util.List"%>
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
        <link rel="shortcut icon" href="favicon.ico" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <jsp:include page="navigation.jsp"/>

        <div class="container-fluid">
            <div class="row" id="contentRow">
                <jsp:include page="menu.jsp"/>
                <div class="col-md-10 col-sm-10" id="contentBody">
                    <%
                        PlagiarRemote plagiarRemote = null;

                        try {
                            Context context = new InitialContext();
                            plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        String university=request.getParameter("uni");
                        String dept = request.getParameter("dept");
                        String category = request.getParameter("category");
                        String catType= request.getParameter("catType");
                        String teacher = request.getParameter("teacher");
                        System.out.println(dept);
                        List<TeacherInfo> listTeachers = plagiarRemote.getTeacherListByUniversityAndDepartment(university, dept);
                        
                    %>

                    <div class="panel-default">
                        <div class="panel-body">
                            <h3>Add File</h3>
                            <form action="addFile7.jsp?uni=<%=university%>&dept=<%=dept%>&category=<%=category%>&catType=<%=catType%>&teacher=<%=teacher%>" method="post" enctype="multipart/form-data">
                            Selected Submission Type: <input type="text" disabled="disabled" value="<%=catType%>" class="form-control" style="width:300px;"><br/>
                            Selected University: <input type="text" disabled="disabled" value="<%=university%>" class="form-control" style="width:300px;"><br/>
                            Selected Department: <input type="text" disabled="disabled" value="<%=dept%>" class="form-control" style="width:300px;"><br/>
                            Selected Category: <input type="text" disabled="disabled" value="<%=category%>" class="form-control" style="width:300px;"><br/>
                            Selected Teacher: <input type="text" disabled="disabled" value="<%=teacher%>" class="form-control" style="width:300px;"><br/>
                            Title: <input type="text" name="title" class="form-control" style="width: 300px;"/><br/>
                            Author: <input type="text" name="author" class="form-control" style="width: 300px;"/><br/>
                            Published year: <input name="year" type="text" class="form-control" style="width:300px;"><br/>
                            Upload File: <input type="file" name="file" accept=".pdf" class="form-control" style="width:300px;"><br/>
                             <a class="btn btn-default" href="checkPlagiarism.jsp">Back</a> <button type="submit" class="btn btn-default">Add</button>
                        </form>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

<%@ page import="org.apache.tika.Tika" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <jsp:include page="navigation.jsp"/>
        <div class="container-fluid">
            <div class="row" id="contentRow">
                <jsp:include page="menu.jsp"/>
                <div class="col-md-10 col-sm-10" id="contentBody">


                    <div class="panel-default">
                        <h3>Check Plagiarism</h3>
                        <%
                            String uni = request.getParameter("uni");
                            String dept = request.getParameter("dept");
                            String  category = request.getParameter("category");
                        %>
                        <form action="checkPlagiarism5.jsp?uni=<%=uni%>&dept=<%=dept%>&category=<%=category%>" method="post" enctype="multipart/form-data">
                        Selected University: <input type="text" disabled="disabled" value="<%=uni%>" class="form-control" style="width:300px;"><br/>
                        Selected Department: <input type="text" disabled="disabled" value="<%=dept%>" class="form-control" style="width:300px;"><br/>
                        Selected Category: <input type="text" disabled="disabled" value="<%=category%>" class="form-control" style="width:300px;"><br/>
                        Title: <input name="title" type="text" class="form-control" style="width:300px;"><br/>
                        Author: <input name="author" type="text" class="form-control" style="width:300px;"><br/>
                        University: <input name="inputUni" type="text" class="form-control" style="width:300px;"><br/>
                        Department: <input name="inputDept" type="text" class="form-control" style="width:300px;"><br/>
                        Year: <input name="year" type="text" class="form-control" style="width:300px;"><br/>
                        Upload File: <input type="file" name="file" accept=".pdf" class="form-control" style="width:300px;"><br/>
                        <a class="btn btn-default" href="checkPlagiarism3.jsp">Back</a> <button type="submit" class="btn btn-default">Check</button> 
                        </form>
                        <div class="panel-body">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

    </body>
</html>
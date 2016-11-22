<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="com.plagiar.entities.Category" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="com.plagiar.entities.FilesPlagiar" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

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
        <script>
            function validate(){
            var x = document.forms["addFile"]["category"].value;
            if (x === "") {
                    alert("You must select the category!");
                    return false;
                }
            }
        </script>
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
                    <%
                        PlagiarRemote plagiarRemote = null;

                        try {
                            Context context = new InitialContext();
                            plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        String username = request.getUserPrincipal().getName();
                        Users users = plagiarRemote.getUserRole(username);

                        String role = users.getRole();
                        String university = request.getParameter("uni");
                        String catType = request.getParameter("catType");
                        String dept = request.getParameter("department");
                        List<Category> listCategory = plagiarRemote.getCategoryListByUniversityAndDepartment(university, dept);
                    %>

                    <div class="panel-default">
                        <div class="panel-body">
                            <div class="panel panel-default" style="background-color: ghostwhite;">
                                <div class="container-fluid">
                                    <h3>Add File</h3>
                                    <%if (role.equals("student")) {%>
                                    <form name="addFile" action="addFile5.jsp?uni=<%=university%>&dept=<%=dept%>&catType=<%=catType%>" method="post">
                                        <%} else {%>
                                        <form action="addFile6.jsp?uni=<%=university%>&dept=<%=dept%>&catType=<%=catType%>" method="post">
                                            <%}%>
                                            <form>
                                                Selected Submission Type: <input type="text" disabled="disabled" value="<%=catType%>" class="form-control" style="width:300px;"><br/>
                                                Selected University: <input type="text" disabled="disabled" value="<%=university%>" class="form-control" style="width:300px;"><br/>
                                                Selected Department: <input type="text" disabled="disabled" value="<%=dept%>" class="form-control" style="width:300px;"><br/>
                                                Select Category: <select name="category" class="form-control" style="width:300px;">
                                                    <option value="">Please select ...</option>
                                                    <%
                                                        for (Category cat : listCategory) {
                                                    %><option value="<%=cat.getCategory()%>"><%=cat.getCategory()%></option><%
                                                        }
                                                    %>
                                                </select><br/>
                                                <a class="btn btn-default" href="addFile3.jsp?university=<%=university%>&catType=<%=catType%>">Back</a> <button type="submit" class="btn btn-default" onclick="return validate();">Next</button><br><br>
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

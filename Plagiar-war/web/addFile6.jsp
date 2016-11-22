
<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="com.plagiar.entities.TeacherInfo" %>
<%@ page import="com.plagiar.entities.Category" %>
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
        <link rel="shortcut icon" href="favicon.ico" />
        <script>
            function validate() {
                var x = document.forms["addFile"]["title"].value;
                var y = document.forms["addFile"]["author"].value;
                var z = document.forms["addFile"]["year"].value;
                var w = document.forms["addFile"]["file"].value;
                if (x === "" && y === "" && z === "" && w === "") {
                    alert("You must fillup all the fields!");
                    return false;
                }
                if (x === "") {
                    alert("You must enter the title!");
                    return false;
                }
                if (y === "") {
                    alert("You must enter the author name!");
                    return false;
                }
                if (z === "") {
                    alert("You must enter the year!");
                    return false;
                }
                if (w === "") {
                    alert("You must upload a file!");
                    return false;
                }
            }
        </script>
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
                        String university = request.getParameter("uni");
                        String dept = request.getParameter("dept");
                        String category = request.getParameter("category");
                        String catType = request.getParameter("catType");
                        String teacher = request.getParameter("teacher");
                        System.out.println(dept);
                        List<TeacherInfo> listTeachers = plagiarRemote.getTeacherListByUniversityAndDepartment(university, dept);
                        String username = request.getUserPrincipal().getName();
                        Users users = plagiarRemote.getUserRole(username);

                        String role = users.getRole();
                    %>

                    <div class="panel-default">
                        <div class="panel-body">
                            <div class="panel panel-default" style="background-color: ghostwhite;padding-bottom: 2%;">
                                <div class="container-fluid">
                                    <h3>Add File</h3>
                                    <form name="addFile" action="addFile7.jsp?uni=<%=university%>&dept=<%=dept%>&category=<%=category%>&catType=<%=catType%>&teacher=<%=teacher%>" method="post" enctype="multipart/form-data" onSubmit="return validate();">
                                        Selected Submission Type: <input type="text" disabled="disabled" value="<%=catType%>" class="form-control" style="width:300px;"><br/>
                                        Selected University: <input type="text" disabled="disabled" value="<%=university%>" class="form-control" style="width:300px;"><br/>
                                        Selected Department: <input type="text" disabled="disabled" value="<%=dept%>" class="form-control" style="width:300px;"><br/>
                                        Selected Category: <input type="text" disabled="disabled" value="<%=category%>" class="form-control" style="width:300px;"><br/>
                                        <%if (role.equals("student")) {%>
                                        Selected Teacher: <input type="text" disabled="disabled" value="<%=teacher%>" class="form-control" style="width:300px;"><br/>
                                        <%}%>
                                        Title: <input type="text" name="title" class="form-control" style="width: 300px;"/><br/>
                                        Author: <input type="text" name="author" class="form-control" style="width: 300px;"/><br/>
                                        Year: <input name="year" type="text" class="form-control" style="width:300px;"><br/>
                                        Upload File: <input type="file" name="file" accept=".pdf" class="form-control" style="width:300px;"><br/>
                                        <%if (role.equals("student")) {%>
                                        <a class="btn btn-default" href="addFile5.jsp?uni=<%=university%>&dept=<%=dept%>&category=<%=category%>&catType=<%=catType%>">Back</a> <button type="submit" class="btn btn-default">Add</button>
                                        <%} else {%>
                                        <a class="btn btn-default" href="addFile4.jsp?uni=<%=university%>&department=<%=dept%>&catType=<%=catType%>">Back</a> 
                                        <button type="submit" class="btn btn-default">Add</button>
                                        <%}%>
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

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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script>
            function validate(){
            var x = document.forms["check"]["title"].value;
            var y = document.forms["check"]["author"].value;
            var z = document.forms["check"]["inputUni"].value;
            var q = document.forms["check"]["inputDept"].value;
            var w = document.forms["check"]["year"].value;
            var e = document.forms["check"]["limit"].value;
            var r = document.forms["check"]["file"].value;
            if (x === "" && y === "" && z === "" && q === "" && w === "" && e === "" && r === "") {
                    alert("You must enter all the fields!");
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
                    alert("You must enter the university name!");
                    return false;
                }
            if (q === "") {
                    alert("You must enter the department name!");
                    return false;
                }
            if(w === ""){
                alert("You must enter the year!");
                    return false;
            }
            if(e === ""){
                alert("You must enter the limit!");
                    return false;
            }
            if(r === ""){
                alert("You must upload a flie!");
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


                    <div class="panel-default">
                        <%
                            String uni = request.getParameter("uni");
                            String dept = request.getParameter("dept");
                            String  category = request.getParameter("category");
                            String catType=request.getParameter("catType");
                        %>
                        
                        <div class="panel-body">
                            <div class="panel panel-default" style="background-color: ghostwhite;padding-bottom:2%;">
                            <div class="container-fluid">
                                <h3>Check Plagiarism</h3>
                        <form name="check" action="checkPlagiarism6.jsp?uni=<%=uni%>&dept=<%=dept%>&category=<%=category%>&catType=<%=catType%>" method="post" enctype="multipart/form-data">
                        Selected Category: <input type="text" disabled="disabled" value="<%=catType%>" class="form-control" style="width:300px;"><br/>
                        Selected University: <input type="text" disabled="disabled" value="<%=uni%>" class="form-control" style="width:300px;"><br/>
                        Selected Department: <input type="text" disabled="disabled" value="<%=dept%>" class="form-control" style="width:300px;"><br/>
                        Selected Category: <input type="text" disabled="disabled" value="<%=category%>" class="form-control" style="width:300px;"><br/>
                        Title: <input name="title" type="text" class="form-control" style="width:300px;"><br/>
                        Author: <input name="author" type="text" class="form-control" style="width:300px;"><br/>
                        University: <input name="inputUni" type="text" class="form-control" style="width:300px;"><br/>
                        Department: <input name="inputDept" type="text" class="form-control" style="width:300px;"><br/>
                        Year: <input name="year" id="year" type="text" class="form-control" style="width:300px;"><br/>
                        Limit(%): <input name="limit" type="number" class="form-control" class="form-control" style="width:300px;"><br/>
                        Upload File: <input type="file" name="file" accept=".pdf" class="form-control" style="width:300px;"><br/>
                        <a class="btn btn-default" href="checkPlagiarism4.jsp?uni=<%=uni%>&department=<%=dept%>&catType=<%=catType%>">Back</a> <button type="submit" class="btn btn-default" onclick="return validate();">Check</button> 
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
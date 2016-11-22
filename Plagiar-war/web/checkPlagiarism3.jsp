

<%@ page import="com.plagiar.entities.Department" %>
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="com.plagiar.entities.FilesPlagiar" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
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
        <style>
            #contentBody, .container-fluid {
                /*height:523px;*/
                overflow-y:auto;
                height:77%;
            }
        </style>
        <script>
            function validate(){
            var x = document.forms["check"]["department"].value;
            if (x === "") {
                    alert("You must select the department!");
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
                                
                                String catType=request.getParameter("catType");
                                String university = request.getParameter("university");
                                //System.out.println(title+author+catType+university);
                                List<Department> listDepartmentByUniname = plagiarRemote.getDepartmentListByUniversity(university);
                            %>
                            <h3>Check Plagiarism</h3>
                            <form name="check" action="checkPlagiarism4.jsp?uni=<%=university%>&catType=<%=catType%>" method="post">
                                Selected Category: <input type="text" disabled="disabled" value="<%=catType%>" class="form-control" style="width:300px;"><br/>
                                Selected University: <input type="text" disabled="disabled" value="<%=university%>" class="form-control" style="width:300px;"><br/>
                                Select Department: <select name="department" class="form-control" style="width:300px;">
                                    <option value="">Please select ...</option>
                                    <%
                                        for (Department department : listDepartmentByUniname) {
                                    %><option value="<%=department.getDepartmentName()%>"><%=department.getDepartmentName()%></option><%
                                        }
                                    %>
                                </select><br/>

                                <a class="btn btn-default" href="checkPlagiarism2.jsp?categoryType=<%=catType%>">Back</a> <button type="submit" class="btn btn-default" onclick="return validate();">Next</button><br><br> 
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

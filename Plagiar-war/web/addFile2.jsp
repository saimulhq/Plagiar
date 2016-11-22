

<%@ page import="com.plagiar.entities.University" %>
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
        <script>
            function validate(){
            var x = document.forms["addFile"]["university"].value;
            if (x === "") {
                    alert("You must select the university!");
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

                                        String catType = request.getParameter("categoryType");
                                        //System.out.println(title+author+catType+university);
                                        List<University> listAllUniversity = plagiarRemote.getUniversityList();

                                    %>
                                    <h3>Add File</h3>
                                    <form name="addFile" action="addFile3.jsp?catType=<%=catType%>" method="post">
                                        Selected Submission Type: <input type="text" disabled="disabled" value="<%=catType%>" class="form-control" style="width:300px;"><br/>
                                        Select University: <select name="university" class="form-control" style="width:300px;">
                                            <option value="">Please select ...</option>
                                            <% for (University university : listAllUniversity) {
                                            %><option value="<%=university.getUniversityName()%>"><%=university.getUniversityName()%></option><%
                                                }
                                            %>
                                        </select><br/>

                                        <a class="btn btn-default" href="addFile.jsp">Back</a> <button type="submit" class="btn btn-default" onclick="return validate();">Next</button><br><br>
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

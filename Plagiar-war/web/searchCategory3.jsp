<%@page import="java.util.List"%>
<%@ page import="com.plagiar.entities.Category" %>
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
        <style>
            #contentBody, .container-fluid {
                /*height:523px;*/
                overflow-y:auto;
                height:77%;
            }
        </style>
        <script>
            function validate(){
            var x = document.forms["searchCategory"]["category"].value;
            if (x === "") {
                    alert("You must select the category!");
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
                        String dept = request.getParameter("department");

                        List<Category> listCategory = plagiarRemote.getCategoryListByUniversityAndDepartment(university, dept);
                    %>

                    <div class="panel-default">
                        <div class="panel-body">
                            <div class="panel panel-default" style="background-color: ghostwhite;">
                                <div class="container-fluid">
                                    <h3>Search</h3>
                                    <form name="searchCategory" action="searchCategory4.jsp?uni=<%=university%>&dept=<%=dept%>" method="post">
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
                                        <a class="btn btn-default" href="searchCategory2.jsp?university=<%=university%>">Back</a> <button type="submit" class="btn btn-default" onclick="return validate();">Search</button><br><br>
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

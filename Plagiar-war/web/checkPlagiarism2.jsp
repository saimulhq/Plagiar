
<%@page import="com.plagiar.entities.University"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="com.plagiar.PlagiarRemote"%>
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
        <script>
            function validate(){
            var x = document.forms["check"]["university"].value;
            if (x === "") {
                    alert("You must select the university!");
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
                            <h3>Check Plagiarism</h3>
                            <%
                                PlagiarRemote plagiarRemote = null;

                                try {
                                    Context context = new InitialContext();
                                    plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                List<University> listAllUniversity = plagiarRemote.getUniversityList();

                                String categoryType = request.getParameter("categoryType");
                                //System.out.println("category name: "+category);

                            %>
                            <form name="check" action="checkPlagiarism3.jsp?catType=<%=categoryType%>" method="post">
                                <!--Select category type: <select name="categoryType" class="form-control" style="width: 300px;">
                                    <option selected="selected">Please select ...</option>
                                    <option>Assignment</option>
                                    <option>Project</option>
                                    <option>Thesis</option>
                                </select><br/>-->
                                Selected Category: <input type="text" disabled="disabled" value="<%=categoryType%>" class="form-control" style="width:300px;"><br/>
                                Select University: <select name="university" class="form-control" style="width:300px;">
                                    <option value="">Please select ...</option>
                                    <%                                        for (University university : listAllUniversity) {
                                    %><option value="<%=university.getUniversityName()%>"><%=university.getUniversityName()%></option><%
                                        }
                                    %>
                                </select><br/>

                                <!--<input type="file" name="file" accept=".pdf" multiple="multiple"/>
                                <br />-->
                                <a class="btn btn-default" href="checkPlagiarism.jsp">Back</a> <button type="submit" class="btn btn-default" onclick="return validate();">Next</button><br><br>
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

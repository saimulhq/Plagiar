
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
                        System.out.println(university);
                        String dept = request.getParameter("department");
//                        String title =request.getParameter("title");
//                        String author = request.getParameter("author");
//                        String catType= request.getParameter("catType");
//                        System.out.println(dept);
                        List<Category> listCategory = plagiarRemote.getCategoryListByUniversityAndDepartment(university, dept);
                        
                    %>

                    <div class="panel-default">
                        <div class="panel-body">
                            <h3>Check Plagiarism</h3>
                            <form action="checkPlagiarism4.jsp?uni=<%=university%>&dept=<%=dept%>" method="post">
                                Selected University: <input type="text" disabled="disabled" value="<%=university%>" class="form-control" style="width:300px;"><br/>
                                Selected Department: <input type="text" disabled="disabled" value="<%=dept%>" class="form-control" style="width:300px;"><br/>
                                Select Category: <select name="category" class="form-control" style="width:300px;">
                                    <option selected="selected">Please select ...</option>
                                    <%
                                        for (Category cat : listCategory) {
                                    %><option><%=cat.getCategory()%></option><%
                                        }
                                    %>
                                </select><br/>
                                <a class="btn btn-default" href="checkPlagiarism2.jsp">Back</a> <button type="submit" class="btn btn-default">Next</button> 
                        </form>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

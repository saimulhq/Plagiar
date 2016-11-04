
<%@ page import="com.plagiar.entities.DirectoryPlagiar" %>
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
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

            } catch (Exception e) {
                e.printStackTrace();
            }
            List<DirectoryPlagiar> listAllCategory = plagiarRemote.getDirectoryList();
        %>
        <jsp:include page="header.jsp"/>
        
        <jsp:include page="navigation.jsp"/>
        <div class="container-fluid">
            <div class="row" id="contentRow"s>
                <jsp:include page="menu.jsp"/>
                <div class="col-md-10 col-sm-10" id="contentBody">


                    <div class="panel-default">
                        <div class="panel-body">
                            <h3>Check Plagiarism</h3>
                            <br/>
                            <form action="checkPlagiarism2.jsp" method="post" enctype="multipart/form-data">
                                Select a category: <select name="category" class="form-control" style="width:300px;">
                                    <option selected="selected">Please select ...</option>
                                    <%
                                        for (DirectoryPlagiar category : listAllCategory) {
                                    %><option><%=category.getCategory()%></option><%
                                        }
                                    %>
                                </select>
                                <br/>
                                Upload file:<input type="file" name="file" class="form-control" style="width:300px;" accept=".pdf" />
                                <br />
                                <button type="submit" class="btn btn-default">Upload File</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

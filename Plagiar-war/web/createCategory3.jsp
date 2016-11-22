
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page import="com.plagiar.entities.Category" %>
<%@ page import="java.util.List" %>
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

            String university = request.getParameter("uni");
            String dept = request.getParameter("department");
            String cat = request.getParameter("category");
            

            List<Category> listAllCategories = plagiarRemote.getCategoryList();

            //System.out.println(university + dept + category);
        %>
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
                            <%                            int flag = 0;
                                for (Category parseCategory : listAllCategories) {
                                    if (parseCategory.getCategory().equals(cat) && parseCategory.getDepartment().equals(dept) && parseCategory.getUniversity().equals(university)) {
                            %><h3>Category Already Exists!!!</h3> <br/><br/>
                            <a href="createCategory.jsp">Try Again...</a><br/><br/><%
                                        flag = 1;
                                    }
                                }
                                if(flag==0){
                                    Category category = new Category();
                                    category.setUniversity(university);
                                    category.setDepartment(dept);
                                    category.setCategory(cat);
                                    plagiarRemote.addCategoryInDatabase(category);
                                    PathsPlagiar server = plagiarRemote.getDirectoryPath("CatPath");
                                    String serverPath = server.getPath();
                                    plagiarRemote.createDirectory(serverPath, university, dept, cat);
                                %><h3>Category Added!</h3><%
                                }
                            %>
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

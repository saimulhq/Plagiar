
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
        <jsp:include page="header.jsp"/>

        <jsp:include page="navigation.jsp"/>

        <div class="container-fluid">
            <div class="row" id="contentRow">
                <jsp:include page="menu.jsp"/>
                <div class="col-md-10 col-sm-10" id="contentBody">


                    <div class="panel-default">
                        <div class="panel-body">
                            <h3>Create Category</h3>
                            <form name="createCategory" action="createCategory2.jsp">
                                University Name: <input name="university" type="text" class="form-control" style="width:300px;"><br/>
                                Department Name: <input name="department" type="text" class="form-control" style="width:300px;"><br/>
                                Category Type:  <select name="catType" class="form-control" style="width:300px;">
                                    <option selected="selected">Please select..</option>
                                    <option value="Assignment">Assignment</option>
                                    <option value="Project">Project</option>
                                    <option value="Thesis">Thesis</option>
                                </select><br/>
                                Category Name: <input name="catName" type="text" class="form-control" style="width:300px;"><br/>
                                <button type="submit" class="btn btn-default">Create</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

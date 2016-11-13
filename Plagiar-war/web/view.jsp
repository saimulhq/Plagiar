
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


                    <div class="panel-default">
                        <div class="panel-body">

                            <h3>View</h3>
                            
                                <a href="searchTitle.jsp" class="btn btn-default" style="width:200px;">Search by Title</a><br/><br/>
                                <a href="searchCategory.jsp" class="btn btn-default" style="width:200px;">Search by Category</a><br/><br/>
                                <a href="searchDocument.jsp" class="btn btn-default" style="width:200px;">Search by Document Type</a><br/><br/>
                                <a href="viewRepository.jsp" class="btn btn-default" style="width:200px;">View Repository</a><br/><br/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>

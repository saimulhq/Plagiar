
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <h3>New University</h3>
                            <form name="createNewUni" action="createNewUni2.jsp">
                                University Name: <input name="university" type="text" class="form-control" style="width:300px;"><br/>
                                Address: <input name="address" type="text" class="form-control" style="width:300px;"><br/>
                                Country: <input name="country" type="text" class="form-control" style="width:300px;"><br/>
                                State: <input name="state" type="text" class="form-control" style="width:300px;"><br/>
                                Established year: <input name="estYear" type="text" class="form-control" style="width:300px;"><br/>
                                URL: <input name="url" type="text" class="form-control" style="width:300px;"><br/>
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


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
        <style>
            #contentBody, .container-fluid {
                /*height:523px;*/
                overflow-y:auto;
                height:77%;
            }
        </style>
        <script>
            function validate() {
                var x = document.forms["createNewUni"]["university"].value;
                var y = document.forms["createNewUni"]["address"].value;
                var z = document.forms["createNewUni"]["country"].value;
                var q = document.forms["createNewUni"]["state"].value;
                var w = document.forms["createNewUni"]["estYear"].value;
                var e = document.forms["createNewUni"]["url"].value;
                if (x === "" && y === "" && z === "" && q === "" && w === "" && e === "") {
                    alert("You must fillup all the fields!");
                    return false;
                }
                if (x === "") {
                    alert("You must enter the university!");
                    return false;
                }
                if (y === "") {
                    alert("You must enter the address!");
                    return false;
                }
                if (z === "") {
                    alert("You must enter the country!");
                    return false;
                }
                if (q === "") {
                    alert("You must enter the state!");
                    return false;
                }
                if (w === "") {
                    alert("You must enter the established year!");
                    return false;
                }
                if (e === "") {
                    alert("You must enter the url!");
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
                                    <h3>New University</h3>
                                    <form name="createNewUni" action="createNewUni2.jsp">
                                        University Name: <input name="university" type="text" class="form-control" style="width:300px;"><br/>
                                        Address: <input name="address" type="text" class="form-control" style="width:300px;"><br/>
                                        Country: <input name="country" type="text" class="form-control" style="width:300px;"><br/>
                                        State: <input name="state" type="text" class="form-control" style="width:300px;"><br/>
                                        Established year: <input name="estYear" type="text" class="form-control" style="width:300px;"><br/>
                                        URL: <input name="url" type="text" class="form-control" style="width:300px;"><br/>
                                        <button type="submit" class="btn btn-default" onclick="return validate();">Create</button><br><br>
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

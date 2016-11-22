
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="styles/template.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
        <div class="container-fluid">
        <div class="row" id="contentRow">
             <jsp:include page="menu.jsp"/>
            <div class="col-md-10 col-sm-10" id="contentBody">


                <div class="panel-default">
                    <div class="panel-body">
                        <div class="panel panel-default" style="background-color: ghostwhite;">
                            <div class="container-fluid">
                                <h3>Plagiar</h3>
                                <br/>
                                <p>Plagiar is a web based tool for academic plagiarism checking 
                                    and a repository management system.</p>
                                <br>
                                <p>It gives an estimation of plagiarism. User can generate detailed plagiarism report as per need.</p>
                                <br>
                                <p>Assumptions:</p>
                                <ul>
                                    <li>University has been already created by a teacher before creating new Department.</li>
                                    <li>Department has been already created by a teacher before creating new Category.</li>
                                    <li>If a student adds file in a category, then he has to assign it to a teacher.</li>
                                    <li>Category consists of a collection of files.</li>
                                </ul>
                                <br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </body>
</html>

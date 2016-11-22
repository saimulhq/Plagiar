<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Plagiar</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script>
            function validate() {
                var x = document.forms["loginform"]["j_username"].value;
                var y = document.forms["loginform"]["j_password"].value;
                if (x === "" && y === "") {
                    alert("Username and password cannot be empty!");
                    return false;
                }
                if (x === "") {
                    alert("You must enter the username!");
                    return false;
                }
                if (y === "") {
                    alert("You must enter the password!");
                    return false;
                }
            }
        </script>    
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <div class="container">    
            <div id="loginbox" style="margin-top:120px;height: 440px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
                <div class="panel panel-info" >
                    <div class="panel-heading">
                        <div class="panel-title">Sign In</div>
                    </div>     

                    <div style="padding-top:30px" class="panel-body" >
                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                        <form id="loginform" name="loginform" class="form-horizontal" role="form" action="j_security_check" method="POST">
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input id="login-username" type="email" class="form-control" name="j_username" placeholder="email" required>                                        
                            </div>

                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <input id="login-password" type="password" class="form-control" name="j_password" placeholder="password" required>
                            </div>

                            <div style="margin-top:10px" class="form-group">
                                <div class="col-sm-12 controls" style="text-align:center;">
                                    <input type="submit" id="btn-login" class="btn btn-success" value="Login" onclick="return validate();"/>
                                </div>
                            </div>

                            </div>    
                        </form>     
                    </div>                     
                </div>  
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
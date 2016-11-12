
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link rel="stylesheet" href="jquery/jquery-ui.css">
        <script src="jquery/jquery-1.10.2.js"></script>
        <script src="jquery/jquery-ui.js"></script>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script>
            function showfield(name) {
                if (name === 'Teacher') {
                    var inner = '<br/>Username: <input type="text" name="t_username" class="form-control" style="width: 300px;"/>';
                    inner = inner + '<br/>Password: <input type="password" name="t_password" class="form-control" style="width: 300px;"/>'
                            + '<br/>Name: <input type="text" name="t_name" class="form-control" style="width: 300px;"/>'
                            + '<br/>Designation: <input type="text" name="designation" class="form-control" style="width: 300px;"/>'
                            + '<br/>Department: <input type="text" name="t_dept" class="form-control" style="width: 300px;"/>'
                            + '<br/>University: <input type="text" name="t_university" class="form-control" style="width: 300px;"/>';
                    document.getElementById('hidden1').innerHTML = inner;
                } else if (name === 'Student') {
                    var inner = '<br/>Username: <input type="text" name="s_username" class="form-control" style="width: 300px;"/>';
                    inner = inner + '<br/>Password: <input type="password" name="s_password" class="form-control" style="width: 300px;"/>'
                            + '<br/>Name: <input type="text" name="s_name" class="form-control" style="width: 300px;">'
                            + '<br/>Roll Number: <input type="text" name="roll" class="form-control" style="width: 300px;">'
                            + '<br/>Batch Name: <input type="text" name="b_name" class="form-control" style="width: 300px;">'
                            + '<br/>Batch Number: <input type="text" name="b_number" class="form-control" style="width: 300px;">'
                            + '<br/>Department: <input type="text" name="s_dept" class="form-control" style="width: 300px;">'
                            + '<br/><br/>University: <input type="text" name="s_university" class="form-control" style="width: 300px;">';
                    document.getElementById('hidden1').innerHTML = inner;
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
                            <h3>Create Account</h3>
                            <form name="createAccount" action="createAccount2.jsp">
                                Select the account type:
                                <select name="select_account" id="select_account" onchange="showfield(this.options[this.selectedIndex].value)" class="form-control" style="width:300px;">
                                    <option selected="selected">Please select ...</option>
                                    <option value="Teacher">Teacher</option>
                                    <option value="Student">Student</option>
                                </select>

                                <div id="hidden1"></div>
                                

                                <br/>
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

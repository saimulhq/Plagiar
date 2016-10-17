
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <script>
            function showfield(name) {
                if (name === 'Teacher') {
                    var inner = '<br/><br/>Username: <input type="text" name="t_username" />';
                    inner = inner + '<br/><br/>Password: <input type="password" name="t_password" />'
                            + '<br/><br/>Name: <input type="text" name="t_name">'
                            + '<br/><br/>Designation: <input type="text" name="designation">'
                            + '<br/><br/>Department: <input type="text" name="t_dept">'
                            + '<br/><br/>University: <input type="text" name="t_university">';
                    document.getElementById('hidden2').innerHTML = inner;
                } else if (name === 'Student') {
                    var inner = '<br/><br/>Username: <input type="text" name="s_username" />';
                    inner = inner + '<br/><br/>Password: <input type="password" name="s_password" />'
                            + '<br/><br/>Name: <input type="text" name="s_name">'
                            + '<br/><br/>Roll Number: <input type="text" name="roll">'
                            + '<br/><br/>Batch Name: <input type="text" name="b_name">'
                            + '<br/><br/>Batch Number: <input type="text" name="b_number">'
                            + '<br/><br/>Department: <input type="text" name="s_dept">'
                            + '<br/><br/>University: <input type="text" name="s_university">';
                    document.getElementById('hidden2').innerHTML = inner;
                }
            }
        </script>
    </head>
    <body>
        <h1>Create Account</h1>
        <form name="createAccount" action="createAccount2.jsp">
        <select name="select_account" id="select_account" onchange="showfield(this.options[this.selectedIndex].value)">
            <option selected="selected">Please select ...</option>
            <option value="Teacher">Teacher</option>
            <option value="Student">Student</option>
        </select>

        <div id="hidden1"></div>
        <div id="hidden2"></div>
        
        <br/>
        <input type="submit" value="Create">
        </form>
    </body>
</html>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
    </head>
    <body>
        <h1>Create Category</h1>

        <form name="createCategory" action="createCategory2.jsp">
            University Name: <input name="university" type="text"><br/><br/>
            Department Name: <input name="department" type="text"><br/><br/>
            Category Type:  <select name="catType">
                <option selected="selected">Please select..</option>
                <option value="Assignment">Assignment</option>
                <option value="Project">Project</option>
                <option value="Thesis">Thesis</option>
            </select><br/><br/>
            Category Name: <input name="catName" type="text"><br/><br/>
            <input type="submit" value="Create">
        </form>
    </form>
</body>
</html>

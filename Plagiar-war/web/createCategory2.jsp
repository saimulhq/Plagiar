<%@page import="java.io.File" %>
<%@page import="com.plagiar.entities.Directory" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.naming.Context" %>
<%@page import="com.plagiar.PlagiarRemote" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
    </head>
    <body>
        <h1>Done</h1>
        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                //List<MenuItd> listx = itdr.getMenuByUsername(name);
            } catch (Exception e) {
                e.printStackTrace();
            }

            Directory directory = new Directory();

            String university = request.getParameter("university");
            String department = request.getParameter("department");
            String type = request.getParameter("catType");
            String catName = request.getParameter("catName");

            directory.setUniversity(university);
            directory.setDepartment(department);
            directory.setType(type);
            directory.setCategory(catName);

            plagiarRemote.addCategoryInDatabase(directory);
            plagiarRemote.createDirectory(catName);

        %>
    </body>
</html>

<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="com.plagiar.entities.DirectoryPlagiar" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
    </head>
    <body>
        <h1>Done</h1>
        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                
            } catch (Exception e) {
                e.printStackTrace();
            }

            DirectoryPlagiar directory = new DirectoryPlagiar();

            String university = request.getParameter("university");
            String department = request.getParameter("department");
            String type = request.getParameter("catType");
            String catName = request.getParameter("catName");

            directory.setUniversity(university);
            directory.setDepartment(department);
            directory.setType(type);
            directory.setCategory(catName);

            plagiarRemote.addCategoryInDatabase(directory);
            PathsPlagiar server = plagiarRemote.getDirectoryPath("CatPath");
            String serverPath = server.getPath();
            plagiarRemote.createDirectory(serverPath, catName);

        %>
    </body>
</html>

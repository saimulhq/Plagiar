
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
    </head>
    <body>
        <h1>Upload File</h1>
        <%
            String category = request.getParameter("category");
            System.out.println("category name: "+category);
        
        %>
        <form action="addFile2.jsp?category=<%=category%>" method="post" enctype="multipart/form-data">
        <input type="file" name="file" accept=".doc, .docx" multiple="multiple"/>
        <br />
        <input type="submit" value="Upload File" />
        </form>
    </body>
</html>

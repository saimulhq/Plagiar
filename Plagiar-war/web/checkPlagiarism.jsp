
<%@ page import="com.plagiar.entities.DirectoryPlagiar" %>
<%@ page import="java.util.List" %>
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
        <h1>Check Plagiarism</h1>
        <%
        PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

            } catch (Exception e) {
                e.printStackTrace();
            }
            List<DirectoryPlagiar> listAllCategory = plagiarRemote.getDirectoryList();
        %>
        <form action="checkPlagiarism2.jsp" method="post" enctype="multipart/form-data">
        Select a category: <select name="category">
                <option selected="selected">Please select ...</option>
                <%
                    for (DirectoryPlagiar category : listAllCategory) {
                %><option><%=category.getCategory()%></option><%
                    }
                %>
            </select>
        <br/>
        Upload file: <input type="file" name="file" accept=".pdf"/>
        <br />
        <input type="submit" value="Upload File" />
        </form>
        
       
    </body>
</html>

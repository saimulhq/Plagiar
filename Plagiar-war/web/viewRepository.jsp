<%@ page import="com.plagiar.entities.Directory" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
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
        <h1>View Repository</h1>
        <%
        PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        
        List <Directory> listAllDirectory = plagiarRemote.getDirectoryList();
        %>
        <table>
            <thead>
            <th>Directory</th>
            </thead>
            <tbody>
                <% 
                    for(Directory dir:listAllDirectory){ %>
                    <tr><td><a href="viewFiles.jsp?category=<%=dir.getCategory()%>"><%=dir.getCategory()%></a></td><td><a href="addFile.jsp?category=<%=dir.getCategory()%>">Add file</a></td></tr>
                <% } %>
            </tbody>
        </table>
    </body>
</html>

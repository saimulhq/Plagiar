
<%@ page import="com.plagiar.entities.FilesPlagiar" %>
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
        <h1>View Files</h1>
        <% 
        PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            String category = request.getParameter("category");
            List<FilesPlagiar> listAllFiles = plagiarRemote.getFilesList(category);
           
        %>
        <table>
            <thead>
            <th>Files</th><th>Added By</th><th>Time Added</th>
            </thead>
            <tbody>
                <% 
                    for(FilesPlagiar files:listAllFiles){ %>
                    <tr><td><a href="fileDownload.jsp?fileLocation=<%=files.getFilelocation()%>&filename=<%=files.getFilename()%>"><%=files.getFilename()%></a></td><td><%=files.getAddedby()%></td><td><%=files.getTimeadded()%></td></tr>
                <% } %>
            </tbody>
        </table>
    </body>
</html>

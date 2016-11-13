
<%@ page import="com.plagiar.entities.FilesPlagiar" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="styles/template.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
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
                        <h3>View Repository</h3>
        <% 
        PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            String university = request.getParameter("uni");
            String department = request.getParameter("dept");
            String category = request.getParameter("category");
            List<FilesPlagiar> listAllFiles = plagiarRemote.getFilesList(university, department, category);
           
        %>
        <table class="table table-bordered">
            <thead>
            <th>File Name</th><th>Title</th><th>Document Type</th><th>Added By</th><th>Time Added</th><th></th>
            </thead>
            <tbody>
                <% 
                    boolean recordAvailable = false;
                    int i = 0;
                    for(FilesPlagiar files:listAllFiles){ %>
                    <tr>
                        <td><a href="fileDownload.jsp?fileLocation=<%=files.getFilelocation()%>&filename=<%=files.getFilename()%>" style="text-decoration: none;"><%=files.getFilename()%></a></td>
                        <td><%=files.getTitle()%></td><td><%=files.getCategoryType()%></td><td><%=files.getAddedby()%></td><td><%=files.getTimeadded()%></td>
                        <td><a href="deleteFile.jsp?fileLocation=<%=files.getFilelocation()%>&filename=<%=files.getFilename()%>" style="text-decoration: none;color:red;">Delete</a></td>
                        <%recordAvailable = true;%>
                    </tr>
               <%
                        i++;
                                }%>
                <%
                    if(!recordAvailable){
                                %><tr><td colspan="12">No data found!</td></tr><%
                                }
            %>     
            </tbody>
        </table>
            Total results found: <%=i%><br/><br/>
            <a class="btn btn-default" href="viewRepositoryT3.jsp?uni=<%=university%>&dept=<%=department%>">Back</a>
                    </div>
                </div>
            </div>
        </div>
        </div>
        
        <jsp:include page="footer.jsp"/>
    </body>
</html>

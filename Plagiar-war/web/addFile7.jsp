<%@ page import="com.plagiar.entities.Users" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
<%@ page import="com.plagiar.entities.FilesPlagiar" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <link rel="shortcut icon" href="favicon.ico" />
        <style>
            #contentBody, .container-fluid {
                /*height:523px;*/
                overflow-y:auto;
                height:77%;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <jsp:include page="navigation.jsp"/>
        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

            } catch (Exception e) {
                e.printStackTrace();
            }
            
            String name = request.getUserPrincipal().getName();
            Users users = plagiarRemote.getUserRole(name);

            String role = users.getRole();
            
            String university = request.getParameter("uni");
            System.out.println(university);
            String dept = request.getParameter("dept");
            String title;
            String author;
            String catType = request.getParameter("catType");
            System.out.println(dept);

            FilesPlagiar files = new FilesPlagiar();
            String username = request.getUserPrincipal().getName();
            PathsPlagiar path1 = plagiarRemote.getDirectoryPath("CatPath");
            String catPath = path1.getPath();
            System.out.println("catPath: " + catPath);
            String category = request.getParameter("category");
            Calendar calendar = Calendar.getInstance();
            String pubYear;
            String teacher;
            if(role.equals("student")){
                teacher = request.getParameter("teacher");
            }
            else {
                teacher="N/A";
            }
            File file;
            List<String> values = new ArrayList<String>();
            String value = null;
            String fullPath = null;
            String fileName;
            int maxFileSize = 10000 * 1024;
            int maxMemSize = 10000 * 1024;
            //ServletContext context = pageContext.getServletContext();
            String filePath;

            // Verify the content type
            String contentType = request.getContentType();
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
                // Location to save data that is larger than maxMemSize.
                PathsPlagiar path2 = plagiarRemote.getDirectoryPath("TempPath");
                String temp = path2.getPath();
                System.out.println("tempPath: " + temp);
                factory.setRepository(new File(temp));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);
                try {
                    // Parse the request to get file items.
                    List<FileItem> fileItems = upload.parseRequest(request);

                    for (FileItem fileItem : fileItems) {
                        if (fileItem.isFormField()) {
                            //fieldName = fileItem.getFieldName();
                            value = fileItem.getString();
                            values.add(value);

                        }
                    }
                    System.out.print(values.get(0));
                    System.out.print(values.get(1));
                    title = values.get(0);
                    author = values.get(1);
                    pubYear = values.get(2);
                    filePath = catPath + university + "\\" + dept + "\\" + category + "\\" + catType + "\\";

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            // Get the uploaded file parameters
                            String fieldName = fi.getFieldName();
                            fileName = fi.getName();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            // Write the file
                            if (fileName.lastIndexOf("\\") >= 0) {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\")));
                            } else {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\") + 1));
                            }
                            fi.write(file);
                            System.out.println("Uploaded Filename: " + filePath
                                    + fileName);
                            fullPath = filePath + fileName;
                            System.out.println(fullPath);
                            files.setFilename(fileName);
                            files.setFilelocation(fullPath);
                            files.setAuthor(author);
                            files.setCategory(category);
                            files.setDepartment(dept);
                            files.setUniversity(university);
                            files.setTitle(title);
                            files.setAddedby(username);
                            files.setTimeadded(calendar.getTime());
                            files.setCategoryType(catType);
                            files.setPublishedYear(pubYear);
                            files.setAssignedto(teacher);
                            plagiarRemote.addFilesInDatabase(files);
                        }
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            } else {

                System.out.println("No file uploaded");

            }
        %>
        <div class="container-fluid">
        <div class="row" id="contentRow">
             <jsp:include page="menu.jsp"/>
            <div class="col-md-10 col-sm-10" id="contentBody">


                <div class="panel-default">
                    <div class="panel-body">
                        <div class="panel panel-default" style="background-color: ghostwhite;">
                            <div class="container-fluid">
                        <h3>File Added!</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>

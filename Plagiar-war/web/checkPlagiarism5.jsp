<%@ page import="org.apache.tika.Tika" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="com.plagiar.entities.PathsPlagiar" %>
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
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
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
                        <h3>Check Plagiarism</h3>
                        <%
                            PlagiarRemote plagiarRemote = null;

                            try {
                                Context context = new InitialContext();
                                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                            String category = request.getParameter("category");
                            //            System.out.println("trying to print the category: "+category);
                            String university = request.getParameter("uni");
                            String dept = request.getParameter("dept");
                            PathsPlagiar path1 = plagiarRemote.getDirectoryPath("SubmissionPath");
                            String subPath = path1.getPath();
                            System.out.println(subPath);

                            File file;

                            List<String> values = new ArrayList<String>();
                            String value = null;
                            String fullPath = null;
                            int maxFileSize = 5000 * 1024;
                            int maxMemSize = 5000 * 1024;
                            //ServletContext context = pageContext.getServletContext();
                            String filePath = subPath + "\\";
                            //context.getInitParameter("file-upload");

                            // Verify the content type
                            String contentType = request.getContentType();
                            if ((contentType.indexOf("multipart/form-data") >= 0)) {

                                DiskFileItemFactory factory = new DiskFileItemFactory();
                                // maximum size that will be stored in memory
                                factory.setSizeThreshold(maxMemSize);
                                // Location to save data that is larger than maxMemSize.
                                PathsPlagiar path2 = plagiarRemote.getDirectoryPath("TempPath");
                                factory.setRepository(new File(path2.getPath()));

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
                                    //System.out.print(values.get(1));
                                    //System.out.print(values.get(2));
                                    // Process the uploaded file items
                                    Iterator i = fileItems.iterator();

                                    while (i.hasNext()) {
                                        FileItem fi = (FileItem) i.next();
                                        if (!fi.isFormField()) {
                                            // Get the uploaded file parameters
                                            String fieldName = fi.getFieldName();

                                            String fileName = fi.getName();
                                            boolean isInMemory = fi.isInMemory();
                                            long sizeInBytes = fi.getSize();
                                            // Write the file
                                            if (fileName.lastIndexOf("\\\\") >= 0) {
                                                file = new File(filePath
                                                        + fileName.substring(fileName.lastIndexOf("\\\\")));
                                            } else {
                                                file = new File(filePath
                                                        + fileName.substring(fileName.lastIndexOf("\\\\") + 1));
                                            }

                                            fi.write(file);
                                            System.out.println("Uploaded Filename: " + filePath
                                                    + fileName + "");
                                            fullPath = filePath + fileName;

                                            //System.out.println(fileName);
                                            //System.out.println(filePath);
                                            System.out.println(fullPath);
                                        }
                                    }
                                } catch (Exception ex) {
                                    System.out.println(ex);
                                }
                            } else {
                                System.out.println("No file uploaded!");
                            }

                            File f1 = new File(fullPath);
                            //File f2 = new File("G:\\Lucene\\testDataText\\2.txt");
                            Tika tika = new Tika();
                            String text1 = tika.parseToString(f1);

                            PathsPlagiar path3 = plagiarRemote.getDirectoryPath("CatPath");
                            String newPath = path3.getPath() + university + "\\"+dept+"\\"+category + "\\";
                            File dataDir = new File(newPath);
                            File[] filesInCategory = dataDir.listFiles();
                            String text[] = new String[100];

                            for (int i = 0; i < filesInCategory.length; i++) {
                                File f = filesInCategory[i];
                                System.out.println(f);
                                text[i] = tika.parseToString(f);
                                //System.out.println(text[i]);
                                plagiarRemote.generateCosineSimilarity(text1, text[i]);;
                                double similarity = plagiarRemote.getCosineSimilarity();
                        %>
                        <p>Cosine Similarity between: <%=f1.getName()%> and <%=f.getName()%>: <%=similarity%><p>
                            <%
                                }
                            %>
                        <div class="panel-body">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

    </body>
</html>
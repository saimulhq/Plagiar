<%@page import="com.plagiar.entities.FilesPlagiar"%>
<%@ page import="com.plagiar.entities.Submissions" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.text.DecimalFormat" %>
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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="javascripts/paging.js"></script>
        <style>
            .pg-normal {
                color: #23527c;
                font-weight: normal;
                text-decoration: none;    
                cursor: pointer;    
            }
            .pg-selected {
                color: #E3106D;
                font-weight: bold;        
                text-decoration: underline;
                cursor: pointer;
            }
            .pg-normal:hover{
                background-color:#23527c;
                color: white;
            }
            
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
        <div class="container-fluid">
            <div class="row" id="contentRow">
                <jsp:include page="menu.jsp"/>
                <div class="col-md-10 col-sm-10" id="contentBody">


                    <div class="panel-default">
                    <div class="panel-body">
                        <div class="panel panel-default" style="background-color: ghostwhite;">
                            <div class="container-fluid">
                        <h3>Plagiarism Detected</h3>
                        <table class="table table-bordered" id="result">
                            <thead>
                            <th>Input File Title</th><th>Archive File Title</th><th>Plagiarism Detected</th><th></th>
                            </thead>
                            <tbody>
                                <%
                                    PlagiarRemote plagiarRemote = null;

                                    try {
                                        Context context = new InitialContext();
                                        plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                    
                                    List<String> listTitles = new ArrayList<String>();
                                    List<String> listAuthors = new ArrayList<String>();
                                    List<String> listDepts = new ArrayList<String>();
                                    List<String> listUnis = new ArrayList<String>();
                                    List<String> listYears = new ArrayList<String>();
                                    List<String> listValues = new ArrayList<String>();
                                    Calendar calendar = Calendar.getInstance();
                                    Submissions submissions = new Submissions();
                                    String category = request.getParameter("category");
                                    //            System.out.println("trying to print the category: "+category);
                                    String university = request.getParameter("uni");
                                    String dept = request.getParameter("dept");
                                    String catType=request.getParameter("catType");
                                    PathsPlagiar path1 = plagiarRemote.getDirectoryPath("SubmissionPath");
                                    String subPath = path1.getPath();
                                    System.out.println(subPath);
                                    String stringLimit;
                                    String inputTitle=null;
                                    String inputAuthor=null;
                                    String inputUniversity=null;
                                    String inputDepartment=null;
                                    String inputYear=null;
                                    double limit=100;
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
                                            
                                            inputTitle=values.get(0);
                                            inputAuthor=values.get(1);
                                            inputUniversity=values.get(2);
                                            inputDepartment=values.get(3);
                                            inputYear=values.get(4);
                                            stringLimit = values.get(5);
                                            limit = Double.parseDouble(stringLimit);
                                            
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
                                    String newPath = path3.getPath() + university + "\\" + dept + "\\" + category + "\\" + catType+ "\\";
                                    File dataDir = new File(newPath);
                                    File[] filesInCategory = dataDir.listFiles();
                                    String text[] = new String[100];
                                    boolean valueFound=false;
                                    boolean hideButton=false;
                                    for (int i = 0; i < filesInCategory.length; i++) {
                                        File f = filesInCategory[i];
                                        
                                        //System.out.println(f.getAbsolutePath());
                                        FilesPlagiar fp = plagiarRemote.getFileDetails(f.getAbsolutePath());
                                        
                                        //plagiarRemote.listTitles(fp.getTitle());
                                        text[i] = tika.parseToString(f);
                                        //System.out.println(text[i]);
                                        plagiarRemote.generateCosineSimilarity(text1, text[i]);;
                                        double similarity = plagiarRemote.getCosineSimilarity() * 100;
                                        DecimalFormat df = new DecimalFormat("#");
                                        //df.setRoundingMode(RoundingMode.CEILING);
                                        //double roundedSimilarity = (double)df.format(similarity);
                                        //double testsample=0.98675;
                                        //System.out.println(df.format(testsample));
                                %>
                                <% if (similarity>=limit) {%>
                                <tr>
                                    <td><%=inputTitle%></td><td><%=fp.getTitle()%></td><td><%=df.format(similarity)%>%</td>
                                    <td><a href="checkIndividual.jsp?file1=<%=f1%>&file2=<%=f%>&title=<%=inputTitle%>&author=<%=inputAuthor%>&dept=<%=inputDepartment%>&uni=<%=inputUniversity%>&year=<%=inputYear%>">View Details</a></td>
                                    <%
                                        fp.getTitle();
                                        fp.getAuthor();
                                        fp.getDepartment();
                                        fp.getUniversity();
                                        fp.getPublishedYear();
                                        listValues.add(fp.getTitle());
                                        listValues.add(fp.getAuthor());
                                        listValues.add(fp.getDepartment());
                                        listValues.add(fp.getUniversity());
                                        listValues.add(fp.getPublishedYear());
                                        listValues.add(df.format(similarity)+"%");
                                        
                                        String filename1=f1.getName();
                                        String filename2=f.getName();
                                        String result = df.format(similarity) +"%";
                                        submissions.setInputTitle(values.get(0));
                                        submissions.setArchiveTitle(fp.getTitle());
                                        submissions.setResult(result);
                                        submissions.setTimestamp(calendar.getTime());
                                        plagiarRemote.addResultsInDatabase(submissions);
                                    %>
                                </tr>
                                    <%
                                        valueFound=true;
                                            }
                                        }
                                    
                                    if(valueFound==false){
                                        hideButton=true;
                                    %><tr><td colspan="12">No plagiarism found!</td></tr><%
                                    }
                                    %>
                            </tbody>
                        </table>
                            <div id="pageNavPosition" align="center"></div>
                                    <script type="text/javascript">
                                        var pager = new Pager('result', 9);
                                        pager.init();
                                        pager.showPageNav('pager', 'pageNavPosition');
                                        pager.showPage(1);
                                    </script>
                                    <%
                                        for(int i=0;i<listTitles.size();i++){
                                            System.out.println(listTitles.get(i));
                                        }
                                        request.getSession().setAttribute("valueslist",listValues);
                                       /* request.getSession().setAttribute("authorlist",listAuthors);
                                        request.getSession().setAttribute("deptlist",listDepts);
                                        request.getSession().setAttribute("unilist",listUnis);
                                        request.getSession().setAttribute("yearlist",listYears);*/
                                    %>
                                    <a class="btn btn-default" href="checkPlagiarism5.jsp?uni=<%=university%>&dept=<%=dept%>&category=<%=category%>&catType=<%=catType%>">Back</a> 
                                    <%if(hideButton==false){%>
                                    <a class="btn btn-default" href="generateReport.jsp?title=<%=inputTitle%>&author=<%=inputAuthor%>&dept=<%=inputDepartment%>&uni=<%=inputUniversity%>&year=<%=inputYear%>">Generate Report</a><br><br>
                                    <%}%>
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
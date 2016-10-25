<%@ page import="com.plagiar.entities.Files" %>
<%@ page import="com.plagiar.entities.Paths" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
    </head>
    <body>
        <h1>Done!</h1>
        
        <%  
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            Files files = new Files();
            String username=request.getUserPrincipal().getName();
            Paths path1 = plagiarRemote.getDirectoryPath("CatPath");
            String catPath = path1.getPath();
            System.out.println("catPath: "+catPath);
            String category=request.getParameter("category");
            Calendar calendar=Calendar.getInstance();
            
            File file;
            int maxFileSize = 5000 * 1024;
            int maxMemSize = 5000 * 1024;
            //ServletContext context = pageContext.getServletContext();
            String filePath = catPath+category+"\\";
                    //context.getInitParameter("file-upload");

            // Verify the content type
            String contentType = request.getContentType();
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

               DiskFileItemFactory factory = new DiskFileItemFactory();
               // maximum size that will be stored in memory
               factory.setSizeThreshold(maxMemSize);
               // Location to save data that is larger than maxMemSize.
               
               Paths path2 = plagiarRemote.getDirectoryPath("TempPath");
               String temp = path2.getPath();
               System.out.println("tempPath: "+temp);
               factory.setRepository(new File(temp));

               // Create a new file upload handler
               ServletFileUpload upload = new ServletFileUpload(factory);
               // maximum file size to be uploaded.
               upload.setSizeMax( maxFileSize );
               try{ 
                  // Parse the request to get file items.
                  List fileItems = upload.parseRequest(request);

                  // Process the uploaded file items
                  Iterator i = fileItems.iterator();

                  while ( i.hasNext () ) 
                  {
                     FileItem fi = (FileItem)i.next();
                     if ( !fi.isFormField () )	
                     {
                     // Get the uploaded file parameters
                     String fieldName = fi.getFieldName();
                     String fileName = fi.getName();
                     boolean isInMemory = fi.isInMemory();
                     long sizeInBytes = fi.getSize();
                     // Write the file
                     if( fileName.lastIndexOf("\\") >= 0 ){
                     file = new File( filePath + 
                     fileName.substring( fileName.lastIndexOf("\\"))) ;
                     }else{
                     file = new File( filePath + 
                     fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                     }
                     fi.write( file ) ;
                     System.out.println("Uploaded Filename: " + filePath +fileName);
                     String fullpath = filePath + fileName;
                     System.out.println(fullpath);
                     files.setCategory(category);
                     files.setFilename(fileName);
                     files.setFilelocation(fullpath);
                     files.setAddedby(username);
                     System.out.println(username +" "+ calendar.getTime());
                     files.setTimeadded(calendar.getTime());
                     plagiarRemote.addFilesInDatabase(files);
                     }
                  }
                 
               }catch(Exception ex) {
                  System.out.println(ex);
               }
            }else{
               System.out.println("No file uploaded"); 
            }
%>
    </body>
</html>

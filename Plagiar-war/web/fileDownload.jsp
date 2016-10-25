
<%@ page import="java.io.FileInputStream" %>
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
            String fileLocation = request.getParameter("fileLocation");
            System.out.println(fileLocation);
            
            String filename = request.getParameter("filename");   
            //String filepath = "e:\\";   
            response.setContentType("APPLICATION/OCTET-STREAM");   
            response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   

            FileInputStream fileInputStream=new FileInputStream(fileLocation);  

            int i;   
            while ((i=fileInputStream.read()) != -1) {  
              out.write(i);   
            }   
            fileInputStream.close();   
        %>
    </body>
</html>

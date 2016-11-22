
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
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
//            response.setContentType("application/pdf");   
//            response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   

//            FileInputStream fileInputStream=new FileInputStream(fileLocation);  
//
//            int i;   
//            while ((i=fileInputStream.read()) != -1) {  
//              out.write(i);   
//            }   
//            fileInputStream.close();   
//File my_file = new File(fileLocation);
//
//         // This should send the file to browser
//         OutputStream output = response.getOutputStream();
//         FileInputStream in = new FileInputStream(my_file);
//         byte[] buffer = new byte[4096];
//         int length;
//         while ((length = in.read(buffer)) > 0){
//            output.write(buffer, 0, length);
//         }
//         in.close();
//         output.flush();
                response.setContentType("text/html");
                PrintWriter output = response.getWriter();
                //String filename = ;
                //String filepath = "e:\\";
                response.setContentType("APPLICATION/OCTET-STREAM");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

                FileInputStream fileInputStream = new FileInputStream(fileLocation);

                int i;
                while ((i = fileInputStream.read()) != -1) {
                    output.write(i);
                }
                fileInputStream.close();
                output.close();
           
        %>
    </body>
</html>

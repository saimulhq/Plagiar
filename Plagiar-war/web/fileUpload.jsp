<%-- 
    Document   : fileUpload
    Created on : Nov 11, 2016, 5:53:21 PM
    Author     : Saimul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>File Uploading Form</title>
    </head>
    <body>
        <h3>File Upload:</h3>
        Select a file to upload: <br />
        <form action="fileUpload2.jsp" method="post"
              enctype="multipart/form-data">
            <input type="file" name="file" size="50" />
            <br />
            <input type="submit" value="Upload File" />
        </form>
    </body>
</html>

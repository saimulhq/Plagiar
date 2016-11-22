
<%@page import="com.plagiar.entities.Users"%>
<%@ page import="java.util.List" %>
<%@ page import="com.plagiar.entities.FilesPlagiar" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="javascripts/paging.js"></script>
        <link rel="shortcut icon" href="favicon.ico" />
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
                    <%
                        String titleSearch = request.getParameter("titleSearch");
                        PlagiarRemote plagiarRemote = null;

                        try {
                            Context context = new InitialContext();
                            plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        List<FilesPlagiar> searchResult = plagiarRemote.search(titleSearch);

                        String username = request.getUserPrincipal().getName();
                        Users users = plagiarRemote.getUserRole(username);

                        String role = users.getRole();

                    %>

                    <div class="panel-default">
                        <div class="panel-body">
                            <div class="panel panel-default" style="background-color: ghostwhite;">
                                <div class="container-fluid">
                                    <h3>Search Result</h3>
                                    <%                            int i = 0;
                                        if (role.equals("student")) {%>
                                    <table class="table table-bordered" id="search">
                                        <thead>
                                        <th>File Name</th><th>Title</th><th>Document Type</th><th>Added By</th><th>Time Added</th>
                                        </thead>
                                        <tbody>
                                            <%                        boolean recordAvailable = false;
                                                for (FilesPlagiar filesPlagiar : searchResult) {
                                            %><tr>
                                                <td><a href="FileDownload?fileLocation=<%=filesPlagiar.getFilelocation()%>&filename=<%=filesPlagiar.getFilename()%>" style="text-decoration: none;"><%=filesPlagiar.getFilename()%></a></td>
                                                <td><%=filesPlagiar.getTitle()%></td><td><%=filesPlagiar.getCategoryType()%></td><td><%=filesPlagiar.getAddedby()%></td><td><%=filesPlagiar.getTimeadded()%></td>
                                                <%recordAvailable = true;%>
                                            </tr>
                                            <%
                                                    i++;
                                                }%><%
                                                    if (!recordAvailable) {
                                            %><tr><td colspan="12">No data found!</td></tr><%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <div id="pageNavPosition" align="center"></div>
                                    <script type="text/javascript">
                                        var pager = new Pager('search', 9);
                                        pager.init();
                                        pager.showPageNav('pager', 'pageNavPosition');
                                        pager.showPage(1);
                                    </script>
                                    <%} else {%>
                                    <table class="table table-bordered" id="search">
                                        <thead>
                                        <th>File Name</th><th>Title</th><th>Document Type</th><th>Added By</th><th>Time Added</th><th></th>
                                        </thead>
                                        <tbody>
                                            <%                        boolean recordAvailable = false;
                                                for (FilesPlagiar filesPlagiar : searchResult) {
                                            %><tr>
                                                <td><a href="FileDownload?fileLocation=<%=filesPlagiar.getFilelocation()%>&filename=<%=filesPlagiar.getFilename()%>"><%=filesPlagiar.getFilename()%></a></td>
                                                <td><%=filesPlagiar.getTitle()%></td><td><%=filesPlagiar.getCategoryType()%></td><td><%=filesPlagiar.getAddedby()%></td><td><%=filesPlagiar.getTimeadded()%></td>
                                                <td><a href="deleteFile.jsp?fileLocation=<%=filesPlagiar.getFilelocation()%>&filename=<%=filesPlagiar.getFilename()%>" style="text-decoration: none;color:red;">Delete</a></td>
                                                <%recordAvailable = true;%>
                                            </tr>
                                            <%
                                                    i++;
                                                }%><%
                                                    if (!recordAvailable) {
                                            %><tr><td colspan="12">No data found!</td></tr><%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <div id="pageNavPosition" align="center"></div>
                                    <script type="text/javascript">
                                        var pager = new Pager('search', 9);
                                        pager.init();
                                        pager.showPageNav('pager', 'pageNavPosition');
                                        pager.showPage(1);
                                    </script>
                                    <%}%>                       
                                    Total results found: <%=i%><br/><br/>
                                    <a class="btn btn-default" href="searchTitle.jsp">Back</a><br><br>
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

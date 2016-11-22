
<%@ page import="com.plagiar.entities.University" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <link href="styles/template.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

        <%
            PlagiarRemote plagiarRemote = null;

            try {
                Context context = new InitialContext();
                plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

            } catch (Exception e) {
                e.printStackTrace();
            }

            List<University> listAllUniversity = plagiarRemote.getUniversityList();
        %>

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
                                    <h3>View Repository</h3>

                                    <table class="table table-bordered" id="university">
                                        <thead>
                                        <th>List of Universities</th>
                                        </thead>
                                        <tbody>
                                            <%
                                        for (University uni : listAllUniversity) {%>
                                        <tr><td><a href="viewRepository2.jsp?uni=<%=uni.getUniversityName()%>" style="text-decoration: none;"><%=uni.getUniversityName()%></a></td></tr>
                                                    <% }%>
                                        </tbody>
                                    </table>
                                        <div id="pageNavPosition" align="center"></div>
                                    <script type="text/javascript">
                                        var pager = new Pager('university', 9);
                                        pager.init();
                                        pager.showPageNav('pager', 'pageNavPosition');
                                        pager.showPage(1);
                                    </script>
                                    <a class="btn btn-default" href="view.jsp">Back</a><br><br>
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

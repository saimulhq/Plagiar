
<%@ page import="com.plagiar.entities.Department" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page import="com.plagiar.entities.University" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                        <div class="panel-body">
                            <%
                                PlagiarRemote plagiarRemote = null;

                                try {
                                    Context context = new InitialContext();
                                    plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                List<University> listAllUniversity = plagiarRemote.getUniversityList();
                                //String selectedName = null;
                            %>
                            <h3>New Category</h3>
                            <form name="createCategory" action="createCategory2.jsp">
                                Select University: <select id="university" name="university" class="form-control" style="width:300px;">
                                    <option selected="selected">Please select ...</option>
                                    <%
                                        for (University university : listAllUniversity) {
                                    %><option><%=university.getUniversityName()%></option><%
                                        }
                                    %>
                                </select><br/>
                              <!--<script>
                                    $(document).ready(function () {
                                        $('#university').change(function () {
                                            $.ajax({
                                                url: 'GetUserServlet',
                                                data: {
                                                    university: $('#university').val()
                                                },
                                                success: function (data) {
                                                    console.log(data);
                                                }
                                            });
                                        });
                                    });

                                    //var colArray;
                                </script>-->
                                <%            //String name = (String) request.getAttribute("text");
//                                String myVal=null;
//                                if(name!=null){
//                                myVal = name;
//                                System.out.println(myVal);
//                                }
//                                List<Department> listDepartmentByUniname = plagiarRemote.getDepartmentListByUniversity(myVal);
//                                for(Department dept:listDepartmentByUniname){
//                                    System.out.println(dept.getDepartmentName());
//                                }
                                
%>
                                <button type="submit" class="btn btn-default">Next</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

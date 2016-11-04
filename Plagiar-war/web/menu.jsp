
<%@ page import="com.plagiar.entities.Menu" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="styles/template.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="jquery/jquery-1.12.4.min.js"></script>
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
            String username = request.getUserPrincipal().getName();
            List<Menu> listMenu = plagiarRemote.getMenuByUsername(username);
        %>


        <div class="col-md-2 col-sm-2" id="menu">       
            <ul class="nav nav-stacked">
                <%
                    for (Menu mn : listMenu) {
                %>
                <li><a href="<%=mn.getFilename()%>" style="color:#23527c;"  onMouseOver="this.style.color='blue'" onMouseOut="this.style.color='#23527c'"><b><%=mn.getMenuDesc()%></b></a></li>
                            <%
                                }
                            %>
            </ul>
        </div>



    </body>
</html>

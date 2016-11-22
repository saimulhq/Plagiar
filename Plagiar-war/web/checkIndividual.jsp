
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.plagiar.entities.PathsPlagiar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="com.plagiar.PlagiarRemote" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.tika.Tika" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plagiar</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles/template.css" rel="stylesheet">
        <script src="jquery/jquery-1.12.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <link rel="shortcut icon" href="favicon.ico" />
        <style>
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
                            <h3>View Detailed Result</h3>
                            
                            <%
                                String filePath1 = request.getParameter("file1");
                                File file1 = new File(filePath1);

                                String filePath2 = request.getParameter("file2");
                                File file2 = new File(filePath2);

                                String title = request.getParameter("title");
                                String author = request.getParameter("author");
                                String dept = request.getParameter("dept");
                                String uni = request.getParameter("uni");
                                String year = request.getParameter("year");

                                List<String> individualResults = new ArrayList<String>();
                                List<String> values = (List<String>) request.getSession().getAttribute("valueslist");
                                for (int i = 0; i < values.size(); i++) {
                                    System.out.println(values.get(i));
                                }
                                %>
                                <table class="table table-bordered">
                                    <thead>
                                    <th>Input File Title</th><th>Archive File Title</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><%=title%></td><td><%=values.get(0)%></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <%
                                PlagiarRemote plagiarRemote = null;
                                try {
                                    Context context = new InitialContext();
                                    plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                plagiarRemote.splitFile1(file1);
                                plagiarRemote.splitFile2(file2);

                                Tika tika = new Tika();
                                tika.setMaxStringLength(200000);
                                String text[] = new String[100];
                                String text2[] = new String[100];
                                PathsPlagiar tempPath1 = plagiarRemote.getDirectoryPath("SplitDirPath1");
                                String path1 = tempPath1.getPath();
                                PathsPlagiar tempPath2 = plagiarRemote.getDirectoryPath("SplitDirPath2");
                                String path2 = tempPath2.getPath();
                                File dataDir = new File(path1);
                                File dataDir2 = new File(path2);
                                File[] files = dataDir.listFiles();
                                File[] files2 = dataDir2.listFiles();
                                int sourcePage=0, matchedPage=0;
                                DecimalFormat df = new DecimalFormat("#");
                                double similarity = 0;
                                final int s = files.length;
                                double[][] mulArr = new double[s][3];
                                for (int i = 0; i < files.length; i++) {
                                    similarity = 0;
                                    File f = files[i];
                                    //System.out.println(f);
                                    text[i] = tika.parseToString(f);
                                    //System.out.println(text[i]);
                                    for (int j = 0; j < files2.length; j++) {
                                        File f2 = files2[j];
                                        //System.out.println(f2);
                                        text2[j] = tika.parseToString(f2);
                                        //System.out.println(text2[j]);
                                        plagiarRemote.generateCosineSimilarity(text[i], text2[j]);
                                        double newSim = plagiarRemote.getCosineSimilarity() * 100;
                                        if(newSim>similarity){
                                            similarity  = newSim;
                                            sourcePage = i+1;
                                            matchedPage = j+1;
                                        }
                                        //df.setRoundingMode();
                                        //if (similarity >= 50) {
                                            //System.out.println("Original Document " + (i+1) + " >>>>> ArchieveDocument " + (j+1) + ": " + (plagiarRemote.getCosineSimilarity() *                     100));
                                            
            //}
        }
                                    mulArr[sourcePage-1][0]=similarity;
                                    mulArr[sourcePage-1][1]=sourcePage;
                                    mulArr[sourcePage-1][2]=matchedPage;                                    
        //System.out.println(text[i]);
        //            cos = new CosineSimilarity(text1, text[i]);
        //            if(cos.getCosineSimilarity()*100>=20){
        //            System.out.println("Cosine Similarity between "+f1.getName()+" and "+f.getName()+": "+cos.getCosineSimilarity()*100);
        //            //cos.SplitFile(f1, f);
        //            }
        //            else
        //                System.out.println("No similarity!");
    }
                Arrays.sort(mulArr, new Comparator<double[]>() {
                public int compare(double[] s1, double[] s2) {
                        if (s1[0] > s2[0])
                            return -1;
                        else if (s1[0] < s2[0])
                            return 1;   
                        else {
                            return 0;
                        }
                    }
                });
                int limit;
                if(mulArr.length>10){
                    limit = 10;
                }else{
                    limit = mulArr.length;
                }
                for(int i=0;i<limit;i++){
                %>Input Page-<%=(int)mulArr[i][1]%> --> Archive Page-<%=(int)mulArr[i][2]%> [Similar]<br/><%
                individualResults.add("Input Page-" + (int)mulArr[i][1]);
                individualResults.add("-->");
                individualResults.add("Archive Page-" + (int)mulArr[i][2]);
                individualResults.add("[Similar]");
                //individualResults.add("[" + df.format(mulArr[i][0]) + "%" + "]");
}

    request.getSession().setAttribute("individualResults", individualResults);
    request.getSession().setAttribute("values", values);
                            %>
                            <br/><a href="individualReport.jsp?title=<%=title%>&author=<%=author%>&dept=<%=dept%>&uni=<%=uni%>&year=<%=year%>" class="btn btn-default">Generate Detailed Report</a><br><br>
                            <%
                                FileUtils.cleanDirectory(dataDir);
                                FileUtils.cleanDirectory(dataDir2);
                            %>
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



<%@page import="com.plagiar.entities.PathsPlagiar"%>
<%@page import="com.itextpdf.text.pdf.PdfPCell"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="com.plagiar.PlagiarRemote"%>
<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.pdf.CMYKColor"%>
<%@page import="com.itextpdf.text.FontFactory"%>
<%@ page import="com.itextpdf.text.Font" %>

<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="com.itextpdf.text.DocumentException" %>
<%@ page import="com.itextpdf.text.Paragraph" %>
<%@ page import="com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import="com.itextpdf.text.Document" %>
<%@ page import="java.io.FileOutputStream" %>
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
                            <h3>Report Generated!</h3>
                            <%
                                PlagiarRemote plagiarRemote = null;

                                try {
                                    Context context = new InitialContext();
                                    plagiarRemote = (PlagiarRemote) context.lookup(PlagiarRemote.class.getName());

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                List<String> values = (List<String>) request.getSession().getAttribute("valueslist");

                                String inputTitle = request.getParameter("title");
                                String author = request.getParameter("author");
                                String dept = request.getParameter("dept");
                                String uni = request.getParameter("uni");
                                String year = request.getParameter("year");
                                System.out.println(inputTitle);
                                Document document = new Document();
                                PathsPlagiar reportPath = plagiarRemote.getDirectoryPath("ReportsPath");
                                String path = reportPath.getPath();
                                try {
                                    PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(path + inputTitle + "_Result" + ".pdf"));
                                    document.open();
                                    Font boldFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 15);
                                    Font defaultFont = FontFactory.getFont(FontFactory.TIMES_ROMAN, 12);
                                    Paragraph title = new Paragraph("Plagiar Report", boldFont);
                                    title.setAlignment(Element.ALIGN_CENTER);
                                    document.add(title);
                                    Paragraph newline = new Paragraph(" ");
                                    document.add(newline);
                                    document.add(new Paragraph("Input Document Information", defaultFont));

                                    PdfPTable table = new PdfPTable(2); 
                                    table.setWidthPercentage(100); 
                                    table.setSpacingBefore(10f); 
                                    table.setSpacingAfter(10f); 
                                    
                                    float[] columnWidths = {1f, 1f};
                                    table.setWidths(columnWidths);

                                    Font boldFont2 = FontFactory.getFont(FontFactory.TIMES_BOLD, 12);
                                    Paragraph head1 = new Paragraph("Title", boldFont2);
                                    PdfPCell cell1 = new PdfPCell(head1);
                                    PdfPCell cell2 = new PdfPCell(new Paragraph("" + inputTitle, defaultFont));

                                    Paragraph head2 = new Paragraph("Author", boldFont2);
                                    PdfPCell cell3 = new PdfPCell(head2);
                                    PdfPCell cell4 = new PdfPCell(new Paragraph("" + author, defaultFont));

                                    Paragraph head3 = new Paragraph("Department", boldFont2);
                                    PdfPCell cell5 = new PdfPCell(head3);
                                    PdfPCell cell6 = new PdfPCell(new Paragraph("" + dept, defaultFont));

                                    Paragraph head4 = new Paragraph("University", boldFont2);
                                    PdfPCell cell7 = new PdfPCell(head4);
                                    PdfPCell cell8 = new PdfPCell(new Paragraph("" + uni, defaultFont));

                                    Paragraph head5 = new Paragraph("Year", boldFont2);
                                    PdfPCell cell9 = new PdfPCell(head5);
                                    PdfPCell cell10 = new PdfPCell(new Paragraph("" + year, defaultFont));

                                    table.addCell(cell1);
                                    table.addCell(cell2);
                                    table.addCell(cell3);
                                    table.addCell(cell4);
                                    table.addCell(cell5);
                                    table.addCell(cell6);
                                    table.addCell(cell7);
                                    table.addCell(cell8);
                                    table.addCell(cell9);
                                    table.addCell(cell10);

                                    document.add(table);

                                    document.add(new Paragraph("Plagiarism Detection Information", defaultFont));

                                    PdfPTable table2 = new PdfPTable(4); 
                                    table2.setWidthPercentage(100); 
                                    table2.setSpacingBefore(10f); 
                                    table2.setSpacingAfter(10f); 
                                    
                                    float[] columnWidths2 = {1f, 1f, 1f, 1f};
                                    table2.setWidths(columnWidths2);

                                    Paragraph tablehead1 = new Paragraph("Title", boldFont2);
                                    PdfPCell newcell = new PdfPCell(tablehead1);

                                    Paragraph tablehead2 = new Paragraph("Author", boldFont2);
                                    PdfPCell newcell2 = new PdfPCell(tablehead2);

                                    /*Paragraph tablehead3 = new Paragraph("Department", boldFont2);
                                    PdfPCell newcell3 = new PdfPCell(tablehead3);

                                    Paragraph tablehead4 = new Paragraph("University", boldFont2);
                                    PdfPCell newcell4 = new PdfPCell(tablehead4);*/

                                    Paragraph tablehead5 = new Paragraph("Year", boldFont2);
                                    PdfPCell newcell5 = new PdfPCell(tablehead5);

                                    Paragraph tablehead6 = new Paragraph("Plagiarism", boldFont2);
                                    PdfPCell newcell6 = new PdfPCell(tablehead6);

                                    table2.addCell(newcell);
                                    table2.addCell(newcell2);
                                    //table2.addCell(newcell3);
                                    //table2.addCell(newcell4);
                                    table2.addCell(newcell5);
                                    table2.addCell(newcell6);

                                    PdfPCell cell[] = new PdfPCell[1000];
                                    for (int i = 0; i < values.size(); i++) {
                                        //System.out.println(titleList.get(i));
                                        cell[i] = new PdfPCell(new Paragraph("" + values.get(i), defaultFont));
                                        table2.addCell(cell[i]);
                                    }

                                    document.add(table2);

                                    document.add(new Paragraph("*****This is a computer generated report.*****", defaultFont));

                                    document.close();
                                    writer.close();
                                } catch (DocumentException e) {
                                    e.printStackTrace();
                                } catch (FileNotFoundException e) {
                                    e.printStackTrace();
                                }
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

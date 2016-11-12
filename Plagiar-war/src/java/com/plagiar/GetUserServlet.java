/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plagiar;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetUserServlet")
public class GetUserServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //String text = "Update successfull"; //message you will recieve 
        String name = request.getParameter("university");
        //PrintWriter out = response.getWriter();
        
        //String htmlRespone = name;
        
        request.setAttribute("text", name);
        request.getRequestDispatcher("createCategory.jsp").forward(request,response);
        
        //out.print(htmlRespone);
    }
}

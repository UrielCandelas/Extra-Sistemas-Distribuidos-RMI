/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import javax.servlet.RequestDispatcher;

import server.UserSystemInfo;
import server.SystemInfoInterface;

/**
 *
 * @author UrielC
 */
public class FirstServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            Registry registry = LocateRegistry.getRegistry("localhost", 4000);
            SystemInfoInterface info = (SystemInfoInterface) registry.lookup("Info");
            List<String> objetos = info.getData();
            request.setAttribute("users", objetos);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder stringBuilder = new StringBuilder();
        String clientIpAddress = request.getRemoteAddr();

        String line;
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
        }

        // Convertir la cadena JSON a objetos Java, si es aplicable
        String jsonString = stringBuilder.toString();
        ObjectMapper objectMapper = new ObjectMapper();

        UserSystemInfo datos = objectMapper.readValue(jsonString, UserSystemInfo.class);

        datos.setIpAddress(clientIpAddress);
        /*long memoryInfoTotal = datos.getMemoryInfoTotal();
        long memoryInfoUsed = datos.getMemoryInfoUsed();
        int processorInfo = datos.getProcessorInfo();
        int usedSpace = datos.getUsedSpace();*/
        try {
            Registry registry = LocateRegistry.getRegistry("localhost", 4000);
            SystemInfoInterface info = (SystemInfoInterface) registry.lookup("Info");
            info.addData(datos);
            //String [] allData = info.getData();
        } catch (Exception e) {
            e.printStackTrace();
        }

        //System.out.println("Datos recibidos en formato JSON: " + jsonString);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}

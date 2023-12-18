<%-- 
    Document   : index
    Created on : 13 dic 2023, 00:39:50
    Author     : UrielC
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Extra Sistemas Distribuidos</title>
        <link rel="stylesheet" href="./style/indexstyle.css">
        <link href="https://fonts.googleapis.com/css2?family=Afacad&family=Inter&display=swap" rel="stylesheet">
        <script type="text/javascript">
            function procesarLista(objetos) {
                let jsonArray = JSON.parse(objetos);

                for (let i = jsonArray.length - 1; i >= 0; i--) {
                    let jsonObject = jsonArray[i];

                    let atributo1 = jsonObject.ipAddress;
                    let atributo2 = jsonObject.memoryInfoTotal;
                    let atributo3 = jsonObject.memoryInfoUsed;
                    let atributo4 = jsonObject.processorInfo;
                    let atributo5 = jsonObject.usedSpace;

                    document.write("<ul>");
                    document.write("<li>Direccion IP: " + atributo1 + "</li>");
                    document.write("<li>Memoria total del navegador: " + atributo2 + " bytes" + "</li>");
                    document.write("<li>Espacio disponible en la memoria del navegador: " + atributo3 + " bytes" + "</li>");
                    document.write("<li>Número de procesadores disponibles: " + atributo4 + "</li>");
                    document.write("<li>Espacio utilizado en localStorage: " + atributo5 + " bytes" +"</li>");
                    document.write("</ul>");
                    document.write("<hr>");
                }
            }
        </script>
    </head>
    <body>
        <h1>Informacion de los Sistemas</h1>
        <h2>Mi sistema</h2>
        <ul>
            <li id="memoryTotal"></li>
            <li id="memoryUsed"></li>
            <li id="processorInfo"></li>
            <li id="localstorage"></li>
        </ul>
        <script>
            let memoryInfo = window.performance.memory;

            let memoryInfoTotal = memoryInfo.totalJSHeapSize;
            let memoryInfoUsed = memoryInfo.jsHeapSizeLimit;
            let processorInfo = navigator.hardwareConcurrency;
            let usedSpace = JSON.stringify(localStorage).length;

            const data = {
                memoryInfoTotal,
                memoryInfoUsed,
                usedSpace,
                processorInfo
            };
            fetch("/ClientRMI/FirstServlet", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            }).then(response => {
                if (!response.ok) {
                    throw new Error('Error al enviar la petición al servidor');
                }
                console.log('Petición enviada correctamente');
            }).catch(error => {
                console.error(error);
            });
            document.getElementById("memoryTotal").innerHTML = "Memoria total del navegador: " + memoryInfoTotal + " bytes";
            document.getElementById("memoryUsed").innerHTML = "Espacio disponible en la memoria del navegador: " + memoryInfoUsed + " bytes";
            document.getElementById("processorInfo").innerHTML = "Número de procesadores disponibles: " + processorInfo;
            document.getElementById("localstorage").innerHTML = "Espacio utilizado en localStorage: " + usedSpace + " bytes";
        </script>
        <h2>Sistemas que se han conectado a la red</h2>
        <%
            List< String> objetos = (List<String>) request.getAttribute("users");
            String jsonString = objetos != null ? objetos.toString() : "[]";
        %>
        <script type="text/javascript">
            procesarLista('<%= jsonString%>');
        </script>

    </body>
</html>

<%-- 
    Document   : index
    Created on : 13 dic 2023, 00:39:50
    Author     : UrielC
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Extra Sistemas Distribuidos</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/indexStyle.css">
        <link href="https://fonts.googleapis.com/css2?family=Afacad&family=Inter&display=swap" rel="stylesheet">
        <script>
            var socket = new WebSocket("ws://192.168.0.10:8080/ClientRMI/miwebsocket");

            socket.onopen = function (event) {
                // Manejar la apertura de la conexión WebSocket
            };

            socket.onmessage = function (event) {
                const data = JSON.parse(event.data);
                const atributo1 = data.ipAddress;
                const atributo2 = data.memoryInfoTotal;
                const atributo3 = data.memoryInfoUsed;
                const atributo4 = data.processorInfo;
                const atributo5 = data.usedSpace;

                let systemsDiv = document.getElementById("systems");

                let newList = document.createElement("ul");

                let newItem1 = document.createElement("li");
                newItem1.textContent = "Direccion IP: " + atributo1;

                let newItem2 = document.createElement("li");
                newItem2.textContent = "Memoria total del navegador: " + atributo2 + " bytes";

                let newItem3 = document.createElement("li");
                newItem3.textContent = "Espacio disponible en la memoria del navegador: " + atributo3 + " bytes";

                let newItem4 = document.createElement("li");
                newItem4.textContent = "Número de procesadores disponibles: " + atributo4;

                let newItem5 = document.createElement("li");
                newItem5.textContent = "Espacio utilizado en localStorage: " + atributo5 + " bytes";

                let newLine = document.createElement("hr");

                newList.appendChild(newItem1);
                newList.appendChild(newItem2);
                newList.appendChild(newItem3);
                newList.appendChild(newItem4);
                newList.appendChild(newItem5);

                systemsDiv.insertBefore(newLine, systemsDiv.firstChild);
                systemsDiv.insertBefore(newList, systemsDiv.firstChild);


            };

            socket.onclose = function (event) {
                // Manejar el cierre de la conexión WebSocket
            };
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
        <h2>Sistemas que se han conectado a la red</h2>
        <div id="systems"></div>
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
        <%
            List< String> objetos = (List<String>) request.getAttribute("users");
            String jsonString = objetos != null ? objetos.toString() : "[]";
        %>
        <script type="text/javascript">
            function procesarLista(objetos) {
                const jsonArray = JSON.parse(objetos);
                let content = "";
                for (let i = jsonArray.length - 1; i >= 0; i--) {
                    const jsonObject = jsonArray[i];

                    const atributo1 = jsonObject.ipAddress;
                    const atributo2 = jsonObject.memoryInfoTotal;
                    const atributo3 = jsonObject.memoryInfoUsed;
                    const atributo4 = jsonObject.processorInfo;
                    const atributo5 = jsonObject.usedSpace;
                    content += "<ul><li> Direccion IP: " + atributo1 + "</li><li>Memoria total del navegador: " + atributo2 + " bytes</li><li>Espacio disponible en la memoria del navegador: " + atributo3 + " bytes</li><li>Número de procesadores disponibles: " + atributo4 + "</li><li>Espacio utilizado en localStorage: " + atributo5 + " bytes</li></ul><hr>";
                    document.getElementById("systems").innerHTML = content;
                }
            }
        </script>
        <script type="text/javascript">
            procesarLista('<%= jsonString%>');
        </script>
    </body>
</html>
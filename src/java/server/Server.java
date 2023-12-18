/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package server;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

/**
 *
 * @author UrielC
 */
public class Server {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            System.out.println("Creando objeto SystemInfo");
            SystemInfo obj = new SystemInfo();

            System.out.println("Creando registro RMI en el puerto 4000");
            Registry registry = LocateRegistry.createRegistry(4000);

            System.out.println("Registrando objeto en el registro con nombre 'Info'");
            registry.rebind("Info", obj);

            System.out.println("Servidor RMI Iniciado en el puerto 4000");
            
            //System.out.println("Creando objeto WebSocketServer");
            //WebSocketServer serv = new WebSocketServer();
            
            //System.out.println("Iniciando servidor del WebSocket en el puerto 1234");
            //serv.startServer(); 
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

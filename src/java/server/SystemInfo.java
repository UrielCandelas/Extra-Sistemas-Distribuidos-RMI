/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package server;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 *
 * @author UrielC
 */
public class SystemInfo extends UnicastRemoteObject implements SystemInfoInterface {

    private List<UserSystemInfo> datos;
    private ObjectMapper objectMapper;

    public SystemInfo() throws RemoteException {
        super();
        datos = new ArrayList<>();
        objectMapper = new ObjectMapper();
    }

    @Override
    public void addData(UserSystemInfo dato) throws RemoteException {
        datos.add(dato);
    }

    @Override
    public List<String> getData() throws RemoteException {
        List<String> jsonArray = new ArrayList<>();
        for (UserSystemInfo userSystemInfo : datos) {
            try {
                String json = objectMapper.writeValueAsString(userSystemInfo);
                jsonArray.add(json);
            } catch (JsonProcessingException e) {
                throw new RemoteException("Error al convertir objeto a JSON", e);
            }
        }
        return jsonArray;
    }

    @Override
    public void deleteData(UserSystemInfo dato) throws RemoteException {
        datos.remove(dato);
    }
}

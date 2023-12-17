/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package server;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

/**
 *
 * @author UrielC
 */
public interface SystemInfoInterface extends Remote{
    List<String> getData() throws RemoteException;
    void addData(UserSystemInfo data) throws RemoteException;
    void deleteData(UserSystemInfo data) throws RemoteException;
}

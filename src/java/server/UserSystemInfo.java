/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package server;
import java.io.Serializable;

/**
 *
 * @author UrielC
 */
public class UserSystemInfo implements Serializable{
    private String ipAddress;
    private long memoryInfoTotal;
    private long memoryInfoUsed;
    private int processorInfo;
    private int usedSpace;

    public UserSystemInfo(String ipAddress, long memoryInfoTotal, long memoryInfoUsed, int usedSpace) {
        this.ipAddress = ipAddress;
        this.memoryInfoTotal = memoryInfoTotal;
        this.memoryInfoUsed = memoryInfoUsed;
        this.usedSpace = usedSpace;
    }

    public UserSystemInfo() {
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public long getMemoryInfoTotal() {
        return memoryInfoTotal;
    }

    public void setMemoryInfoTotal(long memoryInfoTotal) {
        this.memoryInfoTotal = memoryInfoTotal;
    }

    public long getMemoryInfoUsed() {
        return memoryInfoUsed;
    }

    public void setMemoryInfoUsed(long memoryInfoUsed) {
        this.memoryInfoUsed = memoryInfoUsed;
    }

    public int getProcessorInfo() {
        return processorInfo;
    }

    public void setProcessorInfo(int processorInfo) {
        this.processorInfo = processorInfo;
    }

    public int getUsedSpace() {
        return usedSpace;
    }

    public void setUsedSpace(int usedSpace) {
        this.usedSpace = usedSpace;
    }
    
}

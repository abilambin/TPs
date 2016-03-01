package UDP;

import java.net.*; 
import java.io.*;


public class ReceiveUDP {
	
    /**
     * @param args
     * @throws IOException 
     */
    public static void main(String[] args) throws IOException {
	
	DatagramSocket s; 
	DatagramPacket p; 
	
	s = new DatagramSocket(5251);
	p = new DatagramPacket(new byte[1024],1024);
	
	s.receive(p);
	System.out.println(new String(p.getData())); 
	
	s.close(); 
	
    }

}

package Tchat;

import java.net.*; 
import java.io.*;


public class ReceiveTchat {

		
	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		MulticastSocket s; 
		DatagramPacket p; 
		InetAddress dst = InetAddress.getByName("224.0.0.1");
		
		s = new MulticastSocket(7654);
		p = new DatagramPacket(new byte[1024],1024);
		
		s.joinGroup(dst);
		
		s.receive(p);
		String msg = new String(p.getData());
		System.out.println(msg); 
		
		s.close(); 

	}

}

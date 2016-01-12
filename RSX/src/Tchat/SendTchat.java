package Tchat;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.lang.String;


public class SendTchat {

	
	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		DatagramPacket p;
		DatagramSocket s;
		String message = args[0];
		
		InetAddress dst = InetAddress.getByName("224.0.0.1");
		int port = 7654;
		byte array[] = message.getBytes();
		
		p = new DatagramPacket(array, array.length, dst, port); 
		s = new MulticastSocket();
		
		s.send(p);
		s.close();
	}

}
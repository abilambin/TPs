package Multicast;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.lang.String;


public class SendM {

	
	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		DatagramPacket p;
		MulticastSocket s;
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
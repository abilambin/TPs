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
		
		s = new DatagramSocket(Integer.parseInt(args[0]));
		p = new DatagramPacket(new byte[1024],1024);
		
		s.receive(p);
		System.out.println(p.getData()); 
		
		s.close(); 

	}

}

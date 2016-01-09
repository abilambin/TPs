import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.lang.String;



public class SendUDP {

	
	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		DatagramPacket p;
		DatagramSocket s;
		String message = args[2];
		
		InetAddress dst = InetAddress.getByName(args[0]);
		int port = Integer.parseInt(args[1]);
		byte array[] = message.getBytes();
		
		p = new DatagramPacket(array, array.length, dst, port); 
		s = new DatagramSocket();
		
		s.send(p);
		s.close();
	}

}
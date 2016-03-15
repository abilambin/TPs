package DNS;

import java.io.*;
import java.net.*;
import java.util.*;

/*
 * envoi question DNS / reception reponse et affichage hexa rapide ...
 */

public class DNSsimpleModif
{
	
	public static byte[] stringToByte(String adresse){
		int cpt_char,i,cpt;
		cpt_char = 0;
		cpt = 0;
		byte[] res = new byte[adresse.length()+2];
		for(i=0; i<adresse.length(); i++){
			if (adresse.charAt(i) == '.'){
				if (cpt == 0){
					res[0] = (byte) i;
					cpt ++;
				}
				else{
					res[i-cpt_char+1] = (byte) cpt_char;
				}
				cpt_char = 0;
			}
			else{
				res[1+i] = (byte) Integer.parseInt(Integer.toHexString((int) adresse.charAt(i)),16);
			}
		}
		res[adresse.length()+1] = 0;
		return res;
	}
	
    public static void main(String[] args) 
    {
    byte[] adrT = stringToByte(args[0]);
	byte[] message = new byte[16+adrT.length];
		message[0] = (byte) 0x08;
		message[1] = (byte) 0xbb;  
		message[2] = (byte) 0x01;
		message[3] = (byte) 0x00;/* a) 12 octets d'entete : 1 Question et 0 Reponse/Auth/Add */
		message[4] = (byte) 0x00;
		message[5] = (byte) 0x01;
		message[6] = (byte) 0x00;
		message[7] = (byte) 0x00;
		message[8] = (byte) 0x00;
		message[9] = (byte) 0x00;
		message[10] = (byte) 0x00;
		message[11] = (byte) 0x00;
		for(int i=0; i < adrT.length; i++){
			message[i+12] = adrT[i];
		}
			  
			  /*(byte) 0x03, (byte) 0x77,  (byte) 0x77, (byte) 0x77,  /*b.1) Question : - QNAME  "3www4lifl2fr0"/
			  (byte) 0x04, (byte) 0x6c,  (byte) 0x69, (byte) 0x66,
			  (byte) 0x6c, (byte) 0x02,  (byte) 0x66, (byte) 0x72, (byte) 0x00,    */
			  
		message[11+adrT.length] = (byte) 0x00;
		message[11+adrT.length+1] = (byte) 0x01;                           /* b.2)            - QTYPE   "A"  1 : a host address */
		message[11+adrT.length+2] = (byte) 0x00;
		message[11+adrT.length+3] = (byte) 0x01;                         /* b.3)            - QCLASS  "IN" 1 : the Internet */
	
	
	/* 1) Get DNS server address ... by DNS ... (??!)  */
	System.err.print(" get inetaddress by name ... (on peut bien entendu mieux faire) ");
	InetAddress destination;
	try {
	    destination = InetAddress.getByName("193.49.225.15"/* ou 8.8.8.8 ou celui dans /etc/resolv.conf ... */);
	} catch (Exception e) {
	    System.err.println("[error] :" +  e.getMessage());
	    return;
	}
	System.err.println("[ok]");
	
	/* 2) creation d'un DatagramPacket pour l'envoi de la question DNS */
	System.err.println(" preparing  datagrampacket, message size : "+message.length);
	DatagramPacket dp = new DatagramPacket(message,message.length,destination,53);
	
	/* 3) creation d'un DatragramSocket (port au choix ) */
	System.err.print(" create datagram socket  ... ");
	DatagramSocket ds ;
	try {
	    ds = new DatagramSocket() ;
	} catch (Exception e) {
	    System.err.println("[error] :" +  e.getMessage());
	    return;
	}
	System.err.println("[ok]");
	
	/* 4) et envoi du packet */
	System.err.print(" send datagram ... ");
	try {
	    ds.send(dp);
	} catch (Exception e) {
	    System.err.println("[error] :" +  e.getMessage());
	    return;
	}
	System.err.println("[ok]");

	/* 5) reception du packet */
	dp = new DatagramPacket(new byte[512],512);
	System.err.print(" receive datagram ... ");
	try {
	    ds.receive(dp);
	} catch (Exception e) {
	    System.err.println("[error] :" +  e.getMessage());
	    return;
	}
	System.err.println("[ok]");
	
	/* affichage complet du packet recu (pas tres lisible ...) */
	byte[] rec = dp.getData();
	System.out.println("- message length : " + dp.getLength());
    System.out.println("- message : \n" + new String(rec, 0, dp.getLength()));
	
	/* affichage des bytes */
	for(int i = 0; i < dp.getLength(); i++) {
	    System.out.print(","+Integer.toHexString((rec[i])&0xff));
	    if ((i+1)%16 == 0)
		System.out.println("");
	}
	System.out.println("");
    }
}
    



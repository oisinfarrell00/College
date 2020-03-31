package cs.tcd.ie;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.Scanner;

import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;

/**
 *
 * Client class
 *
 * An instance accepts input from the user, marshalls this into a datagram,
 * sends it to a server instance and then waits for a reply. When a packet has
 * been received, the type of the packet is checked and if it is an
 * acknowledgement, a message is being printed and the waiting main method is
 * being notified.
 *
 */
public class CandC extends Node {
	static final int DEFAULT_SRC_PORT = 50000; // Port of the client
	static final int DEFAULT_DST_PORT = 50001; // Port of the server
	static final String DEFAULT_DST_NODE = "localhost"; // Name of the host for the server

	static final int HEADER_LENGTH = 2; // Fixed length of the header
	static final int TYPE_POS = 0; // Position of the type within the header
	static final byte WORKER = 0;
	static final byte CANDC = 1;
	static final byte BROKER = 3;

	static final byte TYPE_UNKNOWN = 0;

	static final byte TYPE_STRING = 1; // Indicating a string payload
	static final int LENGTH_POS = 1;

	static final byte TYPE_ACK = 2; // Indicating an acknowledgement
	static final int ACKCODE_POS = 1; // Position of the acknowledgement type in the header
	static final byte ACK_ALLOK = 10; // Inidcating that everything is ok

	Terminal terminal;
	InetSocketAddress dstAddress;
	SocketAddress CCAddress;

	/**
	 * Constructor
	 *
	 * Attempts to create socket at given port and create an InetSocketAddress for
	 * the destinations
	 */
	CandC(Terminal terminal, String dstHost, int dstPort, int srcPort) {
		try {
			this.terminal = terminal;
			dstAddress = new InetSocketAddress(dstHost, dstPort);
			socket = new DatagramSocket(srcPort);
			System.out.println(dstAddress);
			listener.go();
		} catch (java.lang.Exception e) {
		//	e.printStackTrace();
		}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		byte[] data;
		String content;
		byte[] buffer;
		data = packet.getData();
//		case TYPE_ACK:
//			terminal.println("Received ack");
//			this.notify();
//			break;

		data = packet.getData();
		switch (data[TYPE_POS]) {
		case BROKER:
			buffer = new byte[data[LENGTH_POS]];
			System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
			content = new String(buffer);
			if (content.equals("Y")) {
				terminal.println("Worker has accepted the job");
			}
			else if(content.equals("N")) {
				terminal.println("Worker has not accepted the job");
			}
			else {
				terminal.println("Worker Has not responded correctly");
			}
			terminal.println("Received ack");
			this.notify();
			break;
		default:
			//terminal.println("Unexpected packet" + packet.toString());
		}
	}

	/**
	 * Sender Method
	 *
	 */
	public synchronized void sendMessage() throws Exception {
		byte[] data = null;
		byte[] buffer = null;
		DatagramPacket packet = null;
		String input;

		input = terminal.read("Work Project: ");
		buffer = input.getBytes();
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = CANDC;
		data[LENGTH_POS] = (byte) buffer.length;
		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);

		terminal.println("Sending packet...");
		packet = new DatagramPacket(data, data.length);
		packet.setSocketAddress(dstAddress);
		socket.send(packet);
		terminal.println("Packet sent");
	}

	/**
	 * Test method
	 *
	 * Sends a packet to a given address
	 */
	public static void main(String[] args) {
		try {
			Terminal terminal = new Terminal("Command and Control");
			(new CandC(terminal, DEFAULT_DST_NODE, DEFAULT_DST_PORT, DEFAULT_SRC_PORT)).sendMessage();
			terminal.println("Program completed");
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sendAck(SocketAddress returnAddress) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void run() {
		// TODO Auto-generated method stub

	}

	@Override
	public void connectToServer() throws Exception {
		// TODO Auto-generated method stub

	}
}

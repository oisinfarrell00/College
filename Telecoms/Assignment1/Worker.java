package cs.tcd.ie;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.ArrayList;
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
public class Worker extends Node {
	static final int DEFAULT_SRC_PORT = 50002; // Port of the client
	static final int DEFAULT_DST_PORT = 50001; // Port of the server
	static final String DEFAULT_DST_NODE = "localhost"; // Name of the host for the server

	static final int HEADER_LENGTH = 2; // Fixed length of the header
	static final int TYPE_POS = 0; // Position of the type within the header
	static final byte WORKER = 0;
	static final byte CANDC = 1;
	static final byte BROKER = 3;

	static final int NO_OF_WORKERS = 2;

	static final byte TYPE_UNKNOWN = 0;

	static final byte TYPE_STRING = 1; // Indicating a string payload
	static final int LENGTH_POS = 1;

	static final byte TYPE_ACK = 2; // Indicating an acknowledgement
	static final int ACKCODE_POS = 1; // Position of the acknowledgement type in the header
	static final byte ACK_ALLOK = 10; // Inidcating that everything is ok

	Terminal terminal;
	InetSocketAddress dstAddress;
	static ArrayList <Worker> listOfWorkers = new ArrayList<Worker>();

	/**
	 * Constructor
	 *
	 * Attempts to create socket at given port and create an InetSocketAddress for
	 * the destinations
	 */
	Worker(Terminal terminal, String dstHost, int dstPort, int srcPort) {
		try {
			this.terminal = terminal;
			dstAddress = new InetSocketAddress(dstHost, dstPort);
			socket = new DatagramSocket(srcPort);
			listener.go();
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		String content;
		byte[] data;
		byte[] buffer;
		data = packet.getData();
		switch (data[TYPE_POS]) {
		case TYPE_ACK:
			terminal.println("Received ack");
			this.notify();
			break;
		case BROKER:
			buffer = new byte[data[LENGTH_POS]];
			System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
			content = new String(buffer);
			terminal.println("CandC Request: " + content);
			terminal.println("Would you like to accpet Y/N ");
			for (int i=0; i<listOfWorkers.size(); i++) {
				try {
					listOfWorkers.get(i).sendMessage();
					listener.go();
				} catch (Exception e) {
				}
			}
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
		input = terminal.read("Response: ");
		buffer = input.getBytes();
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = WORKER;
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
			Terminal terminal;
			
			for (int i = 0; i < NO_OF_WORKERS; i++) {
				terminal = new Terminal("Worker: " + (i+1));
				Worker worker = new Worker(terminal, DEFAULT_DST_NODE, DEFAULT_DST_PORT, (DEFAULT_SRC_PORT + i));
				listOfWorkers.add(worker);
				worker.connectToServer();
				
			}
			
			
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
		byte[] data = null;
		String register = "Register";
		byte[] buffer = register.getBytes();
		DatagramPacket packet = null;
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = WORKER;
		data[LENGTH_POS] = (byte) buffer.length;
		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
		packet = new DatagramPacket(data, data.length);
		packet.setSocketAddress(dstAddress);
		socket.send(packet);
		terminal.println("Packet sent");
		// this.wait();

	}
}

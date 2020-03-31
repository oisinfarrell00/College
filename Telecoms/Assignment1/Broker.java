package cs.tcd.ie;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.ArrayList;

//import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class Broker extends Node {
	static final int DEFAULT_PORT = 50001;

	static final int HEADER_LENGTH = 2;
	static final int TYPE_POS = 0;
	static final byte WORKER = 0;
	static final byte CANDC = 1;
	static final byte BROKER = 3;

	static final byte TYPE_UNKNOWN = 0;

	static final byte TYPE_STRING = 1;
	static final int LENGTH_POS = 1;

	static final byte TYPE_ACK = 2;
	static final int ACKCODE_POS = 1;
	static final byte ACK_ALLOK = 10;

	ArrayList<SocketAddress> availableWorkers = new ArrayList<SocketAddress>();
	Terminal terminal;
	InetSocketAddress dstAddress;
	String messageToSend;
	SocketAddress CandCAddress ;

	/*
	 * 
	 */
	Broker(Terminal terminal, int port) {
		try {
			this.terminal = terminal;
			socket = new DatagramSocket(port);
			listener.go();
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		try {
			String content;
			byte[] data;
			byte[] buffer;

			data = packet.getData();
			DatagramPacket response;
			switch (data[TYPE_POS]) {
			case WORKER:
				buffer = new byte[data[LENGTH_POS]];
				System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
				content = new String(buffer);
				
				data = new byte[HEADER_LENGTH];
				data[TYPE_POS] = TYPE_ACK;
				data[ACKCODE_POS] = ACK_ALLOK;
				response = new DatagramPacket(data, data.length);
				SocketAddress workerAddress = packet.getSocketAddress();
				if (isNewWorker( workerAddress)) {
					availableWorkers.add(workerAddress);
				}
				response.setSocketAddress(packet.getSocketAddress());
				if(content.equals("Register")) {
					terminal.println("worker "+ packet.getSocketAddress()+": Registered");

				}
				else if(content.equals("Quit")) {
					terminal.println("worker "+ packet.getSocketAddress()+": Quit");
					int indexToRemove = workersIndex(packet.getSocketAddress());
					availableWorkers.remove(indexToRemove);
				}
				else {
					terminal.println("worker Said: |" + content + "|");
					if(CandCAddress!=null) {
						reportToCandC(content);
					}
				}
				
				socket.send(response);
				break;

			case CANDC:
				buffer = new byte[data[LENGTH_POS]];
				System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
				content = new String(buffer);
				data = new byte[HEADER_LENGTH];
				data[TYPE_POS] = TYPE_ACK;
				data[ACKCODE_POS] = ACK_ALLOK;
				response = new DatagramPacket(data, data.length);
				response.setSocketAddress(packet.getSocketAddress());
				System.out.println(packet.getSocketAddress());
				CandCAddress = packet.getSocketAddress();
				socket.send(response);
				forwardMessage(content);
				break;
			default:
				terminal.println("Unexpected packet" + packet.toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public synchronized void start() throws Exception {
		terminal.println("Waiting for contact...");
		this.wait();
		
	}

	/*
	 * 
	 */
	public static void main(String[] args) {
		try {
			Terminal terminal = new Terminal("Broker");
			(new Broker(terminal, DEFAULT_PORT)).start();
			terminal.println("Program completed");
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}
	public int workersIndex(SocketAddress x) {
		for (int i = 0; i < availableWorkers.size(); i++) {
			if (availableWorkers.get(i).equals(x)) {
				return i;
			}
		}
		return -1;
		
	}

	public void sendMessage(String input) throws Exception {
		byte[] data = null;
		byte[] buffer = null;
		DatagramPacket packet = null;

		buffer = input.getBytes();
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = BROKER;
		data[LENGTH_POS] = (byte) buffer.length;
		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
		terminal.println("Sending packet...");
		SocketAddress workerAddress = null;
		if (availableWorkers != null) {
			packet = new DatagramPacket(data, data.length);
			System.out.println("Packet: " + packet);
			for (int i = 0; i < availableWorkers.size(); i++) {
				workerAddress = availableWorkers.get(i);
				packet.setSocketAddress((InetSocketAddress) workerAddress);
				socket.send(packet);
			}
		}
		terminal.println("Packet sent");
	}

	public void forwardMessage(String input) throws IOException, InterruptedException {
		byte[] data = null;
		byte[] content = null;
		DatagramPacket packet = null;

		content = input.getBytes();
		data = new byte[HEADER_LENGTH + content.length];
		data[TYPE_POS] = BROKER;
		data[LENGTH_POS] = (byte) content.length;
		System.arraycopy(content, 0, data, HEADER_LENGTH, content.length);
		terminal.println("Forwarding packet...");
		if (availableWorkers != null) {
			packet = new DatagramPacket(data, data.length);
			for (int i = 0; i < availableWorkers.size(); i++) {	
				SocketAddress workerAddress = availableWorkers.get(i);
				packet.setSocketAddress((InetSocketAddress) workerAddress);
				socket.send(packet);
			}
		}
		terminal.println("Packet sent");
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

	public boolean isNewWorker(SocketAddress x) {
		for (int i = 0; i < availableWorkers.size(); i++) {
			if (availableWorkers.get(i).equals(x)) {
				return false;
			}
		}
		return true;
	}


	@Override
	public void sendMessage() throws Exception {
		byte[] data = null;
		byte[] buffer = null;
		DatagramPacket packet = null;
		buffer = messageToSend.getBytes();
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = BROKER;
		data[LENGTH_POS] = (byte) buffer.length;
		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
		terminal.println("Sending packet...");
		packet = new DatagramPacket(data, data.length);
		for (int i = 0; i < availableWorkers.size(); i++) {
			dstAddress = (InetSocketAddress) availableWorkers.get(i);
			packet.setSocketAddress(dstAddress);
			socket.send(packet);
		}
		terminal.println("Packet sent");

	}
	
	public void reportToCandC(String x) {
		String report = "Register";
		if (x.equals("Y")) {
			report = "Y";
		}
		else if(x.equals("N")) {
			report = "N";
		}
		
		else {
			terminal.println("incorrect input");
		}
		byte[] data = null;
		
		byte[] buffer = report.getBytes();
		DatagramPacket packet = null;
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = BROKER;
		data[LENGTH_POS] = (byte) buffer.length;
		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
		packet = new DatagramPacket(data, data.length);
		packet.setSocketAddress((InetSocketAddress)CandCAddress);
		try {
			socket.send(packet);
		} catch (IOException e) {
		}
		terminal.println("Packet sent");
		// this.wait();
		
	}
	
}

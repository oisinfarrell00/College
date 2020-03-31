import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;

public class EndUser extends Node {
    Terminal terminal;
    InetSocketAddress dstAddress;
    InetSocketAddress myAddress;
    int dstPort;

    EndUser(Terminal terminal, String dstHost, int dstPort, int srcPort) {
        try {
            this.dstPort = dstPort;
            this.terminal = terminal;
            dstAddress = new InetSocketAddress(dstHost, dstPort);
            socket = new DatagramSocket(srcPort);
            this.myAddress = new InetSocketAddress(dstHost, srcPort);
            listener.go();
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }
    public synchronized void onReceipt(DatagramPacket packet) {
        try {
            String content;
            byte[] data;
            byte[] buffer;
            data = packet.getData();
            buffer = new byte[data[LENGTH_POS]];
            System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
            content = new String(buffer);
            terminal.println("EndUser: " + content);
            this.notify();
        } catch (java.lang.Exception e) {
            System.out.println("problem here");
        }
    }

    public void sendMessage() throws Exception {
        byte[] data = null;
        byte[] buffer = null;
        DatagramPacket packet = null;
        String input;
        input = terminal.read("Message: ");
        buffer = input.getBytes();
        data = new byte[HEADER_LENGTH + buffer.length];
        if (this.myAddress.equals(new InetSocketAddress(LOCAL_HOST, END_USER1_ADDRESS))) {
            data[TYPE_POS] = END_USER;
        } else {
            data[TYPE_POS] = END_USER2;
        }
        data[LENGTH_POS] = (byte) buffer.length;
        System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
        terminal.println("Sending packet...");
        packet = new DatagramPacket(data, data.length);
        System.out.println("End user is sending to "+this.dstPort);
        InetSocketAddress router1 = new InetSocketAddress("localhost", this.dstPort);
        packet.setSocketAddress(router1);
        socket.send(packet);
        terminal.println("Packet sent");
    }

    public static void main(String[] args) {
        try {
            Terminal terminal, terminal2;
            terminal = new Terminal("EndUser: " + (1));
            EndUser endUser = new EndUser(terminal, LOCAL_HOST, ROUTER1_ADDRESS, (END_USER1_ADDRESS));
            terminal2 = new Terminal("EndUser: " + (2));
            EndUser endUser1 = new EndUser(terminal2, LOCAL_HOST, ROUTER4_ADDRESS, (END_USER2_ADDRESS));
            while (true) {
                endUser.sendMessage();
                endUser1.sendMessage();
            }
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }
}
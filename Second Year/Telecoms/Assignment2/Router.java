
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.util.regex.Pattern;

public class Router extends Node {

    Terminal terminal;
    String dstHost;
    FlowTable routerFlowTable;
    boolean req;
    static String message;
    static int endPoint;

    Router(Terminal terminal, int srcPort, String dstHost) {
        try {
            routerFlowTable = new FlowTable();
            this.terminal = terminal;
            this.req=false;
            socket = new DatagramSocket(srcPort);
            this.dstHost = dstHost;
            listener.go();

        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    public synchronized void onReceipt(DatagramPacket packet) {
        try {
            byte[] data;
            byte[] buffer;
            data = packet.getData();
            switch (data[TYPE_POS]) {
                case END_USER:
                    endPoint=END_USER2_ADDRESS;
                    data = packet.getData();
                    buffer = new byte[data[LENGTH_POS]];
                    System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
                    message = new String(buffer);
                    if (!this.req) {
                        terminal.println("Contacting Controller");
                        sendReq();
                        this.req = true;
                    }
                    break;
                case END_USER2:
                    endPoint=END_USER1_ADDRESS;
                    data = packet.getData();
                    buffer = new byte[data[LENGTH_POS]];
                    System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
                    message = new String(buffer);
                    if (!this.req) {
                        terminal.println("Contacting Controller");
                        sendReq();
                        this.req = true;
                    }
                        System.out.println("sending to: "+routerFlowTable.flowTable.get(1).out);
                        sendMessage(  routerFlowTable.flowTable.get(1).out);
                    break;
                case CONTROLLER:
                    terminal.println("Received from Controller");
                    buffer = new byte[data[LENGTH_POS]];
                    System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
                    String information = new String(buffer);
                    String[] flowTableInfo = information.split(Pattern.quote("/"));
                    int dest, in, out;
                    int index = 0;
                    while (index < flowTableInfo.length) {
                        dest = Integer.parseInt(flowTableInfo[index]);
                        in = Integer.parseInt(flowTableInfo[index + 1]);
                        out = Integer.parseInt(flowTableInfo[index + 2]);
                        routerFlowTable.addHop(dest, in, out);
                        index += NO_OF_ELEMENTS;
                    }

                    if (endPoint == END_USER2_ADDRESS) {
                        sendMessage( routerFlowTable.flowTable.get(0).out);
                    } else if (endPoint == END_USER1_ADDRESS) {
                        sendMessage(  routerFlowTable.flowTable.get(1).out);
                    }

                    break;
                case ROUTER:
                    if (!this.req) {
                        terminal.println("Contacting Controller");
                        sendReq();
                        this.req = true;
                    }
                    if (endPoint == END_USER2_ADDRESS) {
                        sendMessage(routerFlowTable.flowTable.get(0).out);
                    } else if (endPoint == END_USER1_ADDRESS) {
                        System.out.println(routerFlowTable.flowTable.get(1).out);
                        sendMessage(routerFlowTable.flowTable.get(1).out);
                    }
                    break;
                default:
                    terminal.println("Unexpected packet" + packet.toString());
            }

        } catch (Exception e) {

        }
    }

    public static void main(String[] args) {
        try {
            Terminal terminal1 = new Terminal("Router 1");
            Terminal terminal2 = new Terminal("Router 2");
            Terminal terminal3 = new Terminal("Router 3");
            Terminal terminal4 = new Terminal("Router 4");

            Router r1 = new Router(terminal1, ROUTER1_ADDRESS, LOCAL_HOST);
            Router r2 = (new Router(terminal2, ROUTER2_ADDRESS, LOCAL_HOST));
            Router r3 = (new Router(terminal3, ROUTER3_ADDRESS, LOCAL_HOST));
            Router r4 = (new Router(terminal4, ROUTER4_ADDRESS, LOCAL_HOST));
            r1.connectToServer();
            r2.connectToServer();
            r3.connectToServer();
            r4.connectToServer();

        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    public void connectToServer() throws Exception {
        terminal.println("Connecting to server...");
        byte[] data = null;
        byte[] buffer = null;
        DatagramPacket packet = null;
        String input;
        input = "Hello World";
        buffer = input.getBytes();
        data = new byte[HEADER_LENGTH + buffer.length];
        data[TYPE_POS] = CONNECT_MESSAGE;
        data[LENGTH_POS] = (byte) buffer.length;
        System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
        packet = new DatagramPacket(data, data.length);
        InetSocketAddress controllerAddress = new InetSocketAddress("localhost", CONTROLLER_ADDRESS);
        packet.setSocketAddress(controllerAddress);
        socket.send(packet);
        terminal.println("Connected");
    }

    public void sendReq() throws Exception {
        byte[] data = null;
        byte[] buffer = null;
        DatagramPacket packet = null;
        String input;
        input = "Send Information";
        buffer = input.getBytes();
        data = new byte[HEADER_LENGTH + buffer.length];
        data[TYPE_POS] = FEATURE_REQ;
        data[LENGTH_POS] = (byte) buffer.length;
        System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
        packet = new DatagramPacket(data, data.length);
        InetSocketAddress controllerAddress = new InetSocketAddress("localhost", CONTROLLER_ADDRESS);
        packet.setSocketAddress(controllerAddress);
        socket.send(packet);
    }

    public void sendMessage(int address) throws IOException { // happens infinitely on the way back
        terminal.println("Forwarding message to: "+address);
        byte[] data = null;
        byte[] buffer = null;
        DatagramPacket packet = null;
        buffer = message.getBytes();
        data = new byte[HEADER_LENGTH + buffer.length];
        data[TYPE_POS] = ROUTER;
        data[LENGTH_POS] = (byte) buffer.length;
        System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
        packet = new DatagramPacket(data, data.length);
        InetSocketAddress router = new InetSocketAddress("localhost", address);
        packet.setSocketAddress(router);
        socket.send(packet);
    }
}



import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;

public class Controller extends Node {
    static final int TYPE_POS = 0;
    private ControlFlowTable controllerFlowTable;
    Terminal terminal;

    Controller(Terminal terminal, int port) {
        try {
            this.controllerFlowTable = new ControlFlowTable();
            controllerFlowTable.addRoute(END_USER1_ADDRESS, END_USER2_ADDRESS);
            controllerFlowTable.addRoute(END_USER2_ADDRESS, END_USER1_ADDRESS);
            this.terminal = terminal;
            socket = new DatagramSocket(port);
            listener.go();
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public synchronized void onReceipt(DatagramPacket packet) {
        try {
            byte[] data;
            data = packet.getData();
            switch (data[TYPE_POS]) {
                case FEATURE_REQ:
                    FlowTable temp = fillTables(packet.getPort());
                    String information = FlowTable.toString(temp);
                    sendMessage(packet.getPort(), information);
                    break;
                case CONNECT_MESSAGE:
                    terminal.println("Router: " + ((packet.getPort())) + " Connected");
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

    public static void main(String[] args) {
        try {
            Terminal terminal = new Terminal("Controller");
            Controller controller = new Controller(terminal, CONTROLLER_ADDRESS);
            controller.start();
            terminal.println("Program completed");
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    public FlowTable fillTables(int port) {
        FlowTable flowTable = new FlowTable();
        int dest, in, out;
        for (int i = 0; i < this.controllerFlowTable.routes.size(); i++) {
            ControlFlowTable.Route route = controllerFlowTable.routes.get(i);
            for (int index = 0; index < route.hops.size(); index++) {
                if (route.hops.get(index).routerPort == port) {
                    in = route.hops.get(index).in;
                    out = route.hops.get(index).out;
                    dest = route.dest;
                    flowTable.addHop(dest, in, out);

                }
            }
        }
        return flowTable;
    }

    public void sendMessage(int x, String input) throws Exception {
        byte[] data = null;
        byte[] buffer = null;
        DatagramPacket packet = null;
        buffer = input.getBytes();
        data = new byte[HEADER_LENGTH + buffer.length];
        data[TYPE_POS] = CONTROLLER;
        data[LENGTH_POS] = (byte) buffer.length;
        System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);
        packet = new DatagramPacket(data, data.length);
        InetSocketAddress router1 = new InetSocketAddress("localhost", x);
        packet.setSocketAddress(router1);
        socket.send(packet);
    }
}

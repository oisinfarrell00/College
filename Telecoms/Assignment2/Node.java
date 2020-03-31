
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.util.concurrent.CountDownLatch;


public abstract class Node {
    static final int PACKET_SIZE = 65536;
    public final byte END_USER = 1;
    public final byte END_USER2 = 2;
    public final byte ROUTER = 3;
    public final byte FEATURE_REQ = 4;
    public final byte CONTROLLER = 5;
    public final byte CONNECT_MESSAGE = 2;
    static final String LOCAL_HOST = "localhost";
    static final int NO_OF_ELEMENTS = 3;
    public static final int END_USER1_ADDRESS = 50000;
    public static final int ROUTER1_ADDRESS = 50001;
    public static final int ROUTER2_ADDRESS = 50002;
    public static final int ROUTER3_ADDRESS = 50003;
    public static final int ROUTER4_ADDRESS = 50004;
    public static final int END_USER2_ADDRESS = 50005;
    public static final int CONTROLLER_ADDRESS = 50006;

    static final int HEADER_LENGTH = 2; // Fixed length of the header
    static final int TYPE_POS = 0; // Position of the type within the header
    static final int LENGTH_POS = 1;


    DatagramSocket socket;
    Listener listener;
    CountDownLatch latch;

    Node() {
        latch = new CountDownLatch(1);
        listener = new Listener();
        listener.setDaemon(true);
        listener.start();
    }

    public abstract void onReceipt(DatagramPacket packet);

    class Listener extends Thread {
        public void go() {
            latch.countDown();
        }

        public void run() {
            try {
                latch.await();

                while (true) {
                    DatagramPacket packet = new DatagramPacket(new byte[PACKET_SIZE], PACKET_SIZE);
                    socket.receive(packet);

                    onReceipt(packet);
                }
            } catch (Exception e) {
                if (!(e instanceof SocketException))
                    e.printStackTrace();
            }
        }
    }

    public static void sendPacket(DatagramPacket packet, Byte headerByte) {
//    	byte[] data = null;
//        byte[] buffer = null;
//        DatagramPacket packet = null;
//        String input;
//        input = terminal.read("Message: ");
//        buffer = input.getBytes();
//        data = new byte[HEADER_LENGTH + buffer.length];
    }

}
import java.util.ArrayList;
public class ControlFlowTable {
    ArrayList<Route> routes;

    ControlFlowTable() {
        routes = new ArrayList<>();
    }
    public void addRoute(int src, int dest) {
        Route route = new Route(src, dest);
        routes.add(route);
    }
    public class Route {

        ArrayList<Hop> hops = new ArrayList<Hop>();
        int src;
        int dest;

        Route(int srcPort, int destPort) {
            this.src = srcPort;
            this.dest = destPort;
            Hop one= null, two= null, three= null, four = null;
            if (srcPort == Node.END_USER1_ADDRESS) {
                one = new Hop(Node.ROUTER1_ADDRESS, Node.END_USER1_ADDRESS, Node.ROUTER2_ADDRESS);
                two = new Hop(Node.ROUTER2_ADDRESS, Node.ROUTER1_ADDRESS, Node.ROUTER3_ADDRESS);
                three = new Hop(Node.ROUTER3_ADDRESS, Node.ROUTER2_ADDRESS, Node.ROUTER4_ADDRESS);
                four = new Hop(Node.ROUTER4_ADDRESS, Node.ROUTER3_ADDRESS, destPort);

            } else if (srcPort == Node.END_USER2_ADDRESS) {
                one = new Hop(Node.ROUTER4_ADDRESS,  Node.END_USER2_ADDRESS, Node.ROUTER3_ADDRESS);
                two = new Hop(Node.ROUTER3_ADDRESS, Node.ROUTER4_ADDRESS, Node.ROUTER2_ADDRESS);
                three = new Hop(Node.ROUTER2_ADDRESS, Node.ROUTER3_ADDRESS, Node.ROUTER1_ADDRESS);
                four = new Hop(Node.ROUTER1_ADDRESS, Node.ROUTER2_ADDRESS, Node.END_USER1_ADDRESS);

            }
            hops.add(one);
            hops.add(two);
            hops.add(three);
            hops.add(four);
        }
    }

    public class Hop {
        int routerPort;
        int in;
        int out;

        Hop(int routerPort, int in, int out) {
            this.routerPort = routerPort;
            this.in = in;
            this.out = out;
        }
    }

    public String toString() {
        String message = "";
        for (int i = 0; i < this.routes.size(); i++) {
            message += (routes.get(i).dest + "/" + routes.get(i).src + "/");
        }
        return message;
    }
}

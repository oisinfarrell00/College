
import java.util.ArrayList;

public class FlowTable {
    ArrayList<Hop> flowTable;
    FlowTable() {
        flowTable = new ArrayList<Hop>();
    }
    class Hop {
        int destPort;
        int in;
        int out;

        Hop(int destPort, int in, int out) {
            this.destPort = destPort;
            this.in = in;
            this.out = out;

        }

    }

    public void addHop(int dest, int in, int out) {
        flowTable.add(new Hop(dest, in, out));
    }
    public Hop returnHop(int index){
        return flowTable.get(index);
    }
    public void addHop(Hop hop) {
        flowTable.add(hop);
    }

    public static String toString(FlowTable table) {
        String message = "";
        for (int i = 0; i < table.flowTable.size(); i++) {
            message += (table.flowTable.get(i).destPort + "/" + table.flowTable.get(i).in + "/"
                    + table.flowTable.get(i).out + "/");
        }
        //System.out.println(message);
        return message;
    }

}

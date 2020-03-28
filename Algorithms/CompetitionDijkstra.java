/*
 * A Contest to Meet (ACM) is a reality TV contest that sets three contestants at three random
 * city intersections. In order to win, the three contestants need all to meet at any intersection
 * of the city as fast as possible.
 * It should be clear that the contestants may arrive at the intersections at different times, in
 * which case, the first to arrive can wait until the others arrive.
 * From an estimated walking speed for each one of the three contestants, ACM wants to determine the
 * minimum time that a live TV broadcast should last to cover their journey regardless of the contestants’
 * initial positions and the intersection they finally meet. You are hired to help ACM answer this question.
 * You may assume the following:
 *     Each contestant walks at a given estimated speed.
 *     The city is a collection of intersections in which some pairs are connected by one-way
 * streets that the contestants can use to traverse the city.
 *
 * This class implements the competition using Dijkstra's algorithm
 */

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class CompetitionDijkstra {
    public static int numberOfStreets, numberOfIntersection, nodeA, nodeB, nodeC;
    double[][] adjTable;
       public static double [][] graphA, graphB, graphC;

    /**
     * @param filename: A filename containing the details of the city road network
     * @param sA, sB, sC: speeds for 3 contestants
    */
    CompetitionDijkstra (String filename, int sA, int sB, int sC) throws IOException {
        readFile(filename);
        initPlayers();
        for(int i=0; i< numberOfIntersection; i++){
            dijkstra(adjTable, i);
        }
        fillTables(sA,sB,sC);
    }

    public void fillTables(int sA, int sB, int sC){
        graphA = new double[numberOfIntersection][numberOfIntersection];
        graphB = new double[numberOfIntersection][numberOfIntersection];
        graphC = new double[numberOfIntersection][numberOfIntersection];
        for(int i=0; i < numberOfIntersection; i++){
            for(int j=0; j < numberOfIntersection; j++){
                graphA[i][j]=(adjTable[i][j]/sA);
                graphB[i][j]=adjTable[i][j]/sB;
                graphC[i][j]=adjTable[i][j]/sC;
            }
        }
    }


    int minDistance(double dist[], Boolean sptSet[])
    {
        double min = Integer.MAX_VALUE;
                int min_index = -1;
        for (int v = 0; v < numberOfIntersection; v++)
            if (sptSet[v] == false && dist[v] <= min) {
                min = dist[v];
                min_index = v;
            }
        return min_index;
    }

    void dijkstra(double graph[][], int src)
    {
        double dist[] = new double[numberOfIntersection]; // The output array. dist[i] will hold
        Boolean sptSet[] = new Boolean[numberOfIntersection];
        for (int i = 0; i < numberOfIntersection; i++) {
            dist[i] = Integer.MAX_VALUE;
            sptSet[i] = false;
        }
        dist[src] = 0;
        for (int count = 0; count < numberOfIntersection - 1; count++) {
            int u = minDistance(dist, sptSet);
            sptSet[u] = true;
            for (int v = 0; v < numberOfIntersection; v++) {
                if (!sptSet[v] && graph[u][v] != 0 && dist[u] != Integer.MAX_VALUE && dist[u] + graph[u][v] < dist[v]) {
                    dist[v] = dist[u] + graph[u][v];
                    dist[v] = dist[u] + graph[u][v];
                    double val = dist[v]*100;
                    val = Math.round(val);
                    dist[v] = val/100;
                }
            }
        }
        for(int i=0; i<numberOfIntersection; i++){
            adjTable[src][i]=dist[i];
        }
    }

    /**
    * @return int: minimum minutes that will pass before the three contestants can meet
     */
    public static int timeRequiredforCompetition() throws IOException {
        int speedA = 1;
        int speedB = 2;
        int speedC = 3;
        CompetitionDijkstra competitionDijkstra = new CompetitionDijkstra("tinyEWD.txt", speedA,speedB,speedC);
        int commonNode = getCommonNode(graphA, graphB, graphC);
        System.out.println("common: "+commonNode);
        double timeA = graphA[commonNode][nodeA];
        double timeB = graphB[commonNode][nodeB];
        double timeC = graphC[commonNode][nodeC];
        double showTime = getMaxDouble(timeA, timeB, timeC) * 1000;
        return (int)showTime;
    }

    public static void main(String[] args) throws IOException {
    int time = timeRequiredforCompetition();
    System.out.println("Total run time: "+time+" minutes");
    }

    public void initPlayers(){
        nodeA = (int)(Math.random()*(numberOfIntersection));
        nodeB = (int)(Math.random()*(numberOfIntersection));
        nodeC = (int)(Math.random()*(numberOfIntersection));
        while(nodeB == nodeA) {
            if (nodeB == nodeA) {
                nodeB = (int)(Math.random()*numberOfIntersection);
            }
        }
        while(nodeC == nodeA || nodeC == nodeB) {
            if (nodeC == nodeA || nodeC == nodeB) {
                nodeC = (int)(Math.random()*numberOfIntersection);
            }
        }
    }

    public void readFile(String file) throws FileNotFoundException, IOException {
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String street;
        int index = 0;
        numberOfIntersection = Integer.parseInt(reader.readLine());
        numberOfStreets = Integer.parseInt(reader.readLine());
        String[] streets = new String[numberOfStreets];
        while ((street = reader.readLine()) != null) {
            streets[index] = street;
            index++;
        }
        reader.close();
        createAdjacencyTable(streets);
    }

    public void createAdjacencyTable(String[] streets) {
        int src;
        int dst;
        double length;
        adjTable = new double[numberOfIntersection][numberOfIntersection];
        for(int i = 0; i < streets.length; i++) {
            String[] street = streets[i].split(" ");
            src = Integer.parseInt(street[0]);
            dst = Integer.parseInt(street[1]);
            length = Double.parseDouble(street[2]);
            adjTable[dst][src] = length;
        }
        //printAdjTable();
    }

    public static int getCommonNode(double[][] aTimeGraph, double[][] bTimeGraph, double[][] cTimeGraph) {
        double[] aTimes = new double[numberOfIntersection];
        double[] bTimes = new double[numberOfIntersection];
        double[] cTimes = new double[numberOfIntersection];
        for (int i = 0; i < numberOfIntersection; i++) {
            aTimes[i] = aTimeGraph[i][nodeA];
            bTimes[i] = bTimeGraph[i][nodeB];
            cTimes[i] = cTimeGraph[i][nodeC];
        }

        double minIndTime = Double.MAX_VALUE;
        int node = -1;

        for (int i = 0; i < numberOfIntersection; i++) {
            double a = aTimes[i];
            double b = bTimes[i];
            double c = cTimes[i];
            double indTime = getMaxDouble(a, b, c);
            if (indTime < minIndTime) {
                minIndTime = indTime;
                node = i;
            }
        }
        return node;
    }

    public static double getMaxDouble(double a, double b, double c) {
        double max = a;
        if (b > max)
            max = b;
        if (c > max)
            max = c;
        return max;
    }
}
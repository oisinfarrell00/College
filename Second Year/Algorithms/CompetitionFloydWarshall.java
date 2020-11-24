//package temp;
import java.io.*;
import java.util.*;

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
 * This class implements the competition using Floyd-Warshall algorithm
 */

public class CompetitionFloydWarshall {

	String filename = "";
	int sA = 0;
	int sB = 0;
	int sC = 0;
	int intersections = 0;
	int streets = 0;
	boolean valid = true;

	ArrayList<String> graphString = null;
	double[][] graph = null;

	/**
	 * @param filename: A filename containing the details of the city road network
	 * @param sA,       sB, sC: speeds for 3 contestants
	 */
	CompetitionFloydWarshall(String filename, int sA, int sB, int sC) {
		this.filename = filename;
		this.sA = sA;
		this.sB = sB;
		this.sC = sC;
		this.intersections = 0;
		this.streets = 0;
		this.graphString = new ArrayList<String>();
		parseFile(fileScanner(filename));
	}

	private Scanner fileScanner(String fileName) {
		try {
			Scanner fileScan = new Scanner(new File(fileName));
			return fileScan;
		} catch (Exception e) {
			valid = false;
			return null;
		}
	}

	private void parseFile(Scanner scannedFile) {
		if (valid) {
			graphString.clear();
			try {
				if (scannedFile.hasNextInt()) {
					this.intersections = scannedFile.nextInt();
				}
				if (scannedFile.hasNextInt()) {
					this.streets = scannedFile.nextInt();
					scannedFile.nextLine();
				}
				while (scannedFile.hasNextLine()) {
					graphString.add(scannedFile.nextLine());
				}
			} catch (Exception e) {
			}
		}
	}

	/**
	 * @return int: minimum minutes that will pass before the three contestants can
	 *         meet
	 */
	public int timeRequiredforCompetition() {
		if (!valid) {
			return -1;
		}
		if (this.intersections == 0) {
			return -1;
		}
		if ((sA > 100 || sA < 50) || (sB > 100 || sB < 50) || (sC > 100 || sC < 50)) {
			return -1;
		}

		int slowestSpeed = 0;
		if (this.sA < this.sB && this.sA < this.sC)
			slowestSpeed = sA;
		else if (this.sB < this.sA && this.sB < this.sC)
			slowestSpeed = this.sB;
		else
			slowestSpeed = this.sC;

		graph = createGraph();
		floydWarshall(graph, intersections);

		double maxDistance = 0;
		for (double[] array : graph) {
			for (double dist : array) {
				if (maxDistance < dist)
					maxDistance = dist;
			}
		}

		if (maxDistance == Double.POSITIVE_INFINITY)
			return -1;
		else
			return (int) Math.ceil((maxDistance * 1000) / slowestSpeed);
	}

	private double[][] createGraph() {
		double[][] graph = new double[this.intersections][this.intersections];

		for (int i = 0; i < this.intersections; i++) {
			for (int j = 0; j < this.intersections; j++) {
				graph[i][j] = Double.POSITIVE_INFINITY;
			}
		}
		for (int i = 0; i < this.intersections; i++) {
			graph[i][i] = 0;
		}

		for (int i = 0; (i < this.graphString.size()); i++) {
			Scanner lineReader = new Scanner(this.graphString.get(i));
			int street = lineReader.nextInt();
			int connectingStreet = lineReader.nextInt();
			double distance = lineReader.nextDouble();

			graph[street][connectingStreet] = distance;
			lineReader.close();
		}

		return graph;
	}

	private void floydWarshall(double[][] graph, int nodes) {
		for (int k = 0; k < nodes; k++) {
			for (int i = 0; i < nodes; i++) {
				for (int j = 0; j < nodes; j++) {
					if (graph[i][j] > graph[i][k] + graph[k][j]) {
						graph[i][j] = graph[i][k] + graph[k][j];
					}
				}
			}
		}
	}
}
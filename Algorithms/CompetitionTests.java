//package temp;
import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class CompetitionTests {

	/*
	 * Test Files 
	 * empty.txt - No intersections or streets
	 */

	@Test
	public void testDijkstraConstructor() {
		String valid = "tinyEWD.txt";
		String invalid = "empty.txt";

		int result1 = new CompetitionDijkstra("", 50, 50, 50).timeRequiredforCompetition();
		assertEquals("invalid filename should return -1", -1, result1);

		int result2 = new CompetitionDijkstra(valid, 100, 20, 60).timeRequiredforCompetition();
		assertEquals("too slow", -1, result2);

		int result3 = new CompetitionDijkstra(invalid, 60, 60, 50).timeRequiredforCompetition();
		assertEquals("no intersections or streets, fails", -1, result3);

		int result4 = new CompetitionDijkstra(valid, 50, 60, 70).timeRequiredforCompetition();
		assertEquals("valid file should return 38", 38, result4);

		int result5 = new CompetitionDijkstra(valid, 60, 50, 60).timeRequiredforCompetition();
		assertEquals("Valid, b as slowest", 38, result5);

		int result6 = new CompetitionDijkstra(valid, 60, 60, 50).timeRequiredforCompetition();
		assertEquals("valid, c as slowest", 38, result6);
	}

	@Test
	public void testFWConstructor() {
		String valid = "tinyEWD.txt";
		String invalid = "empty.txt";

		int result1 = new CompetitionFloydWarshall("", 50, 50, 50).timeRequiredforCompetition();
		assertEquals("invalid filename should return -1", result1, -1);

		int result2 = new CompetitionFloydWarshall(valid, 100, 20, 60).timeRequiredforCompetition();
		assertEquals("too slow", -1, result2);

		int result3 = new CompetitionFloydWarshall(invalid, 60, 60, 50).timeRequiredforCompetition();
		assertEquals("no intersections, fails", -1, result3);

		int result4 = new CompetitionFloydWarshall(valid, 50, 60, 70).timeRequiredforCompetition();
		assertEquals("valid file should return 38", 38, result4);

		int result5 = new CompetitionFloydWarshall(valid, 60, 50, 60).timeRequiredforCompetition();
		assertEquals("Valid, b as slowest", 38, result5);

		int result6 = new CompetitionFloydWarshall(valid, 60, 60, 50).timeRequiredforCompetition();
		assertEquals("valid, c as slowest", 38, result6);
	}
}
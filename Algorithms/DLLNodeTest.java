package lab2;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//import lab2.DoublyLinkedList.DLLNode;

//-------------------------------------------------------------------------
/**
 * Test class for Doubly Linked List
 *
 * @author
 * @version 13/10/16 18:15
 */
@RunWith(JUnit4.class)
public class DLLNodeTest {
	// ~ Constructor ........................................................
	@Test
	public void testConstructor() {
		new DoublyLinkedList<Integer>();
	}

	// ~ Public Methods ........................................................

	// ----------------------------------------------------------
	/**
	 * Check if the insertBefore works
	 */
	@Test
	public void testInsertBefore() {
		// test non-empty list
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);

		testDLL.insertBefore(0, 4);
		assertEquals("Checking insertBefore to a list containing 3 elements at position 0", "4,1,2,3",
				testDLL.toString());
		testDLL.insertBefore(1, 5);
		assertEquals("Checking insertBefore to a list containing 4 elements at position 1", "4,5,1,2,3",
				testDLL.toString());
		testDLL.insertBefore(2, 6);
		assertEquals("Checking insertBefore to a list containing 5 elements at position 2", "4,5,6,1,2,3",
				testDLL.toString());
		testDLL.insertBefore(-1, 7);
		assertEquals(
				"Checking insertBefore to a list containing 6 elements at position -1 - expected the element at the head of the list",
				"7,4,5,6,1,2,3", testDLL.toString());
		testDLL.insertBefore(7, 8);
		assertEquals(
				"Checking insertBefore to a list containing 7 elemenets at position 8 - expected the element at the tail of the list",
				"7,4,5,6,1,2,3,8", testDLL.toString());
		testDLL.insertBefore(700, 9);
		assertEquals(
				"Checking insertBefore to a list containing 8 elements at position 700 - expected the element at the tail of the list",
				"7,4,5,6,1,2,3,8,9", testDLL.toString());

		// test empty list
		testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertBefore(0, 1);
		assertEquals(
				"Checking insertBefore to an empty list at position 0 - expected the element at the head of the list",
				"1", testDLL.toString());
		testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertBefore(10, 1);
		assertEquals(
				"Checking insertBefore to an empty list at position 10 - expected the element at the head of the list",
				"1", testDLL.toString());
		testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertBefore(-10, 1);
		assertEquals(
				"Checking insertBefore to an empty list at position -10 - expected the element at the head of the list",
				"1", testDLL.toString());
	}

	@Test
	public void testIsEmpty() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		assertTrue("Checking isEmpty()", testDLL.isEmpty());

	}

	@Test
	public void testGet() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
//    	 	testDLL.insertAtStart(1);
//    	 	testDLL.insertAtEnd(3);
//    	 	testDLL.insertAtEnd(4);
		assertEquals("check", Integer.valueOf(2), testDLL.get(0));
	}

	@Test
	public void testInsertFirst() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(4);
		assertEquals("", "4", testDLL.toString());
	}

	@Test
	public void testInsertAtStart() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(4);
		testDLL.insertAtStart(5);
		assertEquals("", "5,4", testDLL.toString());
	}

	@Test
	public void testInsertAtEnd() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);

		assertEquals("", "1,2,3", testDLL.toString());

	}

	@Test
	public void testDeleteAt() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.deleteAt(1);
		assertEquals("", "1,3,4", testDLL.toString());
	}

	@Test
	public void testDeleteOnlyNode() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.deleteOnlyNode();
		assertEquals("", "", testDLL.toString());
	}

	@Test
	public void testDeleteFirstNode() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.deleteFirstNode();
		assertEquals("", "2,3,4", testDLL.toString());
	}

	@Test
	public void testDeleteLastNode() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.deleteLastNode();
		assertEquals("", "1,2,3", testDLL.toString());
	}

	@Test
	public void testReverse() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.reverse();
		assertEquals("", "4,3,2,1", testDLL.toString());
	}

	@Test
	public void testMakeUnique() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtEnd(1);
		testDLL.insertAtEnd(2);
		testDLL.insertAtEnd(1);
		testDLL.insertAtEnd(1);
		testDLL.insertAtEnd(2);
		testDLL.insertAtEnd(1);
		testDLL.makeUnique();
		assertNull("", testDLL.get(4));
	}

	@Test
	public void testPush() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.push(5);
		assertEquals("", "5,1,2,3,4", testDLL.toString());
	}

	@Test
	public void testPop() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(100);
//   	 	testDLL.insertAtStart(1);
//   	 	testDLL.insertAtEnd(3);
//   	 	testDLL.insertAtEnd(4);
		testDLL.pop();
		assertEquals("", Integer.valueOf(100), testDLL.pop());
	}

	@Test
	public void testEnqueue() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.enqueue(5);
		assertEquals("", "5,1,2,3,4", testDLL.toString());
	}

	@Test
	public void testDequeue() {
		DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertFirst(2);
		testDLL.insertAtStart(1);
		testDLL.insertAtEnd(3);
		testDLL.insertAtEnd(4);
		testDLL.dequeue();
		assertEquals("", "1,2,3", testDLL.toString());
	}

}

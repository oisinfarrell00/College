package assignment3;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//-------------------------------------------------------------------------
/**
 * Test class for Doubly Linked List
 *
 * @version 3.1 09/11/15 11:32:15
 *
 * @author TODO
 */

@RunWith(JUnit4.class)

public class BSTTest {
	
	@Test
	public void testMedian() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		assertNull("", bst.median());
		bst.put(7, 7); 
		bst.put(8, 8); 
		bst.put(9, 9); 
		assertEquals(Integer.valueOf(8), bst.median());
		bst = new BST<Integer, Integer>();
		bst.put(3, 3); 
		bst.put(2, 2); 
		bst.put(1, 1); 
		assertEquals(Integer.valueOf(2), bst.median());
	}
	
	@Test
	public void testGet() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		assertNull("", bst.get(0));
		bst.put(7, 7); 
		bst.put(8, 8); 
		bst.put(9, 9);
		bst.put(6, 6);
		assertEquals(Integer.valueOf(8), bst.get(8));
		assertEquals(Integer.valueOf(6), bst.get(6));
		
	}
	
	@Test
	public void testPut() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		bst.put(7, 7); 
		bst.put(8, 8); 
		bst.put(9, 9); 
		bst.put(10, null);
		assertEquals("(()7(()8(()9())))", bst.printKeysInOrder());
		
		
	}
	
	@Test
	public void testContains() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		assertFalse("", bst.contains(0));
		bst.put(7, 7); 
		bst.put(8, 8); 
		bst.put(9, 9); 
		assertTrue("", bst.contains(8));
		
	}
	
	
	
	 
	
	@Test
	public void testHeight() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		assertEquals(-1, bst.height());
		bst.put(7, 7); // _7_
		assertEquals(0, bst.height());
		bst.put(8, 8); // / \
		bst.put(3, 3); // _3_ 8
		bst.put(1, 1); // / \
		bst.put(2, 2); // 1 6
		bst.put(6, 6); // \ /
		bst.put(4, 4); // 2 4
		bst.put(5, 5); // \
		assertEquals(4, bst.height());

	}
	
	@Test
	public void testPrint() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		assertEquals("()", bst.printKeysInOrder());
		bst.put(7, 7); 
		bst.put(8, 8); 
		bst.put(6, 6);
		bst.put(9, 9);
		assertEquals("((()6())7(()8(()9())))", bst.printKeysInOrder());
	}
	



	@Test
	public void testPrettyPrint() {
		 BST<Integer, Integer> bst = new BST<Integer, Integer>();
	     assertEquals("Checking pretty printing of empty tree",
	             "-null\n", bst.prettyPrintKeys());
	      
	                          //  -7
	                          //   |-3
	                          //   | |-1
	                          //   | | |-null
	     bst.put(7, 7);       //   | |  -2
	     bst.put(8, 8);       //   | |   |-null
	     bst.put(3, 3);       //   | |    -null
	     bst.put(1, 1);       //   |  -6
	     bst.put(2, 2);       //   |   |-4
	     bst.put(6, 6);       //   |   | |-null
	     bst.put(4, 4);       //   |   |  -5
	     bst.put(5, 5);       //   |   |   |-null
	                          //   |   |    -null
	                          //   |    -null
	                          //    -8
	                          //     |-null
	                          //      -null
	     
	     String result = 
	      "-7\n" +
	      " |-3\n" + 
	      " | |-1\n" +
	      " | | |-null\n" + 
	      " | |  -2\n" +
	      " | |   |-null\n" +
	      " | |    -null\n" +
	      " |  -6\n" +
	      " |   |-4\n" +
	      " |   | |-null\n" +
	      " |   |  -5\n" +
	      " |   |   |-null\n" +
	      " |   |    -null\n" +
	      " |    -null\n" +
	      "  -8\n" +
	      "   |-null\n" +
	      "    -null\n";
	     assertEquals("Checking pretty printing of non-empty tree", result, bst.prettyPrintKeys());
	}

	/**
	 * <p>
	 * Test {@link BST#delete(Comparable)}.
	 * </p>
	 */
	@Test
	public void testDelete() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		bst.delete(1);
		assertEquals("Deleting from empty tree", "()", bst.printKeysInOrder());

		bst.put(7, 7); // _7_
		bst.put(8, 8); // / \
		bst.put(3, 3); // _3_ 8
		bst.put(1, 1); // / \
		bst.put(2, 2); // 1 6
		bst.put(6, 6); // \ /
		bst.put(4, 4); // 2 4
		bst.put(5, 5); // \
						// 5

		assertEquals("Checking order of constructed tree", "(((()1(()2()))3((()4(()5()))6()))7(()8()))",
				bst.printKeysInOrder());

		bst.delete(9);
		assertEquals("Deleting non-existent key", "(((()1(()2()))3((()4(()5()))6()))7(()8()))", bst.printKeysInOrder());

		bst.delete(8);
		assertEquals("Deleting leaf", "(((()1(()2()))3((()4(()5()))6()))7())", bst.printKeysInOrder());

		bst.delete(6);
		assertEquals("Deleting node with single child", "(((()1(()2()))3(()4(()5())))7())", bst.printKeysInOrder());

		bst.delete(3);
		assertEquals("Deleting node with two children", "(((()1())2(()4(()5())))7())", bst.printKeysInOrder());
		
		bst = new BST<Integer, Integer>();
		bst.put(7, 7); // _7_
		bst.put(8, 8); // / \
		bst.delete(1);
		assertEquals("", "(()7(()8()))", bst.printKeysInOrder());
	}

}
